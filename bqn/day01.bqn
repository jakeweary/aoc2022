input ← •FLines "../.input/day01"

blocks ← {𝕩⊔˜(⊢-˜+`×¬)0=≠¨𝕩} input # split on empty
blocks ↩ {{𝕨+𝕩×10}´⌽𝕩-'0'}¨¨ blocks # parse numbers
totals ← ∨+´¨blocks

part1 ← ⊑totals
part2 ← +´3↑totals

•Out "day01: " ∾ •Fmt part1‿part2
