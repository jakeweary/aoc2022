pub fn solve() {
  let input = std::fs::read_to_string(".input/day02").unwrap();

  let mut part1 = 0;
  let mut part2 = 0;

  for line in input.lines() {
    let [a, _, b] = line.as_bytes() else { panic!() };
    let a = a - b'A';
    let b = b - b'X';
    part1 += ((4 + b - a) % 3 * 3 + b + 1) as u32;
    part2 += ((2 + b + a) % 3 + 3 * b + 1) as u32;
  }

  println!("day02: {} {}", part1, part2);
}
