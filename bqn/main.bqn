Run ← {
  day ← •Import ∾𝕩‿".bqn"
  input ← •file.Lines ∾•wdpath‿"/.input/"‿𝕩
  t1 ← •MonoTime@
  p1‿p2 ← •Repr¨ day.Solve input
  t2 ← •MonoTime@
  •Out ∾𝕩‿": "‿p1‿" "‿p2‿" ("‿(8↑ •Repr t2-t1)‿"s)"
}

Run¨ ⟨
  "day01"
  "day02"
  "day05"
  "day06"
  "day08"
  "day10"
⟩
