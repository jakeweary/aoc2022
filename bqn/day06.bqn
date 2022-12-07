FindMarker ← {
  windows ← 𝕩↕𝕨
  uniques ← (≠⍷)˘ windows
  𝕩 + ⊑uniques⊐𝕩
}

Solve ⇐ {
  input ← ⊑ •FLines 𝕩
  ⟨ input FindMarker 4
    input FindMarker 14 ⟩
}
