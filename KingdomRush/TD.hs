module Main where

import System(getArgs)
import System.IO(openFile, IOMode(ReadMode), Handle, hGetLine, hIsEOF)

split :: [Char] -> (String, String)
split (x:xs) =    if x == ' '
                then ([], xs)
                else    let
                            (a, b) = split xs
                        in (x:a, b)

doCase :: Handle -> Int -> IO [(Int, Int)]
doCase f num =  if num == 0
                then return []
                else
                    do
                        line <- hGetLine f
                        --putStrLn ("level: " ++ line)
                        rst <- (doCase f (num-1))
                        (a, b) <- (return (split line))
                        return  ((read a, read b):rst)

--runLevel2 :: Int -> [(Int, Int)]
runStep :: Int -> Int-> [(Int, Int)] -> Int
runStep starting taken levels =
    if levels == []
    then taken
    else if earned > 0
    then runStep (starting + earned) (taken + (length mustTake)) tricky
    else if acceptable == []
    then 0
    else runStep (starting + 1) (taken + 1) (((-1,theY):otherBest)++otherAcceptable++unacceptable)
    where
        tricky = [(x, y) | (x, y) <- levels, y > starting]
        mustTake = [(x, y) | (x, y) <- levels, y <= starting]
        earned = (length mustTake) + (length [(x, y) | (x, y) <- mustTake, x >= 0])
        
        acceptable = [(x, y) | (x, y) <- levels, x <= starting && x >= 0]
        unacceptable = [(x, y) | (x, y) <- levels, x > starting || x < 0]
        (_, theY):otherBest = [(x, y) | (x, y) <- acceptable, y == (maximum [b | (a, b) <- acceptable])]
        otherAcceptable = [(x, y) | (x, y) <- acceptable, y < (maximum [b | (a, b) <- acceptable])]
        


solveCase :: Handle -> Int -> IO()
solveCase f num = do
                    isEnd <- hIsEOF f
                    if isEnd
                    then do
                        return ()
                    else do
                        line <- hGetLine f
                        levels <- doCase f (read line)
                        --putStrLn ("Levels -> " ++ (show levels))
                        steps <- (return (runStep 0 0 levels))
                        if steps > 0
                        then putStrLn ("Case #" ++ (show num) ++ ": " ++ (show steps))
                        else putStrLn ("Case #" ++ (show num) ++ ": Too Bad")                        
                        solveCase f (num+1)

main = do
        [fn] <- getArgs
        f <- openFile fn ReadMode
        t <- hGetLine f
        -- putStrLn t
        solveCase f 1
        