#![deny(rust_2018_idioms)]
#![feature(array_windows)]
#![feature(iter_array_chunks)]
#![feature(portable_simd)]

mod normalize;

use normalize::*;

macro_rules! aoc(($($day:ident)+) => {
  $(mod $day;)+

  fn main() {
    $({
      let path = concat!(".input/", stringify!($day));
      let input = std::fs::read_to_string(path).unwrap();

      let t1 = std::time::Instant::now();
      let (p1, p2) = $day::solve(&input).normalize();
      let t2 = std::time::Instant::now();

      println!("{}: {} {} ({:?})", stringify!($day), p1, p2, t2 - t1);
    })+
  }
});

aoc! {
  day01
  day02
  day03
  day04
  day07
  day11
  day14
}
