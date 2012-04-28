import System(getArgs)
import System.IO
import Data.Ratio

extremeScoreStrict :: Int -> Maybe Int
extremeScoreStrict total =
  case (mod total 3) of
    0 -> if (total > 0) then Just ((ceiling (total % 3)) + 1) else Just (ceiling (total % 3))
    1 -> Nothing
    2 -> Just ((ceiling (total % 3)) + 1)

normalScore total = ceiling (total % 3)

extremeScore :: Int -> Int
extremeScore total =
  case (mod total 3) of
    0 -> if (total > 0) then (ceiling (total % 3)) + 1 else ceiling (total % 3)
    1 -> normalScore total
    2 -> (ceiling (total % 3)) + 1

findScores :: Int -> Int -> [Int] -> Int
findScores fixes threshold scores =
  (length scores) - (length badPairs) + (min (length fixedBadPairs) fixes)
  where
    normalScores = map normalScore scores
    pairs = zip normalScores scores
    badPairs = filter (\(score, _) -> score < threshold) pairs
    extendedBadPairs = map (\(_, total) -> (extremeScore total, total)) badPairs
    fixedBadPairs = filter (\(score, _) -> not (score < threshold)) extendedBadPairs

readCase :: Handle -> Int -> IO()
readCase handle caseID = do
                    isEOF <- hIsEOF handle
                    if isEOF
                    then putStrLn "Done..."
                    else do
                      line <- hGetLine handle
                      --putStrLn line
                      processCase line caseID
                      readCase handle (caseID + 1)

processCase :: String -> Int -> IO()
processCase line caseID =
  putStrLn ("Case #" ++ (show caseID) ++ ": " ++ (show result))
  where
    (fixes, threshold, scores) = parseLine line
    result = findScores fixes threshold scores

splitBy :: (a -> Bool) -> [a] -> [[a]]
splitBy _ [] = []
splitBy f list = first : splitBy f (dropWhile f rest) where
  (first, rest) = break f list

parseLine :: String -> (Int, Int, [Int])
parseLine line =
  (read fixes, read threshold, map read scores)
  where
    tokens = splitBy (' ' ==) line
    totalGooglers:fixes:threshold:scores = tokens

main = do
        [fileName] <- getArgs
        handle <- openFile fileName ReadMode
        line <- hGetLine handle
        readCase handle 1
