import Data.List
import qualified Data.ByteString.Char8 as C
import qualified Data.Maybe as Maybe
import System.Environment
import System.IO


lanternFish :: C.ByteString -> Int -> [Integer]
lanternFish startingFish 0 = startingFish 
lanternFish startingFish n = lanternFish (foldr reproduce C.empty startingFish) (n-1)
    where
        reproduce 0 newFish = C.readInt 6 : C.readInt 8 : newFish
        reproduce n newFish = C.cons (C.readInt n)-1 newFish

usage :: IO()
usage = do
    name <- getProgName
    putStrLn ("Usage: " ++ name ++ " <num iterations>")

main :: IO()
main = do
    -- TODO: Check that we parse the arguments correctly
    args <- getArgs
    doMain args
    where
        doMain [] = usage
        doMain (numGenerations:_) = do
            contents <- C.getContents

            let fishes = extractIntsFromMaybe $ convertToMaybeInt $ splitOnComma contents in
                print $ length (lanternFish fishes $ read numGenerations)
           where 
            splitOnComma = C.split ','
            convertToMaybeInt = map C.readInt
            extractIntsFromMaybe = map (fst . Maybe.fromJust) . filter (Maybe.isJust)
