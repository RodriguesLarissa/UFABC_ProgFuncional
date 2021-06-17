module Main where

soma :: Int -> Int -> Int 
soma x y = x + y

dobra = (*2)
metade = (/2)
reciproco = (1/)

-- > soma3 = soma 3
--
-- > soma3 2
-- 
-- > :t soma3
--
-- > dobra 5
--
-- > metade 4
--
-- > reciproco 10

duasVezes :: (a -> a) -> a -> a
duasVezes f x = f (f x)

quadruplica = duasVezes dobra

x = quadruplica 2.0

-- > duasVezes dobra 3
--
-- > duasVezes reverse [1,2,3]
--
-- > :t quadruplica

-- * Funcoes de Alta Ordem
--
-- [f x | x <- xs]
--

map' :: (a -> b) -> [a] -> [b]
map' f xs = [f x | x <- xs]

map'' :: (a -> b) -> [a] -> [b]
map'' f [] = []
map'' f (x:xs) = f x : map f xs

-- > map' (+1) [1,2,3]
--
-- > map' even [1,2,3]
--
-- > map' reverse ["ola", "mundo"]
-- 
-- [x | x <- xs, p x]

filter' :: (a -> Bool) -> [a] -> [a]
filter' p xs = [x | x <- xs, p x]

filter'' :: (a -> Bool) -> [a] -> [a]
filter'' p [] = []
filter'' p (x:xs)
  | p x       = x : filter'' p xs
  | otherwise = filter'' p xs

-- > filter' even [1..10]
--
-- > filter' (\s -> length s < 4) ["ola", "mundo"]
--
-- > filter'' (<5) [1..10]

somaQuadPares :: [Int] -> Int
--somaQuadPares ns = sum [n^2 | n <- ns, even n]
somaQuadPares ns = sum 
                   $ map (^2)
                   $ filter even ns

-- > somaQuadPares [1..10]
--
-- > :t ($)
--
-- $> all even [2,4,6]
--
-- $> any odd [2,4,6,8]
--
-- $> takeWhile even [2,4,5,7,8]
--
-- $> dropWhile even [2,4,6,7,8]

main :: IO ()
main = do
  putStrLn "hello world"
