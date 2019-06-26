module Main where

import System.Environment(getArgs)
import System.IO(openFile, IOMode(ReadMode), Handle, hGetLine, hIsEOF)
import Prelude hiding (lookup)
import Data.Char(digitToInt)
import Data.List(sort)
import Data.Map(fromList, size, lookup, update)

run t i dict = if isOutside
               then t
               else run (t + 1) i' dict'
    where
        isOutside = i < 0 || i >= (size dict)
        Just offset = lookup i dict
        i' = i + offset
        dict' = update (\v -> Just (v + 1)) i dict

execute list = run 0 0 dict
    where
        dict = fromList $ zip [0..] (reverse list)

solveLine :: Handle -> [Int] -> IO()
solveLine f acc = do
                    isEnd <- hIsEOF f
                    if isEnd
                    then do
                        let dict = execute acc
                        print $ dict
                    else do
                        line <- hGetLine f
                        solveLine f ((read line):acc)

main = do
        [fn] <- getArgs
        f <- openFile fn ReadMode
        solveLine f []
