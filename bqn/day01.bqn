Solve ⇐ {
  input ← 𝕩
  input {𝕩⊔˜(⊢-˜+`×¬)0=≠¨𝕩} ↩ # split on empty
  input {{𝕨+𝕩×10}´⌽𝕩-'0'}¨¨ ↩ # parse numbers

  totals ← ∨+´¨input

  ⟨ ⊑totals, +´3↑totals ⟩
}
