module Main where

import System.Environment(getArgs)
import System.IO(openFile, IOMode(ReadMode), Handle, hGetLine, hIsEOF)
import Data.Char(digitToInt)

solveLine :: Handle -> Int -> IO()
solveLine f acc = do
                    isEnd <- hIsEOF f
                    if isEnd
                    then do
                        putStrLn (show acc)
                        -- return ()
                    else do
                        line <- hGetLine f
                        let nums = map read $ words line
                        solveLine f (acc + ((maximum nums) - (minimum nums)))

main = do
        [fn] <- getArgs
        f <- openFile fn ReadMode
        -- input <- hGetLine f
        -- putStrLn t
        solveLine f 0
