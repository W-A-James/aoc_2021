module Util (
  wordsWhen
) where

wordsWhen :: (Char -> Bool) -> String -> [String]
wordsWhen predicate str = case dropWhile predicate str of
  "" -> []
  str' -> w : wordsWhen predicate str''
    where
      (w, str'') = break predicate str'
