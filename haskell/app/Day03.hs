module Day03 (solve) where

import Data.Char (isAsciiLower, isAsciiUpper, ord)
import Data.List.Split (chunksOf)
import Data.Set qualified as S
import Data.Text qualified as T

solve :: T.Text -> IO (Int, Int)
solve input = return (part1, part2)
  where
    part1 = score $ common . split <$> lines'
    part2 = score $ common <$> chunksOf 3 lines'
    lines' = T.lines input
    common = head . S.toList . foldl1 S.intersection . map (S.fromList . T.unpack)
    split line = T.chunksOf (T.length line `div` 2) line
    score = sum . map priority
    priority x
      | isAsciiLower x = ord x - ord 'a' + 1
      | isAsciiUpper x = ord x - ord 'A' + 27
      | otherwise = undefined
