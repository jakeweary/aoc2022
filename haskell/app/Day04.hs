module Day04 (solve) where

import Data.List.Split (splitOneOf)
import Data.Text qualified as T

solve :: T.Text -> IO (Int, Int)
solve input = return (part1, part2)
  where
    part1 = count $ uncurry fullOverlap <$> lines'
    part2 = count $ uncurry someOverlap <$> lines'
    count = sum . map fromEnum
    lines' = toRanges . parseLine <$> T.lines input
      where
        parseLine = map (read @Int) . splitOneOf ",-" . T.unpack
        toRanges [a, b, x, y] = ((a, b + 1), (x, y + 1))
        toRanges _ = undefined

fullOverlap, someOverlap :: (Ord a, Num a) => (a, a) -> (a, a) -> Bool
fullOverlap a b = overlap a b == maxPossibleOverlap a b
someOverlap a b = overlap a b /= 0

maxPossibleOverlap, overlap :: (Ord a, Num a) => (a, a) -> (a, a) -> a
maxPossibleOverlap (a, b) (x, y) = min (b - a) (y - x)
overlap (a, b) (x, y) = max 0 (min b y - max a x)
