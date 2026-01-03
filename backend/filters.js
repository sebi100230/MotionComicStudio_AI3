const warningTerms = [
  "batman",
  "dragon ball",
  "goku",
  "vegeta",
  "naruto",
  "one piece",
  "marvel",
  "dc"
];

export function analyzeContent(pages) {
  const combined = pages.join(" ").toLowerCase();

  const warnings = warningTerms.filter(term =>
    combined.includes(term)
  );

  return {
    warnings,
    hasWarnings: warnings.length > 0
  };
}
