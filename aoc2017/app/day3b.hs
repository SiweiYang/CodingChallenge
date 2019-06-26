module Main where

import System.Environment(getArgs)
import System.IO(openFile, IOMode(ReadMode), Handle, hGetLine, hIsEOF)
import Data.Char(digitToInt)

sizes = 1:(8:[8 + sizes!!i | i <- [1..]])
sums = [sum (take i sizes) | i <- [1..]]
sums' = 1:[sum (map (sums'!!) (expandIndex i)) | i <- [1..]]

indexToTier i tier sums = if i < head sums
                          then tier
                          else indexToTier i (tier + 1) (tail sums)


indexToCoordinate i =  if coordinateToIndex (tier, tier) >= i
                       then (offset - tier, tier)
                       else if coordinateToIndex (tier, -tier) >= i
                       then (tier, 3 * tier - offset)
                       else if coordinateToIndex (-tier, -tier) >= i
                       then (5 * tier - offset, -tier)
                       else if coordinateToIndex (-tier, tier) >= i
                       then (-tier, offset - 7 * tier)
                       else (0, 0)
    where
        tier = indexToTier i 0 sums
        offset = if i == 0 then 0 else i + 1 - sums!!(tier - 1)

previousCoordinate (x, y) = if x > 0 && y > 0
                            then (x - 1, y)
                            else if x > 0 && y < 0
                            then (x, y + 1)
                            else if x < 0 && y < 0
                            then (x + 1, y)
                            else if x < 0 && y > 0
                            then (x, y - 1)
                            else (0, 0)


coordinateToIndex (x, y) = if x == 0 && y == 0
                           then 0
                           else if abs x == abs y
                           then coordinateToIndex (previousCoordinate (x, y)) + 1
                           else if abs y > abs x
                           then
                               if y > 0 && x < 0 && y == (abs x) + 1
                               then coordinateToIndex (x, y') + 1
                               else coordinateToIndex (x, y') + diffY
                           else coordinateToIndex (x', y) + diffX
    where
        x' = if x > 0 then x - 1 else x + 1
        diffX = if x' < x then 8 * x' + 3 else 8 * (abs x) - 1
        y' = if y > 0 then y - 1 else y + 1
        diffY = if y' < y then 8 * y' + 1 else 8 * (abs y) - 3


expandIndex i = filter (i >) indecies
    where
        (x, y) = indexToCoordinate i
        coordinates = [(x', y') | x' <- [x - 1, x, x + 1], y' <- [y - 1, y, y + 1]]
        indecies = map coordinateToIndex coordinates

-- solveCase i = take 10 [indexToCoordinates k | k <- [0..]]

main = do
        [fn] <- getArgs
        f <- openFile fn ReadMode
        input <- hGetLine f
        let sums'' = dropWhile ((read input) >) sums'
        print $ head sums''

        -- print $ solveCase (read input)
