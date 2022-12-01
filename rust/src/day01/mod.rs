pub fn solve() {
  let input = std::fs::read_to_string(".input/day01").unwrap();

  let mut totals = input
    .split("\n\n")
    .map(|items| {
      items
        .lines()
        .map(|item| item.parse::<u32>().ok())
        .try_fold(0, |a, b| Some(a + b?))
    })
    .collect::<Option<Vec<_>>>()
    .unwrap();

  totals.sort_unstable();
  totals.reverse();

  let part1 = totals[0];
  let part2 = totals[0..3].iter().sum::<u32>();

  println!("day01: {} {}", part1, part2);
}
