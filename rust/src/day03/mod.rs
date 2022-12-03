fn priority(item: u8) -> u8 {
  match item {
    b'a'..=b'z' => item - b'a',
    b'A'..=b'Z' => item - b'A' + 26,
    _ => panic!(),
  }
}

fn freq<const N: usize>(group: [&str; N]) -> [[u8; N]; 52] {
  let mut freq = [[0; N]; 52];
  for (i, items) in group.into_iter().enumerate() {
    for item in items.bytes() {
      freq[priority(item) as usize][i] += 1;
    }
  }
  freq
}

fn common<const N: usize>(group: [&str; N]) -> u32 {
  freq(group)
    .into_iter()
    .enumerate()
    .find_map(|(i, f)| f.iter().all(|&n| n > 0).then(|| i as u32 + 1))
    .unwrap()
}

pub fn solve(input: &str) -> [u32; 2] {
  let part1 = input
    .lines()
    .map(|line| line.split_at(line.len() / 2))
    .map(|(a, b)| [a, b])
    .map(common)
    .sum();

  let part2 = input
    .lines()
    .array_chunks::<3>()
    .map(common)
    .sum();

  [part1, part2]
}
