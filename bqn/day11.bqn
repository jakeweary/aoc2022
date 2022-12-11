util ← •Import "util.bqn"

Op ← {
  "*"‿"old": ×˜ ;
  "+"‿x: +⟜(util.UInt x) ;
  "*"‿x: ×⟜(util.UInt x)
}

Monkey ← {·‿a‿b‿c‿d‿e:
  items ⇐ util.UInts 18↓a
  op ⇐ Op util.SplitOn⟜' ' 23↓b
  test ⇐ util.UInt 21↓c
  throw ⇐ util.UInt¨ ⟨30↓e, 29↓d⟩
  •Show items‿op‿test‿throw
}

Solve ⇐ {
  # monkeys ← Monkey¨ util.SplitOnEmpty 𝕩
  # todo
}
