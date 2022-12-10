UInt ⇐ {{𝕨+𝕩×10}´⌽𝕩-'0'}
Int ⇐ {'-'=⊑𝕩 ? -UInt 1↓𝕩 ; UInt 𝕩}

SplitOn ⇐ {𝕩((⊢-˜+`×¬)∘=⊔⊢)𝕨}
SplitOnEmpty ⇐ {𝕩⊔˜(⊢-˜+`×¬)0=≠¨𝕩}
