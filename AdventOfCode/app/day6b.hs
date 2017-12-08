module Main where

import System.Environment(getArgs)
import System.IO(openFile, IOMode(ReadMode), Handle, hGetLine, hIsEOF)
import Data.Char(digitToInt)
import Data.List(intersect, sort)
import Data.Set(Set, empty, insert, member)

sumList :: Integral t => [t] -> [t] -> [t]
sumList [] _ = []
sumList _ [] = []
sumList a@(ha:ta) b@(hb:tb) = (ha + hb):(sumList ta tb)

mutateList list = map (take (length list)) [listResidual, listExtra, listOverlay', listOverlay'']
    where
        listWithIndices = zip [0..] list
        listMax = maximum list
        listMaxIndex = fst $ head $ filter (\(i, x) -> x == listMax) listWithIndices
        listResidual = map (\(i, x) -> if i == listMaxIndex then 0 else x) listWithIndices
        listExtra = repeat $ div listMax $ length list
        listOverlay = [0] ++ (replicate listMaxIndex 0) ++ (replicate (mod listMax $ length list) 1) ++ (repeat 0)
        listOverlay' = take (length list) listOverlay
        listOverlay'' = drop (length list) listOverlay

solveCase :: Set [Int] -> Int -> [Int] -> Int
solveCase s acc list = if member list' s
                       then acc
                       else solveCase s' (acc + 1) list'
    where
        sums = mutateList list
        list' = foldl sumList (repeat 0) sums
        s' = insert list' s

solveCaseWrapper :: Set [Int] -> Int -> [Int] -> Int
solveCaseWrapper s acc list = if member list' s
                       then solveCase empty 0 list'
                       else solveCaseWrapper s' (acc + 1) list'
    where
        sums = mutateList list
        list' = foldl sumList (repeat 0) sums
        s' = insert list' s


main = do
        [fn] <- getArgs
        f <- openFile fn ReadMode
        input <- hGetLine f
        let configuration = map read $ words input
        print $ solveCaseWrapper empty 1 configuration
