module Day03 (solve) where

import Data.Char (isAsciiLower, isAsciiUpper, ord)
import Data.List.Split (chunksOf)
import Data.Set qualified as Set

solve :: String -> IO (Int, Int)
solve input = return (part1, part2)
  where
    part1 = sum . map priority $ common . split <$> lines'
    part2 = sum . map priority $ common <$> chunksOf 3 lines'
    lines' = lines input
    common = head . Set.toList . foldl1 Set.intersection . map Set.fromList
    split xs = let mid = length xs `div` 2 in [take mid xs, drop mid xs]
    priority x
      | isAsciiLower x = ord x - ord 'a' + 1
      | isAsciiUpper x = ord x - ord 'A' + 27
      | otherwise = undefined
