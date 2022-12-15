use matrix::*;
use std::simd::*;
use State::*;

mod matrix;

#[derive(Debug, Clone, Copy)]
enum State { Empty, Rock, Sand }

impl Matrix<State> {
  fn from_paths(paths: &[Vec<usizex2>]) -> Self {
    let min = [usize::MAX, 0].into();
    let max = [usize::MIN, usize::MIN].into();
    let (min, max) = paths.iter().flatten().fold((min, max), |(min, max), x| {
      (x.simd_min(min), x.simd_max(max))
    });

    let base = min - usizex2::from([1, 0]);
    let size = max + usizex2::from([3, 1]) - min;
    let mut matrix = Self::new(base, size, Empty);

    for path in paths {
      for &[a, b] in path.array_windows() {
        let min = a.simd_min(b);
        let max = a.simd_max(b);
        for x in min[0]..=max[0] {
          for y in min[1]..=max[1] {
            matrix[[x, y].into()] = Rock;
          }
        }
      }
    }

    matrix
  }

  fn drop_sand(&mut self) -> Option<usizex2> {
    let mut xy = [500, 0].into();

    let Empty = self[xy] else {
      return None;
    };

    for _ in 1..self.size[1] {
      let d = xy + usizex2::from([0, 1]); // down
      let dl = d - usizex2::from([1, 0]); // down left
      let dr = d + usizex2::from([1, 0]); // down right
      match (self[d], self[dl], self[dr]) {
        (Empty, _, _) => xy = d,
        (_, Empty, _) => xy = dl,
        (_, _, Empty) => xy = dr,
        _ => {
          self[xy] = Sand;
          return Some(xy);
        }
      }
    }

    None
  }

  fn drop_sand_and_count(&mut self) -> usize {
    std::iter::from_fn(|| self.drop_sand()).count()
  }
}

fn parse_rock_paths(input: &str) -> Option<Vec<Vec<usizex2>>> {
  input
    .lines()
    .map(|line| {
      line
        .split(" -> ")
        .map(|xy| {
          let (x, y) = xy.split_once(',')?;
          let x = x.parse().ok()?;
          let y = y.parse().ok()?;
          Some(usizex2::from([x, y]))
        })
        .collect()
    })
    .collect()
}

pub fn solve(input: &str) -> [usize; 2] {
  let mut paths = parse_rock_paths(input).unwrap();

  let part1 = Matrix::from_paths(&paths).drop_sand_and_count();
  let part2 = {
    let floor_y = 2 + paths.iter().flatten().map(|xy| xy[1]).max().unwrap();
    let floor_x = [500 - floor_y, 500 + floor_y];
    paths.push(floor_x.map(|x| [x, floor_y].into()).into());
    Matrix::from_paths(&paths).drop_sand_and_count()
  };

  [part1, part2]
}

// ---

impl std::fmt::Display for Matrix<State> {
  fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
    f.write_str("\x1b[?25l")?;
    for y in (0..self.size[1]).step_by(2) {
      for x in 0..self.size[0] {
        let color = |x| match x { Empty => 0, Rock => 4, Sand => 3 };
        let bg = color(self[self.base + usizex2::from([x, y])]);
        let fg = color(self[self.base + usizex2::from([x, y + 1])]);
        f.write_fmt(format_args!("\x1b[4{};3{}m▄", bg, fg))?;
      }
      f.write_str("\x1b[0m\n")?;
    }
    f.write_str("\x1b[?25h")?;
    Ok(())
  }
}
