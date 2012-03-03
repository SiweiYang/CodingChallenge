import System(getArgs)

vt :: Integer -> Integer -> Integer -> Integer -> Bool
vt r x y z = x * y * z == (x + y + z) * r * r

st :: (Integer, Integer, Integer) -> (Integer, Integer, Integer)
st (x, y, z) = (x+y, x+z, y+z)

--expR :: Integer -> [(Integer, Integer, Integer)]
expR r =
    concat [expX r doubleR x arcX | (x, arcX) <- zip allX allArcX]
    where
        allX = findX r
        doubleR = fromInteger r
        allArcX = [atan ((fromInteger x) / doubleR) | x <- allX]

expX r doubleR x arcX=
    concat [expY r doubleR x arcX y arcY | (y, arcY) <- zip allY allArcY]
    where
        allY = findY doubleR x arcX
        doubleX = fromInteger x
        allArcY = [atan ((fromInteger y) / doubleR) | y <- allY]

expY r doubleR x arcX y arcY =
    filter (\(x, y, z) -> vt r x y z) [(x, y, z)]
    where
        z = findZ doubleR x arcX y arcY

findX :: Integer -> [Integer]
findX r = [1..(floor (doubleR * (sqrt 3.0)))]
    where
        doubleR = fromInteger r

findY :: Double -> Integer -> Double -> [Integer]
findY doubleR x arcX = [y | y <- [minY..maxY], mod (x + y) 2 == 0]
    where
        --doubleR = fromInteger r
        --doubleX = fromInteger x
        --arcX = atan (doubleX / doubleR)
        minArcY = (pi / 2) - arcX
        maxArcY = (pi - arcX) / 2
        minY = max (floor ((tan minArcY) * doubleR)) x
        maxY = ceiling ((tan maxArcY) * doubleR)

findZ :: Double -> Integer -> Double -> Integer -> Double -> Integer
findZ doubleR x arcX y arcY  =
    if mod (y + lowZ) 2 == 0
    then lowZ
    else highZ
    where
        --doubleR = fromInteger r
        --doubleX = fromInteger x
        --doubleY = fromInteger y
        --arcX = atan (doubleX / doubleR)
        --arcY = atan (doubleY / doubleR)
        arcZ = pi - arcX - arcY
        estZ = (tan arcZ) * doubleR
        lowZ = floor estZ
        highZ = ceiling estZ

main = do
    args <- getArgs
    let lowR = read (head args)
    let highR = read (head (tail args))
    let allR = [r | r <- [lowR..highR], mod r 4 == 0]
    let allT = concat [expR r | r <- allR]
    let result = sum [x + y + z | (x, y, z) <- allT]
    putStrLn (show result)
    