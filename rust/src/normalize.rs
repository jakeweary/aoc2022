pub trait Normalize<A, B> {
  fn normalize(self) -> (A, B);
}

impl<A, B> Normalize<A, B> for (A, B) {
  fn normalize(self) -> (A, B) {
    self
  }
}

impl<A: Copy> Normalize<A, A> for [A; 2] {
  fn normalize(self) -> (A, A) {
    let [a, b] = self;
    (a, b)
  }
}
