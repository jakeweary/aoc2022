use monkey::*;

mod monkey;

fn round(monkeys: &mut [Monkey], f: impl Fn(u64) -> u64) {
  let mut throws = Vec::new();

  for m in 0..monkeys.len() {
    let monkey = &mut monkeys[m];
    monkey.inspected += monkey.items.len() as u64;

    for item in monkey.items.drain(..) {
      let n = match monkey.op {
        Op::Square => item * item,
        Op::Mul(n) => item * n,
        Op::Add(n) => item + n,
      };
      let n = f(n);
      let is_divisible = n % monkey.test == 0;
      let throw_to = monkey.throw[is_divisible as usize];
      throws.push((throw_to, n));
    }

    for (m, item) in throws.drain(..) {
      monkeys[m].items.push(item);
    }
  }
}

fn monkey_business_score(monkeys: &mut [Monkey]) -> u64 {
  monkeys.sort_unstable_by_key(|m| m.inspected);
  monkeys.reverse();
  monkeys[..2].iter().map(|m| m.inspected).product()
}

pub fn solve(input: &str) -> [u64; 2] {
  let monkeys = input
    .trim_end()
    .split("\n\n")
    .map(Monkey::parse)
    .collect::<Option<Vec<_>>>()
    .unwrap();

  let part1 = {
    let mut monkeys = monkeys.clone();
    for _ in 0..20 {
      round(&mut monkeys, |n| n / 3);
    }
    monkey_business_score(&mut monkeys)
  };

  let part2 = {
    let mut monkeys = monkeys.clone();
    let modulo = monkeys.iter().map(|m| m.test).product::<u64>();
    for _ in 0..10_000 {
      round(&mut monkeys, |n| n % modulo);
    }
    monkey_business_score(&mut monkeys)
  };

  [part1, part2]
}
