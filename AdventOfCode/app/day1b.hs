module Main where

import System.Environment(getArgs)
import System.IO(openFile, IOMode(ReadMode), Handle, hGetLine, hIsEOF)
import Data.Char(digitToInt)

solveCase :: String -> IO()
solveCase input = do
                    let offset = fromIntegral $ div (length input) 2
                    let pairs = zip input (drop offset (input ++ input))
                    let legitPairs = filter (\(a, b) -> a == b) pairs
                    putStrLn (show (sum (map (digitToInt . fst) legitPairs)))

main = do
        [fn] <- getArgs
        f <- openFile fn ReadMode
        input <- hGetLine f
        -- putStrLn t
        solveCase input
