Run ← {
  day ← •Import 𝕩∾".bqn"
  a‿b ← •Repr¨ day.Solve ∾•wdpath‿"/.input/"‿𝕩
  •Out ∾𝕩‿": "‿a‿" "‿b
}

Run¨ ⟨
  "day01"
  "day02"
  "day06"
⟩
