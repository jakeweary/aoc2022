use std::collections::HashMap;

#[derive(Debug)]
enum Node<'a> {
  Dir(Dir<'a>),
  File { size: u64 },
}

type Dir<'a> = HashMap<&'a str, Node<'a>>;

fn size(dir: &Dir<'_>) -> u64 {
  dir
    .iter()
    .map(|(_, node)| match node {
      Node::Dir(dir) => size(dir),
      Node::File { size } => *size,
    })
    .sum()
}

fn parse<'a>(input: &'a str) -> Option<Dir<'a>> {
  let mut stack = Vec::<(&'a str, Dir<'a>)>::new();

  for line in input.lines().chain(["$ cd .."]) {
    let mut tokens = line.split_ascii_whitespace();
    match (tokens.next()?, tokens.next()?, tokens.next()) {
      ("$", "cd", Some("..")) => {
        let (name, dir) = stack.pop()?;
        stack.last_mut()?.1.insert(name, Node::Dir(dir));
      }
      ("$", "cd", Some(name)) => stack.push((name, Dir::new())),
      ("$", ..) => {}
      ("dir", ..) => {}
      (token, name, None) => {
        let size = token.parse().ok()?;
        stack.last_mut()?.1.insert(name, Node::File { size });
      }
      _ => panic!(),
    }
  }

  stack.into_iter().next().map(|(_, dir)| dir)
}

pub fn solve(input: &str) -> [u64; 2] {
  todo!()
}
