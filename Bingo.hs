{-# LANGUAGE TupleSections #-}

module Bingo
  ( Board,
    Mark,
    Move,
    readBingoBoards,
    readMoves,
    mark,
    hasBingo,
  )
where

import Control.Monad
import Data.List
import qualified Data.Map.Strict as Map
import qualified Data.Maybe as Maybe
import Util

data Mark = Marked | Unmarked deriving (Show, Eq)

-- This should map (row,col) -> (int, mark)
type Row = Int

type Col = Int

type Move = Int

data Board = NewBoard {posMarkedMap :: !(Map.Map (Row, Col) Mark), movePosMap :: !(Map.Map Move (Row, Col))} deriving (Show)

-- Checks if Board has a given move and marks it, is nop if move not present
mark :: Move -> Board -> Board
mark move (NewBoard posMarkedMap movePosMap) =
  let pos = movePosMap Map.!? move
   in mark' pos
  where
    mark' (Just pos) = NewBoard (Map.insert pos Marked posMarkedMap) movePosMap
    mark' Nothing = NewBoard posMarkedMap movePosMap

hasBingo :: Board -> Bool
hasBingo board = hasRowBingo board || hasColBingo board
  where
    hasRowBingo board = any (hasRowBingo' board) [0 .. 5]
      where
        hasRowBingo' (NewBoard posMarked _) r = foldl' (\acc key -> Maybe.fromMaybe Unmarked (Map.lookup key posMarked) == Marked || acc) False [(r, col) | col <- [0 .. 5]]
    hasColBingo board = any (hasColBingo' board) [0 .. 5]
      where
        hasColBingo' (NewBoard posMarked _) c = foldl' (\acc key -> Maybe.fromMaybe Unmarked (Map.lookup key posMarked) == Marked || acc) False [(row, c) | row <- [0 .. 5]]

{-
play :: [Move] -> [Board] -> Int
-- FIXME:
play moves boards =
  -- Do 5 moves and then check if there is a winner
  let (winnerIndex, boards, moves) = doneAfter 5 moves boards
   in checkDone winnerIndex boards moves
  where
    doneAfter 0 moves boards = (elemIndex True (map hasBingo boards), boards, moves)
    doneAfter n [] boards = (elemIndex True (map hasBingo boards), boards, [])
    doneAfter n (m : ms) boards =
      doneAfter (n -1) ms (map (mark m) boards)

    checkDone (Just i) _ _ = i
    checkDone Nothing boards moves =
      let winnerIndex = foldM f boards moves
       in winnerIndex
      where
        f boards [m:ms]=
        | bingo == True = Left ()
        | otherwise = Right (map (mark m) boards)
          where bingo = any hasBingo boards
-- otherwise, keep going until there is a winner
-}

readBingoBoards :: [String] -> [Board]
readBingoBoards inputLines
  | length inputLines >= 5 =
    let (next5Lines, xs) = splitAt 5 inputLines
     in readBingoBoard next5Lines : readBingoBoards xs
  | otherwise = []
  where
    readBingoBoard lines =
      let indexes = [(x, y) | x <- [0 .. 5], y <- [0 .. 5]]
       in NewBoard
            (Map.fromList $ zip indexes (repeat Unmarked))
            ( Map.fromList $
                zip
                  ( foldl'
                      (\acc l -> acc ++ map read (words l))
                      []
                      lines
                  )
                  indexes
            )

readMoves :: String -> [Move]
readMoves = map read . wordsWhen (== ',')
