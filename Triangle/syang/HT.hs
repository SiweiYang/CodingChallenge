import System(getArgs)

vt :: Integer -> Integer -> Integer -> Integer -> Bool
vt r x y z = x * y * z == (x + y + z) * r * r

st :: (Integer, Integer, Integer) -> (Integer, Integer, Integer)
st (x, y, z) = (x+y, x+z, y+z)

--expR :: Integer -> [(Integer, Integer, Integer)]
expR r =
    concat [expX r x | x <- allX]
    where
        allX = findX r

expX r x =
    concat [expY r x y | y <- allY]
    where
        allY = findY r x

expY r x y =
    filter (\(x, y, z) -> vt r x y z) [(x, y, z)]
    where
        z = findZ r x y

findX :: Integer -> [Integer]
findX r = [1..(floor (doubleR * (sqrt 3.0)))]
    where
        doubleR = fromInteger r

findY :: Integer -> Integer -> [Integer]
findY r x = [y | y <- [minY..maxY], mod (x + y) 2 == 0]
    where
        doubleR = fromInteger r
        doubleX = fromInteger x
        minY = ceiling (doubleR * doubleR / doubleX)
        maxY = floor (2 * doubleR * doubleR / doubleX)

findZ :: Integer -> Integer -> Integer -> Integer
findZ r x y =
    if mod (y + lowZ) 2 == 0
    then lowZ
    else lowZ + 1
    where
        doubleR = fromInteger r
        doubleX = fromInteger x
        doubleY = fromInteger y
        tanX = doubleX / doubleR
        tanY = doubleY / doubleR
        tanZ = (tanX + tanY) / (tanX * tanY - 1)
        estZ = tanZ * doubleR
        lowZ = floor estZ
main = do
    args <- getArgs
    let lowR = read (head args)
    let highR = read (head (tail args))
    let allR = [r | r <- [lowR..highR], mod r 4 == 0]
    let allT = concat [expR r | r <- allR]
    let result = sum [x + y + z | (x, y, z) <- allT]
    putStrLn (show result)
    