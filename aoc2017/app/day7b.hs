module Main where

import System.Environment(getArgs)
import System.IO(openFile, IOMode(ReadMode), Handle, hGetLine, hIsEOF)
import Prelude hiding (lookup)
import Data.Char(digitToInt)
import Data.List(sort)
-- import Data.Set(Set, empty, insert, member)
import Data.Maybe(fromJust)
import Data.Map(Map, empty, fromList, size, member, lookup, insert)

strip [] = []
strip [','] = []
strip word = (head word):(strip $ tail word)

weight line = (winner, num)
    where
        winner = (words line)!!0
        num = read $ init $ tail $ (words line)!!1

winners :: String -> [String]
winners line = if elem "->" $ words line
              -- then dropWhile ("->" /=) $ words line
              then [winner]
              else []
    where
        winner = (words line)!!0

losers line = if elem "->" $ words line
              -- then dropWhile ("->" /=) $ words line
              then map strip $ drop 3 $ words line
              else []
memebers line = [(words line)!!0] ++ (losers line)


solveLine [] mapW mapF = (mapW, mapF, Nothing)
solveLine listL@(line:listL') mapW mapF = if length (winners line) == 0
                                          then solveLine listL' mapW mapF
                                          else if not ready
                                          then solveLine listL' mapW mapF
                                          else if maxNum == minNum
                                          then solveLine listL' mapW mapF'
                                          else (mapW, mapF, Just newWeight)
    where
        [winner] = winners line
        Just winnerWeight = lookup winner mapW
        ls = losers line
        ready = and $ map (\s -> member s mapF) ls
        ws = map fromJust $ map (\s -> lookup s mapF) ls
        mapF' = insert winner (winnerWeight + sum ws) mapF

        maxNum = length $ filter (maximum ws ==) ws
        minNum = length $ filter (minimum ws ==) ws
        targetWeight = if maxNum == 1 then maximum ws else minimum ws
        desiredWeight = if maxNum == 1 then minimum ws else maximum ws
        [(targetMember, _)] = filter (\(m, w) -> w == targetWeight) (zip ls ws)
        Just originalWeight = lookup targetMember mapW
        newWeight = originalWeight + desiredWeight - targetWeight

solveCase listL mapW mapF = if result == Nothing
                            then solveCase listL mapW' mapF'
                            else fromJust result
    where
        (mapW', mapF', result) = solveLine listL mapW mapF

solveInput :: Handle -> [String] -> [String] -> [String] -> Map String Int-> IO()
solveInput f listL listW listM mapW = do
                    isEnd <- hIsEOF f
                    if isEnd
                    then do
                        let ls = (filter (\s -> not $ elem s listW) listM)
                        let ws = map fromJust $ map (\s -> lookup s mapW) ls
                        print $ solveCase listL mapW (fromList $ zip ls ws)
                    else do
                        line <- hGetLine f
                        let ws = winners line
                        let ms = memebers line
                        let (k, v) = weight line
                        solveInput f (line:listL) (listW ++ ws) (listM ++ ms) (insert k v mapW)

main = do
        [fn] <- getArgs
        f <- openFile fn ReadMode
        solveInput f [] [] [] empty
