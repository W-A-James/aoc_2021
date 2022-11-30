import Data.List
import qualified Data.ByteString.Char8 as C
import qualified Data.Maybe as Maybe

sumTo n =  (n*(n+1)) `div` 2

main :: IO()
main = do
    contents <- C.getContents

    let sortedCrabs = sort $ getCrabs contents
    let median = sortedCrabs !! ((length sortedCrabs) `div` 2)
    print $ foldl1' (+) $ map (sumTo . abs . (\x -> x - median) ) sortedCrabs
	
    where
        getCrabs = extractIntsFromMaybe . convertToMaybeInt . splitOnComma
            where
                splitOnComma = C.split ','	
                convertToMaybeInt = map C.readInt
                extractIntsFromMaybe = map (fst . Maybe.fromJust) . filter (Maybe.isJust)
