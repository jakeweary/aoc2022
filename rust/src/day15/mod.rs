use std::simd::*;

fn parse_line(line: &str) -> Option<(i64x2, i64x2)> {
  let parse_xy = |xy: &str| {
    let (_, xy) = xy.split_once("at ")?;
    let (x, y) = xy.split_once(", ")?;
    let x = x[2..].parse().ok()?;
    let y = y[2..].parse().ok()?;
    Some([x, y])
  };

  let (sensor, beacon) = line.split_once(": ")?;
  let sensor = parse_xy(sensor)?.into();
  let beacon = parse_xy(beacon)?.into();
  Some((sensor, beacon))
}

fn range_length(range: i64x2) -> i64 {
  range[1] - range[0]
}

fn merge_ranges(a: i64x2, b: i64x2) -> Option<i64x2> {
  (a[1] >= b[0]).then(|| [a[0], a[1].max(b[1])].into())
}

fn merge_all_ranges(mut ranges: impl Iterator<Item = i64x2>) -> (i64, i64x2) {
  let first = ranges.next().unwrap();
  ranges.fold((0, first), |(length, merged), range| {
    let (add_length, merged) = merge_ranges(merged, range)
      .map_or_else(|| (range_length(merged), range), |merged| (0, merged));
    (length + add_length, merged)
  })
}

fn find_all_sensor_ranges_on_line(
  line_y: i64,
  sensor_beacon_pairs: &[(i64x2, i64x2)],
  buffer: &mut Vec<i64x2>,
) {
  sensor_beacon_pairs
    .iter()
    .filter_map(|(sensor, beacon)| {
      // manhattan distance to beacon and to y-th line
      let dist_b = (sensor - beacon).abs().reduce_sum();
      let dist_y = (sensor[1] - line_y).abs();
      (dist_b >= dist_y).then(|| {
        let center = sensor[0];
        let radius = dist_b - dist_y;
        i64x2::from([center - radius, center + radius])
      })
    })
    .collect_into(buffer);

  buffer.sort_unstable();
}

pub fn solve(input: &str) -> [i64; 2] {
  let sensor_beacon_pairs = input
    .lines()
    .map(parse_line)
    .collect::<Option<Vec<_>>>()
    .unwrap();

  // gets reused to save ~4_000_000 allocations
  let mut ranges = Vec::new();

  let part1 = {
    let y = 2_000_000;
    find_all_sensor_ranges_on_line(y, &sensor_beacon_pairs, &mut ranges);
    let (merged_positions, last_range) = merge_all_ranges(ranges.drain(..));
    let total_positions = merged_positions + range_length(last_range);
    total_positions
  };

  let part2 = 'part2: {
    let limit = 4_000_000;
    for y in 0..=limit {
      find_all_sensor_ranges_on_line(y, &sensor_beacon_pairs, &mut ranges);
      let (merged_positions, last_range) = merge_all_ranges({
        let lo = i64x2::splat(0);
        let hi = i64x2::splat(limit);
        ranges.drain(..).map(move |r| r.simd_max(lo).simd_min(hi))
      });
      let total_positions = merged_positions + range_length(last_range);
      if total_positions < limit {
        let x = last_range[0] - 1;
        break 'part2 limit * x + y;
      }
    }
    unreachable!()
  };

  [part1, part2]
}
