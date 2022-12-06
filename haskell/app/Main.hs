module Main (main) where

import Data.Text.IO qualified as T
import Text.Printf (printf)

import Day03 qualified
import Day04 qualified
import Day05 qualified
import Day06 qualified

main :: IO ()
main = do
  day Day03.solve "day03"
  day Day04.solve "day04"
  day Day05.solve "day05"
  day Day06.solve "day06"
  where
    day solve name = do
      input <- T.readFile $ ".input/" ++ name
      output <- solve input
      uncurry (printf "%s: %v %v\n" name) output
