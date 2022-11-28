import Data.List
import qualified Data.ByteString.Char8 as C
import qualified Data.Maybe as Maybe

lanternFish :: [Int] -> Int -> [Int]
lanternFish startingFish 0 = startingFish 
lanternFish startingFish n = lanternFish (foldr reproduce [] startingFish) (n-1)
	where reproduce 0 newFish = 6 : 8 : newFish
	      reproduce n newFish= (n-1) : newFish
		
main :: IO()
main = do
	contents <- C.getContents
	let fishes = map (fst . Maybe.fromJust) . filter (Maybe.isJust) $ map C.readInt $ C.split ',' contents in
		print $ length (lanternFish fishes 80)
