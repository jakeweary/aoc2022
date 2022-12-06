input ← •FLines "../.input/day01"

blocks ← {𝕩⊔˜(⊢-˜+`×¬)0=≠¨𝕩} input # split on empty
blocks ↩ {{𝕨+𝕩×10}´⌽𝕩-'0'}¨¨ blocks # parse numbers
totals ← ∨+´¨blocks

•Out "day01: " ∾ •Fmt ⟨⊑totals, +´3↑totals⟩
