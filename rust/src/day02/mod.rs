pub fn solve(input: &str) -> [u32; 2] {
  input
    .lines()
    .map(|line| {
      let [a, _, b] = line.as_bytes() else { panic!() };
      let a = a - b'A';
      let b = b - b'X';
      std::simd::u32x2::from([
        ((4 + b - a) % 3 * 3 + b + 1) as u32,
        ((2 + b + a) % 3 + 3 * b + 1) as u32,
      ])
    })
    .sum::<std::simd::u32x2>()
    .into()
}
