use std::ops::*;
use std::simd::*;

#[derive(Debug)]
pub struct Matrix<T> {
  pub base: usizex2,
  pub size: usizex2,
  pub cells: Vec<T>,
}

impl<T> Index<usizex2> for Matrix<T> {
  type Output = T;

  fn index(&self, xy: usizex2) -> &Self::Output {
    let xy = xy - self.base;
    &self.cells[xy[0] + xy[1] * self.size[0]]
  }
}

impl<T> IndexMut<usizex2> for Matrix<T> {
  fn index_mut(&mut self, xy: usizex2) -> &mut Self::Output {
    let xy = xy - self.base;
    &mut self.cells[xy[0] + xy[1] * self.size[0]]
  }
}

impl<T: Copy> Matrix<T> {
  pub fn new(base: usizex2, size: usizex2, fill: T) -> Self {
    let cells = std::iter::repeat(fill).take(size.reduce_product()).collect();
    Self { base, size, cells }
  }
}

// impl<T> Matrix<T> {
//   pub fn get(&self, xy: usizex2) -> Option<&T> {
//     self.to_index(xy).map(|i| &self.cells[i])
//   }

//   pub fn get_mut(&mut self, xy: usizex2) -> Option<&mut T> {
//     self.to_index(xy).map(|i| &mut self.cells[i])
//   }

//   fn to_index(&self, xy: usizex2) -> Option<usize> {
//     if xy.simd_ge(self.base).all() {
//       let xy = xy - self.base;
//       if xy.simd_lt(self.size).all() {
//         return Some(xy[0] + xy[1] * self.size[0]);
//       }
//     }
//     None
//   }
// }
