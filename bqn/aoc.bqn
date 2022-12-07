Run ← {
  day ← •Import 𝕩∾".bqn"
  t1 ← •MonoTime@
  p1‿p2 ← •Repr¨ day.Solve ∾•wdpath‿"/.input/"‿𝕩
  t2 ← •MonoTime@
  •Out ∾𝕩‿": "‿p1‿" "‿p2‿" ("‿(8↑ •Repr t2-t1)‿"s)"
}

Run¨ ⟨
  "day01"
  "day02"
  "day06"
⟩
