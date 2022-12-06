module Day06 (solve) where

import Control.Applicative (ZipList (..))
import Control.Arrow (Arrow (..))
import Data.List (findIndex, nub, tails)
import Data.Maybe (fromJust)
import Data.Text qualified as T

solve :: T.Text -> IO (Int, Int)
solve = return . (marker 4 &&& marker 14)
  where
    marker n = (+ n) . fromJust . findIndex ((== n) . length . nub) . windows n
    windows n = getZipList . traverse ZipList . take n . tails . T.unpack . T.stripEnd
