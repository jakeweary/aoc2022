Run ← {
  day ← •Import 𝕩∾".bqn"
  p1‿p2 ← •Fmt¨ day.Solve "../.input/"∾𝕩
  •Out ∾𝕩‿": "‿p1‿" "‿p2
}

Run¨ ⟨
  "day01"
  "day02"
⟩
