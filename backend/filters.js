const bannedWords = [
  "marvel",
  "dc",
  "batman",
  "spiderman",
  "naruto",
  "one piece",
  "dragon ball"
];

export function isLegalContent(pages) {
  const combined = pages.join(" ").toLowerCase();
  return !bannedWords.some(word => combined.includes(word));
}
