use std::collections::HashMap;

type Dir<'a> = HashMap<&'a str, Node<'a>>;
enum Node<'a> { Dir(Dir<'a>), File { size: u32 } }

fn parse<'a>(input: &'a str) -> Option<Dir<'a>> {
  let mut stack = Vec::<(&'a str, Dir<'a>)>::new();

  for line in input.lines() {
    let mut tokens = line.split_ascii_whitespace();
    match (tokens.next()?, tokens.next()?, tokens.next()) {
      ("$", "cd", Some("..")) => {
        let (name, dir) = stack.pop()?;
        stack.last_mut()?.1.insert(name, Node::Dir(dir));
      }
      ("$", "cd", Some(name)) => stack.push((name, Dir::new())),
      ("$", ..) => {}
      ("dir", ..) => {}
      (size, name, None) => {
        let size = size.parse().ok()?;
        stack.last_mut()?.1.insert(name, Node::File { size });
      }
      _ => panic!(),
    }
  }

  let (_, dir) = stack.into_iter().rev().reduce(|(name, dir), mut acc| {
    acc.1.insert(name, Node::Dir(dir));
    acc
  })?;

  Some(dir)
}

fn dir_sizes(dir: &Dir<'_>) -> Vec<u32> {
  fn visit(dir: &Dir<'_>, sizes: &mut Vec<u32>) -> u32 {
    let size = dir
      .iter()
      .map(|(_, node)| match node {
        Node::Dir(dir) => visit(dir, sizes),
        Node::File { size } => *size,
      })
      .sum();

    sizes.push(size);
    size
  }

  let mut sizes = Vec::new();
  visit(dir, &mut sizes);
  sizes.sort();
  sizes
}

pub fn solve(input: &str) -> [u32; 2] {
  let root = parse(input).unwrap();
  let sizes = dir_sizes(&root);

  let free = 70_000_000 - sizes.last().unwrap();
  let part1 = sizes.iter().take_while(|&&s| s <= 100_000).sum::<u32>();
  let part2 = sizes.into_iter().find(|&s| free + s >= 30_000_000).unwrap();

  [part1, part2]
}

// ---

fn _print_filesystem_tree(dir: &Dir<'_>) {
  fn visit(dir: &Dir<'_>, indent: &str) {
    for (i, (name, node)) in dir.iter().enumerate() {
      let append = match dir.len() - i {
        1 => ("└╴", "  "),
        _ => ("├╴", "│ "),
      };

      print!("{}{}", indent, append.0);
      match node {
        Node::Dir(dir) => {
          println!("\x1b[33m{}\x1b[0m", name);
          visit(dir, &(indent.to_owned() + append.1));
        }
        Node::File { size } => {
          let name_width = 30 - indent.chars().count();
          println!("\x1b[36m{:nw$}\x1b[0m{:8}", name, size, nw = name_width);
        }
      }
    }
  }

  println!("\x1b[33m{}\x1b[0m", '/');
  visit(dir, &"");
}
