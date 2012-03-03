import System(getArgs)
import Data.Ratio

vt :: Integer -> Integer -> Integer -> Integer -> Bool
vt r x y z = x * y * z == (x + y + z) * r * r

st :: (Integer, Integer, Integer) -> (Integer, Integer, Integer)
st (x, y, z) = (x+y, x+z, y+z)

expR :: Integer -> [(Integer, Integer, Integer)]
expR r =
    concat [expX r x | x <- allX]
    where
        allX = findX r

expX :: Integer -> Integer -> [(Integer, Integer, Integer)]
expX r x =
    [(x, y, z) | (y, z) <- allYZ]
    where
        allYZ = findYZ r x

findX :: Integer -> [Integer]
findX r = [1..(floor (doubleR * (sqrt 3.0)))]
    where
        doubleR = fromInteger r

findYZ :: Integer -> Integer -> [(Integer, Integer)]
findYZ r x = map (\(y, Just z) -> (y, z)) allYZ
    where
        doubleR = fromInteger r
        doubleX = fromInteger x
        minY = ceiling (doubleR * doubleR / doubleX)
        maxY = floor (2 * doubleR * doubleR / doubleX)
        allY = [y | y <- [minY..maxY], mod (x + y) 2 == 0]
        allZ = [findZ r x y | y <- allY]
        allYZ = [(y, z) | (y, z) <- zip allY allZ, not (z == Nothing)]

findZ :: Integer -> Integer -> Integer -> Maybe Integer
findZ r x y =
    if isRec || tanY > tanZ || notWhole || mod (y + z) 2 == 1
    then Nothing
    else Just z
    where
        rationalR = fromInteger r
        rationalX = fromInteger x
        rationalY = fromInteger y
        tanX = rationalX / rationalR :: Rational
        tanY = rationalY / rationalR :: Rational
        isRec = tanX * tanY == 1
        tanZ = (tanX + tanY) / (tanX * tanY - 1)
        rationalZ = tanZ * rationalR
        z = floor rationalZ
        notWhole = rationalZ > (fromInteger z)

test  r x y =
    (isRec , tanY > tanZ , rationalZ , notWhole , mod (y + z) 2 == 1)
    where
        rationalR = fromInteger r
        rationalX = fromInteger x
        rationalY = fromInteger y
        tanX = rationalX / rationalR :: Rational
        tanY = rationalY / rationalR :: Rational
        isRec = tanX * tanY == 1
        tanZ = (tanX + tanY) / (tanX * tanY - 1)
        rationalZ = tanZ * rationalR
        z = floor rationalZ
        notWhole = rationalZ > (fromInteger z)

main = do
    args <- getArgs
    let lowR = read (head args)
    let highR = read (head (tail args))
    let allR = [r | r <- [lowR..highR], mod r 4 == 0]
    let allT = concat [expR r | r <- allR]
    let result = sum [x + y + z | (x, y, z) <- allT]
    putStrLn (show result)
    