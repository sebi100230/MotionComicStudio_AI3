import express from "express";
import cors from "cors";
import OpenAI from "openai";
import { analyzeContent } from "./filters.js"; // Import the safe analyzer

const app = express();
app.use(cors());
app.use(express.json());

// Initialize OpenAI with API key from environment variable
const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY
});

// Route to generate motion comic script
app.post("/generate-script", async (req, res) => {
  const { pages } = req.body;

  // Analyze content for copyrighted/brand references (warnings)
  const analysis = analyzeContent(pages);

  // Build AI prompt
  const prompt = `
Create a short motion comic script based on these original comic pages.
Include dialogue, scene descriptions, and camera movement.

Pages:
${pages.join("\n")}
`;

  try {
    // Generate AI script
    const completion = await openai.chat.completions.create({
      model: "gpt-4o-mini",
      messages: [{ role: "user", content: prompt }]
    });

    // Return script + warnings
    res.json({
      script: completion.choices[0].message.content,
      warnings: analysis.warnings
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "AI generation failed" });
  }
});

// Optional: TTS / voice generation route
app.post("/voice", async (req, res) => {
  const { text } = req.body;

  try {
    const speech = await openai.audio.speech.create({
      model: "gpt-4o-mini-tts",
      voice: "alloy",
      input: text
    });

    res.setHeader("Content-Type", "audio/mpeg");
    res.send(Buffer.from(await speech.arrayBuffer()));
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Voice generation failed" });
  }
});

// Start server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`AI server running on port ${PORT}`);
});
