util ← •Import "util.bqn"

Rearrange ← {stacks‿instructions‿F:
  {amount‿s‿d:
    src‿dst ← s‿d⊏stacks
    stacks ⟨amount↓src, (F amount↑src)∾dst⟩⌾(s‿d⊸⊏) ↩
  }¨instructions
  stacks
}

Solve ⇐ {
  stacks‿instructions ← util.SplitOnEmpty 𝕩
  stacks {{𝕩≥'A'}⊸/¨ {1=4|↕≠𝕩}⊸/ <˘⍉> 35↑¨ 𝕩} ↩
  instructions {-⟜0‿1‿1¨ util.UInt¨¨ {(1=2|↕≠𝕩)/𝕩}¨ util.SplitOn⟜' '¨ 𝕩} ↩

  part1 ← ∾1↑¨ Rearrange stacks‿instructions‿⌽
  part2 ← ∾1↑¨ Rearrange stacks‿instructions‿⊢
  part1‿part2
}
