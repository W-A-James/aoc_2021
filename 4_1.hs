import Bingo
import Control.Monad
import Data.List
import System.Environment
import System.IO

getMovesAndBoards :: String -> ([Move], [Board])
getMovesAndBoards content =
  let (firstLine, rest) = splitAt 1 $ lines content
   in (readMoves $ head firstLine, readBingoBoards . filter (not . null) $ rest)

    

main :: IO ()
main = do
  contents <- getContents
  let (moves, boards) = getMovesAndBoards contents

  forM_ boards print
