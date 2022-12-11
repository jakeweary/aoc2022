#[derive(Debug, Clone, Copy)]
pub enum Op<T> {
  Square,
  Mul(T),
  Add(T),
}

#[derive(Debug, Clone)]
pub struct Monkey {
  pub items: Vec<u64>,
  pub op: Op<u64>,
  pub test: u64,
  pub throw: [usize; 2],
  pub inspected: u64,
}

impl Monkey {
  pub fn parse(input: &str) -> Option<Self> {
    let mut lines = input.lines().skip(1);

    let items = lines.next()?[18..]
      .split(", ")
      .map(|n| n.parse().ok())
      .collect::<Option<_>>()?;

    let op = match lines.next()?[23..].split_once(' ')? {
      ("*", "old") => Op::Square,
      ("*", x) => Op::Mul(x.parse().ok()?),
      ("+", x) => Op::Add(x.parse().ok()?),
      _ => panic!(),
    };

    let test = lines.next()?[21..].parse().ok()?;
    let if_1 = lines.next()?[29..].parse().ok()?;
    let if_0 = lines.next()?[30..].parse().ok()?;

    Some(Self {
      items,
      op,
      test,
      throw: [if_0, if_1],
      inspected: 0,
    })
  }
}
