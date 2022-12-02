fn parse_hand(input: u8) -> i32 {
  match input {
    b'A' | b'X' => 0,
    b'B' | b'Y' => 1,
    b'C' | b'Z' => 2,
    _ => panic!(),
  }
}

fn parse_shift(input: u8) -> i32 {
  match input {
    b'X' => 2,
    b'Y' => 0,
    b'Z' => 1,
    _ => panic!(),
  }
}

fn score(me: i32, enemy: i32) -> i32 {
  match (3 + enemy - me) % 3 {
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

    let me = parse_hand(rhs);
    let enemy = parse_hand(lhs);
    part1 += 1 + me + score(me, enemy);

    let shift = parse_shift(rhs);
    let me = (enemy + shift) % 3;
    part2 += 1 + me + score(me, enemy);
  }

  println!("day02: {} {}", part1, part2);
}
