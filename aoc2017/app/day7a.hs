module Main where

import System.Environment(getArgs)
import System.IO(openFile, IOMode(ReadMode), Handle, hGetLine, hIsEOF)
import Prelude hiding (lookup)
import Data.Char(digitToInt)
import Data.List(sort)
import Data.Map(fromList, size, lookup, update)

strip [] = []
strip [','] = []
strip word = (head word):(strip $ tail word)

losers line = if elem "->" $ words line
              -- then dropWhile ("->" /=) $ words line
              then map strip $ drop 3 $ words line
              else []

winners line = [(words line)!!0]


solveLine :: Handle -> [String] -> [String] -> IO()
solveLine f listW listL = do
                    isEnd <- hIsEOF f
                    if isEnd
                    then do
                        let ws = filter (\w -> not $ elem w listL) listW
                        putStrLn $ ws!!0
                    else do
                        line <- hGetLine f
                        let ws = winners line
                        let ls = losers line
                        solveLine f (listW ++ ws) (listL ++ ls)

main = do
        [fn] <- getArgs
        f <- openFile fn ReadMode
        solveLine f [] []
