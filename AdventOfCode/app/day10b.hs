module Main where

import System.Environment(getArgs)
import System.IO(openFile, IOMode(ReadMode), Handle, hGetLine, hIsEOF)
import Prelude hiding (lookup)
import Numeric(showHex)
import Data.Bits(xor)
import Data.Char(ord)
import Data.Word(Word8)
import Data.List(sort)
import Data.List.Split(splitOn)
import Data.Map(fromList, size, lookup, update)

listSize = 256
hashSize = 16

rotate str size = (reverse ft) ++ bk
  where
    (ft, bk) = (take size str, drop size str)

move str size skip = take listSize stream
  where
    stream = drop (size + skip) $ concat $ repeat str

sliceByLength size seq = map (\i -> map snd $ filter (\(j, _) -> i == j) seq') [0..size-1]
  where
    -- seq' = zip (map (\i -> mod i size) [0..]) seq
    seq' = zip (map (\i -> div i size) [0..]) seq

wordToNum word = [div word 16, mod word 16]

numToHex list = foldr showHex "" $ concat $ map wordToNum list

solveLine line = numToHex seqs'
  where
    nums = concat $ replicate 64 $ map ord line ++ [17, 31, 73, 47, 23]
    seq = foldl (\list -> \(skip, size) -> move (rotate list size) size skip) (take listSize [0..]) (zip [0..] nums)
    offset = (sum (nums) + sum (take (length nums) [0..]))
    seq' = map fromInteger $ take listSize $ drop (mod (0 - offset) listSize) $ seq ++ seq :: [Word8]
    seqs = sliceByLength hashSize seq'
    seqs' = map (\seq -> foldl (\a b -> xor a b) 0 seq) seqs

main = do
        [fn] <- getArgs
        f <- openFile fn ReadMode
        line <- hGetLine f

        putStrLn $ solveLine line
