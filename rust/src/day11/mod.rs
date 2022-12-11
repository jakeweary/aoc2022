mod monkey;

fn round(monkeys: &mut [monkey::Monkey]) {
  let mut throws = Vec::new();

  for m in 0..monkeys.len() {
    let monkey = &mut monkeys[m];
    monkey.inspected += monkey.items.len() as u32;

    for item in monkey.items.drain(..) {
      let item = match monkey.op {
        monkey::Op::Square => item * item,
        monkey::Op::Mul(n) => item * n,
        monkey::Op::Add(n) => item + n,
      };
      let item = item / 3;
      let is_divisible = item % monkey.test == 0;
      let throw_to = monkey.throw[is_divisible as usize];
      throws.push((throw_to, item));
    }

    for (m, item) in throws.drain(..) {
      monkeys[m].items.push(item);
    }
  }
}

pub fn solve(input: &str) -> [u32; 2] {
  let mut monkeys = input
    .trim_end()
    .split("\n\n")
    .map(monkey::Monkey::parse)
    .collect::<Option<Vec<_>>>()
    .unwrap();

  for _ in 0..20 {
    round(&mut monkeys);
  }

  monkeys.sort_unstable_by_key(|m| m.inspected);
  monkeys.reverse();

  let part1 = monkeys[..2].iter().map(|m| m.inspected).product::<u32>();

  [part1, 0]
}
