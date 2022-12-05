module Main (main) where

import Data.Text.IO qualified as T
import Text.Printf (printf)

import Day03 qualified
import Day04 qualified

main :: IO ()
main = do
  day Day03.solve "day03"
  day Day04.solve "day04"
  where
    day solve name = do
      input <- T.readFile $ ".input/" ++ name
      output <- solve input
      uncurry (printf "%s: %v %v\n" name) output
