Solve ⇐ {
  trees ← >𝕩-'0'
  rows ← trees
  cols ← ⍉trees

  Map ← {
    height‿y‿x ← 𝕩
    row‿col ← ⟨y⊏rows, x⊏cols⟩
    l‿r ← ⟨⌽x↑row, 1↓x↓row⟩ # left right
    u‿d ← ⟨⌽y↑col, 1↓y↓col⟩ # up down
    is_visible ← height > ⌊´⌈´¨l‿r‿u‿d
    scenic_score ← ×´{(≠𝕩)⌊1+⊑𝕩⊐1}¨ height ≤ l‿r‿u‿d
    is_visible‿scenic_score
  }

  Reduce ← {a‿x←𝕨, b‿y←𝕩, ⟨a+b, x⌈y⟩}

  Reduce´Map¨⥊{𝕩∾¨↕≢𝕩} trees
}
