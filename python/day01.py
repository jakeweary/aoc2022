with open('.input/day01', 'r') as f:
  text = f.read()

groups = text.split('\n\n')
totals = list(sum(map(int, g.split())) for g in groups)
totals.sort(reverse=True)

part1 = totals[0]
part2 = sum(totals[:3])

print("day01:", part1, part2)
