Solve ⇐ {
  trees ← >𝕩-'0'
  rows ← trees
  cols ← ⍉trees

  SplitAt ← {⟨⌽𝕩↑𝕨, 1↓𝕩↓𝕨⟩}
  IsVisible ← {𝕩>⌊´⌈´¨𝕨}
  ScenicScore ← {×´{(≠𝕩)⌊1+⊑𝕩⊐1}¨𝕩≤𝕨}

  Enumerate ← {𝕩∾¨↕≢𝕩}
  Fold ← {a‿x𝕊b‿y: ⟨a+b, x⌈y⟩}
  Map ← {𝕊height‿y‿x:
    row‿col ← ⟨y⊏rows, x⊏cols⟩
    l‿r ← row SplitAt x # left right
    u‿d ← col SplitAt y # up down
    ⟨ l‿r‿u‿d IsVisible height
      l‿r‿u‿d ScenicScore height ⟩
  }

  Fold´Map¨⥊Enumerate trees
}
