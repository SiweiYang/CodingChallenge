import System(getArgs)

vt :: Integer -> Integer -> Integer -> Integer -> Bool
vt r x y z = x * y * z == (x + y + z) * r * r

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
        arcX = atan (doubleX / doubleR)
        minArcY = (pi / 2) - arcX
        maxArcY = (pi - arcX) / 2
        minY = max (floor ((tan minArcY) * doubleR)) x
        maxY = ceiling ((tan maxArcY) * doubleR)

findZ :: Integer -> Integer -> Integer -> Integer
findZ r x y =
    if lowZ > x + y || highZ < x + y
    then 0
    else
        if mod (y + lowZ) 2 == 0
        then lowZ
        else highZ
    where
        doubleR = fromInteger r
        doubleX = fromInteger x
        doubleY = fromInteger y
        arcX = atan (doubleX / doubleR)
        arcY = atan (doubleY / doubleR)
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
    