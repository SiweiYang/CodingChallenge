module Main where

import System.Environment(getArgs)
import System.IO(openFile, IOMode(ReadMode), Handle, hGetLine, hIsEOF)
import Prelude hiding (lookup)
import Data.List(sort)
import Data.List.Split(splitOn)
import Data.Map(empty, fromList, size, alter, lookup, update)

listSize = 256

rotate str size = (reverse ft) ++ bk
  where
    (ft, bk) = (take size str, drop size str)

move str size skip = take listSize stream
  where
    stream = drop (size + skip) $ concat $ repeat str

updater Nothing = Just 1
updater (Just i) = Just (i + 1)





merge (("se", i), ("ne", j)) = if i > j
                               then (("e", j), ("se", i - j))
                               else (("e", i), ("ne", j - i))
merge (("se", i), ("sw", j)) = if i > j
                               then (("s", j), ("se", i - j))
                               else (("s", i), ("sw", j - i))
merge (("nw", i), ("ne", j)) = if i > j
                               then (("n", j), ("nw", i - j))
                               else (("n", i), ("ne", j - i))
merge (("nw", i), ("sw", j)) = if i > j
                               then (("w", j), ("nw", i - j))
                               else (("w", i), ("sw", j - i))

mergeNS counter = if n > s
                    then ("n", n - s)
                    else ("s", s - n)
    where
        Just n = lookup "n" counter
        Just s = lookup "s" counter

mergeNESW counter = if ne > sw
                    then ("ne", ne - sw)
                    else ("sw", sw - ne)
    where
        Just ne = lookup "ne" counter
        Just sw = lookup "sw" counter

mergeNWSE counter = if nw > se
                    then ("nw", nw - se)
                    else ("se", se - nw)
    where
        Just nw = lookup "nw" counter
        Just se = lookup "se" counter


main = do
        [fn] <- getArgs
        f <- openFile fn ReadMode
        line <- hGetLine f
        let moves = splitOn "," line
        let counter = foldl (\counter move -> alter updater move counter) empty moves
        print $ counter
