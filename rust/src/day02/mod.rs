fn score(me: u8, enemy: u8) -> u32 {
  1 + me as u32 + match (3 + enemy - me) % 3 {
    0 => 3,
    1 => 0,
    2 => 6,
    _ => panic!()
  }
}

pub fn solve() {
  let input = std::fs::read_to_string(".input/day02").unwrap();

  let mut part1 = 0;
  let mut part2 = 0;

  for line in input.lines() {
    let &[lhs, _, rhs] = line.as_bytes() else { panic!() };
    let lhs = lhs - b'A';
    let rhs = rhs - b'X';
    part1 += score(rhs, lhs);
    part2 += score((rhs + lhs + 2) % 3, lhs);
  }

  println!("day02: {} {}", part1, part2);
}
