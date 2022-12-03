module Day03 (solve) where

import Data.Char (isAsciiLower, isAsciiUpper, ord)
import Data.List (intersect)
import Data.List.Split (chunksOf)
import Data.Text qualified as T

solve :: T.Text -> IO (Int, Int)
solve input = return (part1, part2)
  where
    part1 = score $ head . uncurry intersect . split <$> lines'
    part2 = score $ head . foldl1 intersect <$> chunksOf 3 lines'
    lines' = T.unpack <$> T.lines input
    split line = splitAt (length line `div` 2) line
    score = sum . map priority
    priority item
      | isAsciiLower item = ord item - ord 'a' + 1
      | isAsciiUpper item = ord item - ord 'A' + 27
      | otherwise = undefined
