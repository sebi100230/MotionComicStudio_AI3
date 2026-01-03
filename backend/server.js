import express from "express";
import cors from "cors";
import OpenAI from "openai";
import { analyzeContent } from "./filters.js";

const app = express();
app.use(cors());
app.use(express.json());

const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY
});

app.post("/generate-script", async (req, res) => {
  const { pages } = req.body;

  if (!isLegalContent(pages)) {
    return res.status(403).json({
      error: "Copyrighted or restricted content detected."
    });
  }

  const prompt = `
Create a short movie script based on these original comic pages.
Add dialogue, camera movement, and scene descriptions.

Pages:
${pages.join("\n")}
`;

  try {
    const completion = await openai.chat.completions.create({
      model: "gpt-4o-mini",
      messages: [{ role: "user", content: prompt }]
    });

    res.json({
      script: completion.choices[0].message.content
    });
  } catch (err) {
    res.status(500).json({ error: "AI generation failed" });
  }
});

app.listen(3000, () => {
  console.log("AI server running on port 3000");
});
