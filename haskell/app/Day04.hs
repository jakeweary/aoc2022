module Day04 (solve) where

import Data.List.Split (splitOneOf)
import Data.Text qualified as T

solve :: T.Text -> IO (Int, Int)
solve input = return (part1, part2)
  where
    part1 = sum . map fromEnum $ uncurry fullOverlap <$> lines'
    part2 = sum . map fromEnum $ uncurry someOverlap <$> lines'

    fullOverlap (a, b) (x, y) = overlap (a, b) (x, y) == min (b - a) (y - x)
    someOverlap (a, b) (x, y) = overlap (a, b) (x, y) /= 0
    overlap (a, b) (x, y) = max 0 (min b y - max a x)

    lines' = toRanges . parseLine <$> T.lines input
      where
        parseLine = map (read @Int) . splitOneOf ",-" . T.unpack
        toRanges [a, b, x, y] = ((a, b + 1), (x, y + 1))
        toRanges _ = undefined
