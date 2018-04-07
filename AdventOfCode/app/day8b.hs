module Main where

import System.Environment(getArgs)
import System.IO(openFile, IOMode(ReadMode), Handle, hGetLine, hIsEOF)
import Prelude hiding (lookup)
import Data.Char(digitToInt)
import Data.List(sort)
import Data.Map(Map, empty, fromList, toList, size, lookup, update, insert)


check :: [String] -> Map String Int -> Bool
check [l, op, r] registers = case op of
    "<" -> lv < rv
    "<=" -> lv <= rv
    ">" -> lv > rv
    ">=" -> lv >= rv
    "==" -> lv == rv
    "!=" -> lv /= rv
    where
        lv = case lookup l registers of
                  Nothing -> 0
                  Just v -> v
        rv = read r


execute :: [String] -> Map String Int -> (String, Int)
execute [l, op, r] registers = case op of
    "inc" -> (l, (lv + rv))
    "dec" -> (l, (lv - rv))
    where
        lv = case lookup l registers of
                  Nothing -> 0
                  Just v -> v
        rv = read r

solveLine :: Handle -> Int -> Map String Int -> IO()
solveLine f m registers = do
                    isEnd <- hIsEOF f
                    if isEnd
                    then do
                        -- print $ toList registers
                        print m
                    else do
                        line <- hGetLine f
                        let parts = words line
                        let statement = take 3 parts
                        let condition = drop 4 parts
                        let (k, v) = execute statement registers
                        -- print statement
                        -- print condition
                        if check condition registers
                        then solveLine f (maximum [m, v]) $ insert k v registers
                        else solveLine f m registers

main = do
        [fn] <- getArgs
        f <- openFile fn ReadMode
        solveLine f 0 empty
