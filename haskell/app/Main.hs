module Main where

import Day03 qualified
import Text.Printf (printf)

solve :: (String -> IO (Int, Int)) -> String -> IO ()
solve fn name = do
  input <- readFile $ ".input/" ++ name
  output <- fn input
  uncurry (printf "%s: %d %d\n" name) output

main :: IO ()
main = do
  solve Day03.solve "day03"
