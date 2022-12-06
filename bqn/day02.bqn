input ← •FLines "../.input/day02"

Score ← {
  a‿·‿b ← 𝕩-"A X"
  x ← (1+b) + (3×3|4+b-a)
  y ← (1+3|2+b+a) + (3×b)
  x‿y
}

•Out "day02: " ∾ •Fmt +´Score¨input
