module Main where

import System.Environment(getArgs)
import System.IO(openFile, IOMode(ReadMode), Handle, hGetLine, hIsEOF)
import Prelude hiding (lookup)
import Data.List(sort)
import Data.List.Split(splitOn)
import Data.Map(fromList, size, lookup, update)

listSize = 256

rotate str size = (reverse ft) ++ bk
  where
    (ft, bk) = (take size str, drop size str)

move str size skip = take listSize stream
  where
    stream = drop (size + skip) $ concat $ repeat str

main = do
        [fn] <- getArgs
        f <- openFile fn ReadMode
        line <- hGetLine f
        let nums = map read $ splitOn "," line
        let seq = foldl (\list -> \(skip, size) -> move (rotate list size) size skip) (take listSize [0..]) (zip [0..] nums)
        let offset = (sum (nums) + sum (take (length nums) [0..]))
        let seq' = take listSize $ drop (mod (0 - offset) listSize) $ seq ++ seq
        -- print seq
        -- print offset
        print $ product $ take 2 seq'
