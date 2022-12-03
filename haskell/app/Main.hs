module Main (main) where

import Data.Text.IO qualified as T
import Text.Printf (printf)

import Day03 qualified

main :: IO ()
main = do
  day Day03.solve "day03"
  where
    day solve name = do
      input <- T.readFile $! ".input/" ++ name
      output <- solve input
      uncurry (printf "%s: %d %d\n" name) output
