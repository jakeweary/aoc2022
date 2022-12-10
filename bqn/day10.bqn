util ← •Import "util.bqn"

Map ← {
  "addx" ≡ 4↑𝕩 ? 0 ∾ util.Int 5↓𝕩 ;
  "noop" ≡   𝕩 ? 0
}

Solve ⇐ {
  executed ← ⌽1↓⌽ +` 1∾ ∾Map¨ 𝕩
  enumerated ← >{𝕩∾˜¨ 1+ ↕≠𝕩} executed

  part1 ← +´ ×´˘ (20=40|⊑)˘⊸/ enumerated
  part2 ← ⊑⟜".#"¨ 1≥ ∘‿40⥊ {i‿x:|x-40|i-1}˘ enumerated
  •Show part2

  part1‿0
}
