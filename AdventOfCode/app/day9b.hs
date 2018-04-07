module Main where

import System.Environment(getArgs)
import System.IO(openFile, IOMode(ReadMode), Handle, hGetLine, hIsEOF)
import Prelude hiding (lookup)
import Data.List(sort)
import Data.Map(fromList, size, lookup, update)


data Group = Garbage Int | Children [Group]


parseChar :: String -> String
parseChar [] = []
parseChar (c:str) = if c == '!'
                    then parseChar $ tail str
                    else c:(parseChar str)


parseGarbage :: String -> (Group, String)
parseGarbage [] = (Garbage 0, [])
parseGarbage (c:str) = if c == '>'
                       then (Garbage 0, str)
                       else (Garbage (i + 1), str')
    where
        (Garbage i, str') = parseGarbage str


parseGroup :: String -> (Group, String)
parseGroup [] = (Garbage 0, [])
parseGroup str = case head str of
                  '{' -> (Children children, tail str')
                  '<' -> parseGarbage $ tail str
    where
        (children, str') = parseGroups ([], tail str)


parseGroups :: ([Group], String) -> ([Group], String)
parseGroups (children, []) = (children, [])
-- parseGroups str@('}':_) = str
-- parseGroups str@(',':_) = str
parseGroups (children, str) = case head str of
                  '<' -> parseGroups (group':children, str')
                  '{' -> parseGroups (group':children, str')
                  ',' -> parseGroups (group'':children, str'')
                  '}' -> (children, str)
    where
        (group', str') = parseGroup str
        (group'', str'') = parseGroup $ tail str


evalGroup :: Int -> Group -> Int
evalGroup i (Garbage k) = k
evalGroup i (Children groups) = sum $ map (evalGroup (i + 1)) groups


main = do
        [fn] <- getArgs
        f <- openFile fn ReadMode
        line <- hGetLine f
        print $ evalGroup 1 $ fst $ parseGroup $ parseChar line
