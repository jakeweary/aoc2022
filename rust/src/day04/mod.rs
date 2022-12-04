use std::cmp::*;
use std::simd::*;

fn parse_range(range: &str) -> Option<(i32, i32)> {
  let (a, b) = range.split_once('-')?;
  Some((a.parse::<i32>().ok()?, b.parse::<i32>().ok()? + 1))
}

fn parse_line(line: &str) -> Option<((i32, i32), (i32, i32))> {
  let (a, b) = line.split_once(',')?;
  Some((parse_range(a)?, parse_range(b)?))
}

pub fn solve(input: &str) -> [u32; 2] {
  input
    .lines()
    .map(|line| {
      let ((a, b), (x, y)) = parse_line(line).unwrap();
      let max_possible_overlap = min(b - a, y - x);
      let overlap = max(0, min(b, y) - max(a, x));
      let part1 = overlap == max_possible_overlap;
      let part2 = overlap != 0;
      u32x2::from([part1 as u32, part2 as u32])
    })
    .sum::<u32x2>()
    .into()
}
