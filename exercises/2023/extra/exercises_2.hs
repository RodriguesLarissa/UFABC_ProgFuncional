module Main (main) where

penultimo :: [a] -> a
penultimo [] = error "lista vazia"
penultimo [_] = error "lista unitaria"
penultimo [x, _] = x
penultimo (_:xs) = penultimo xs

maximoLocal :: Ord a => [a] -> [a]
maximoLocal [] = []
maximoLocal [_] = []
maximoLocal [_, _] = []
maximoLocal (x:y:z:zs)  | y > x && y < z = y : maximoLocal (z:zs)
                        | otherwise = maximoLocal (y:z:zs)

divisores :: Integral a => a -> [a]
divisores n = [d | d <- [1..n-1], mod n d == 0]

soma :: Num a => [a] -> a
soma [] = 0
soma (x:xs) = x + soma xs

perfeitos :: Integral a => a -> [a]
perfeitos n = [k | k <- [1..n], soma (divisores k) == k] 

produtoEscalar :: Num a => [a] -> [a] -> a
produtoEscalar xs ys = soma [xs !! i * ys !! i | i <- [0.. length xs-1]]

palindromo :: Eq a => [a] -> Bool
palindromo [] = True
palindromo [_] = True
palindromo (x:xs) = x == last xs && palindromo(init xs)

quickSort :: Ord b => (a -> b) -> [a] -> [a]
quickSort _ [] = []
quickSort key (x:xs) = quickSort key ls ++ [x] ++ quickSort key gs
    where   ls = [y | y <- xs, key y <= key x]
            gs = [y | y <- xs, key y > key x]

main :: IO ()
main = do
    print(penultimo [1::Int,2,3,4,5])
    print(maximoLocal [2::Int, 4, 1, 5, 4, 3])
    print(perfeitos (500::Int))
    print(produtoEscalar [1::Int, 4] [5,6])
    print(palindromo "aabaa")