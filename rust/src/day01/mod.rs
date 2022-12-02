pub fn solve(input: &str) -> [u32; 2] {
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

  [part1, part2]
}
