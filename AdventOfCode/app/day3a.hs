module Main where

import System.Environment(getArgs)
import System.IO(openFile, IOMode(ReadMode), Handle, hGetLine, hIsEOF)
import Data.Char(digitToInt)

sizes = 1:(8:[8 + sizes!!i | i <- [1..]])
sums = [sum (take i sizes) | i <- [1..]]


solveOffset extra tier = tier + offet
    where
        extra' = mod extra (2 * tier)
        mid = tier
        offet = abs (tier - extra')



solveCase k tier sums = if k <= head sums
                        then solveOffset (k - (head sums)) tier
                        else solveCase k (tier + 1) (tail sums)


main = do
        [fn] <- getArgs
        f <- openFile fn ReadMode
        input <- hGetLine f
        -- putStrLn t
        let dist = solveCase (read input) 0 sums
        putStrLn (show dist)
