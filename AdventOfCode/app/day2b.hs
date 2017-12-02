module Main where

import System.Environment(getArgs)
import System.IO(openFile, IOMode(ReadMode), Handle, hGetLine, hIsEOF)
import Data.Char(digitToInt)
import Data.List(intersect, sort)

searchMultiple i nums = if intersect nums multiples /= [] then i else searchMultiple (i+1) nums
    where
        multiples = map (i *) nums

solveLine :: Handle -> Int -> IO()
solveLine f acc = do
                    isEnd <- hIsEOF f
                    if isEnd
                    then do
                        putStrLn (show acc)
                        -- return ()
                    else do
                        line <- hGetLine f
                        let nums = sort $ map read $ words line
                        solveLine f (acc + (searchMultiple 2 nums))

main = do
        [fn] <- getArgs
        f <- openFile fn ReadMode
        -- input <- hGetLine f
        -- putStrLn t
        solveLine f 0
