import System.Environment
import System.IO
import Data.List
hasBitInPosition :: Char -> Int -> [Char] -> Bool
hasBitInPosition bit pos str = str !! pos == bit

mostCommonInPos :: [[Char]] -> Int -> Char
mostCommonInPos listStrs pos = do
  let counts =
        foldl'
          ( \counts number ->
              if (number !! pos) == '1'
                then (fst counts, ((+ 1) . snd) counts)
                else (((+ 1) . fst) counts, snd counts)
          )
          (0, 0)
          listStrs
  if fst counts > (snd counts)
    then '0'
    else '1'

leastCommonInPos :: [[Char]] -> Int -> Char
leastCommonInPos listStrs pos = if mostCommonInPos listStrs pos == '1' then '0' else '1'

data BinToIntAcc = Acc
          { result :: !Int,
            currentPlace :: !Int
          }

binToInt :: [Char] -> Int
binToInt bin =
  result
    ( foldl' ( \acc bit ->
            let res = result acc
                place = currentPlace acc
             in if bit == '1'
                  then Acc (res + (2 ^ place)) (place + 1)
                  else Acc res (place + 1)
        )
        (Acc 0 0)
        (reverse bin)
    )

getOxygenGeneratorRating :: [[Char]] -> Int -> Int
getOxygenGeneratorRating [] pos = error "Empty list"
getOxygenGeneratorRating [num] pos = binToInt num
getOxygenGeneratorRating nums pos = do
  let mostCommon = mostCommonInPos nums pos
  getOxygenGeneratorRating (filter (hasBitInPosition mostCommon pos) nums) (pos + 1)

getOxygenGeneratorRating' :: [[Char]] -> Int
getOxygenGeneratorRating' nums = getOxygenGeneratorRating nums 0

getCO2ScrubberRating :: [[Char]] -> Int -> Int
getCO2ScrubberRating [] pos = error "Empty list"
getCO2ScrubberRating [num] pos = binToInt num
getCO2ScrubberRating nums pos = do
  let leastCommon = leastCommonInPos nums pos
  getCO2ScrubberRating (filter (hasBitInPosition leastCommon pos) nums) (pos + 1)

getCO2ScrubberRating' :: [[Char]] -> Int
getCO2ScrubberRating' nums = getCO2ScrubberRating nums 0

main :: IO ()
main = do
  contents <- getContents
  let numbers = lines contents
  print (getOxygenGeneratorRating' numbers)
  print (getCO2ScrubberRating' numbers)
