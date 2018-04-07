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


execute :: [String] -> Map String Int -> Map String Int
execute [l, op, r] registers = case op of
    "inc" -> insert l (lv + rv) registers
    "dec" -> insert l (lv - rv) registers
    where
        lv = case lookup l registers of
                  Nothing -> 0
                  Just v -> v
        rv = read r

solveLine :: Handle -> Map String Int -> IO()
solveLine f registers = do
                    isEnd <- hIsEOF f
                    if isEnd
                    then do
                        -- print $ toList registers
                        print $ maximum $ map snd $ toList registers
                    else do
                        line <- hGetLine f
                        let parts = words line
                        let statement = take 3 parts
                        let condition = drop 4 parts
                        -- print statement
                        -- print condition
                        if check condition registers
                        then solveLine f $ execute statement registers
                        else solveLine f registers

main = do
        [fn] <- getArgs
        f <- openFile fn ReadMode
        solveLine f empty
