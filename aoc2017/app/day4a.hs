module Main where

import System.Environment(getArgs)
import System.IO(openFile, IOMode(ReadMode), Handle, hGetLine, hIsEOF)
import Data.Char(digitToInt)

addToSet [] item = [item]
addToSet list@(h:t) item = if h == item
                           then list
                           else h:(addToSet t item)

solveLine :: Handle -> Int -> IO()
solveLine f acc = do
                    isEnd <- hIsEOF f
                    if isEnd
                    then do
                        print acc
                        -- return ()
                    else do
                        line <- hGetLine f
                        let items = words line
                        let items' = foldl addToSet [] items
                        if length items == length items'
                        then solveLine f (acc + 1)
                        else solveLine f acc

main = do
        [fn] <- getArgs
        f <- openFile fn ReadMode
        solveLine f 0
