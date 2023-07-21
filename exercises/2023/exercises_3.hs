module Atividade03
    ( integersDePrimos,
    bissextos32,
    pop,
    range,
    palindrome,
    maximo,
    minimo,
    media,
    xou,
    ehQuadradoPerfeito,
    ehSaudavel,
    penultimo,
    isHead,
    isSecond,
    isAt,
    mediaLista,
    isFirstEqualThird,
    quadradoMaisProximo,
    ethiopianMultiplication,
    isEven,
    isOdd,
    naturais,
    pp,
    natdesc
    ) where

import Data.Char (toLower)

integersDePrimos :: [Integer] -> [Integer]
integersDePrimos xs = filter ehPrimo xs
    where   
        ehPrimo n = divisores n == [1,n]
        divisores n = [x | x <- [1..n], n `mod` x == 0]

bissextos32 :: [String]
bissextos32 = reverse $ map show $ filter (\x -> ehBissexto x && multiplo32 x) [1584..2016]
    where 
        ehBissexto x = x `mod` 4 == 0 && (x `mod` 100 /= 0 || x `mod` 400 == 0)
        multiplo32 x = x `mod` 32 == 0

pop :: [Integer] -> Integer -> [Integer]
pop [] _ = []
pop (x:xs) 0 = xs
pop (x:xs) n = x : pop (xs) (n-1)

range :: [Int] -> Int -> Int -> [Int]
range xs i j = [x | (idx, x) <- zip [0..(length xs)-1] xs, idx >= i && idx < j]

palindrome :: String -> Bool
palindrome [] = True
palindrome [_] = True
palindrome (x:xs) = toLower x == toLower (last xs) && palindrome (init xs)

naturais :: Int -> [Int]
naturais n = [0..n-1]

pp :: Int -> [Int]
pp n = take n [2, 4..]

natdesc :: Int -> [Int]
natdesc n = reverse [0..n-1]

maximo :: Int -> Int -> Int
maximo x y = if (x > y) then x else y

minimo :: Int -> Int -> Int
minimo x y = if (x < y) then x else y

media :: Int -> Int -> Double
media x y = fromIntegral (x + y) / 2.0

xou :: Bool -> Bool -> Bool
xou x y = x /= y

ehQuadradoPerfeito :: Int -> Bool
ehQuadradoPerfeito x = numeroAposRaiz * numeroAposRaiz == x
    where numeroAposRaiz = floor $ sqrt $ (fromIntegral x::Double)

ehSaudavel :: Int -> Bool -> Bool -> Bool
ehSaudavel idade pizza exercicio 
    | (idade < 30 && not pizza) || (idade > 30 && exercicio) = True
    | otherwise = False

penultimo :: [Int] -> Int
penultimo = last . init

isHead :: Int -> [Int] -> Bool
isHead a as = head as == a

isSecond :: Int -> [Int] -> Bool
isSecond n (a:as) = head as == n

isAt :: Int -> Int -> [Int] -> Bool
isAt n a as = as!!n == a

mediaLista :: [Int] -> Double
mediaLista xs = fromIntegral (sum xs) / fromIntegral (length xs)

isFirstEqualThird :: [Int] -> Bool
isFirstEqualThird [] = False
isFirstEqualThird [_] = False
isFirstEqualThird [_, _] = False
isFirstEqualThird (x:y:z:xs) = x == z

quadradoMaisProximo :: Int -> Int
quadradoMaisProximo n 
    | ehQuadradoPerfeito n = n
    | otherwise = quadradoMaisProximo (n+1)

ethiopianMultiplication :: Int -> Int -> Int
ethiopianMultiplication 0 n = 0
ethiopianMultiplication 1 n = n
ethiopianMultiplication m n
    | even m = ethiopianMultiplication (m `div` 2) (n*2)
    | otherwise = ethiopianMultiplication (m `div` 2) ((n*2) + n)

isEven :: Int -> Bool
isEven 0 = True
isEven x = isOdd (x - 1)

isOdd :: Int -> Bool
isOdd 0 = False
isOdd x = isEven (x - 1)