import Control.Monad
import Data.List
import System.Environment
import System.IO

wordsWhen :: (Char -> Bool) -> String -> [String]
wordsWhen predicate str = case dropWhile predicate str of
  "" -> []
  str' -> w : wordsWhen predicate str''
    where
      (w, str'') = break predicate str'

newtype BingoBoard = Board [Int]

newtype Moves = Moves [Int]

readBingoBoard :: IO a
readBingoBoard = do
  line <- getLine
  unless isEOF $ do
    when null line $
      return sequence (repeat 5 getLine)

main :: IO ()
main = do
  moveLine <- getLine
  let movesStr = wordsWhen (== ',') moveLine
  let moves = Moves (map read movesStr)
  _ <- getLine

  putStrLn "Hello World"
