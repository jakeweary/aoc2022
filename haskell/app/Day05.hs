module Day05 (solve) where

import Data.Array.IO qualified as A
import Data.Foldable (forM_)
import Data.List.Split (chunksOf, splitOn)
import Data.Text qualified as T
import Data.Text.Read qualified as T

type Stack = T.Text
data Instruction = Move {amt, src, dst :: Int}

parseStacks :: [T.Text] -> [Stack]
parseStacks = map (T.stripStart . T.init . (!! 1)) <$> chunksOf 4 . T.transpose

parseInstructions :: [T.Text] -> [Instruction]
parseInstructions = map $ fromList . map (fmap fst . T.decimal) . T.splitOn " "
  where
    fromList [_, Right amt, _, Right src, _, Right dst] = Move {amt, src, dst}
    fromList _ = undefined

rearrange :: [Stack] -> [Instruction] -> (Stack -> Stack) -> IO [Stack]
rearrange stacks instructions f = do
  stacks' <- A.newListArray (1, length stacks) stacks :: IO (A.IOArray Int Stack)
  forM_ instructions $ \Move {amt, src, dst} -> do
    src' <- A.readArray stacks' src
    dst' <- A.readArray stacks' dst
    let (move, keep) = T.splitAt amt src'
    A.writeArray stacks' src keep
    A.writeArray stacks' dst (f move <> dst')
  A.getElems stacks'

solve :: T.Text -> IO (String, String)
solve input = do
  part1 <- map T.head <$> rearrange stacks instructions T.reverse
  part2 <- map T.head <$> rearrange stacks instructions id
  return (part1, part2)
  where
    stacks = parseStacks stacks'
    instructions = parseInstructions instructions'
    (stacks', instructions') = case splitOn [""] $ T.lines input of
      [a, b] -> (a, b)
      _ -> undefined
