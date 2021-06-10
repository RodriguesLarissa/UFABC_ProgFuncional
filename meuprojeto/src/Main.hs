-- Código feito pelo professores Emílio Francesquini e Fabrício Olivetti na universidade UFABC.
-- Refeito para treinamento.

module Main where

tamanho :: [a] -> Int
tamanho [] = 0
tamanho (_:xs) = 1 + tamanho xs

impar :: Integral a => a -> Bool 
impar n = n `mod` 2 == 1 

quadrado :: Num a=> a -> a
quadrado x = x * x 

quadradoMais6Mod9 :: Integral a => a -> a
quadradoMais6Mod9 x = (x + 6) `mod` 9

raizes2Grau :: Floating a => a -> a -> a -> (a, a)
raizes2Grau a b c = (((-b) + sqrt(b^2 - 4 * a * c)) / (2 * a),
                     ((-b) - sqrt(b^2 - 4 * a * c)) / (2 * a))

raizes2GrauV2 :: Floating a => a -> a -> a -> (a, a)
raizes2GrauV2 a b c = (x1, x2)
  where
    x1 = ((-b) + sqDelta) / (2 * a)
    x2 = ((-b) - sqDelta) / (2 * a)
    sqDelta = sqrt delta
    delta = b^2 - 4 * a * c

raizes2GrauV3 :: (Ord a, Floating a) => a -> a -> a -> (a, a)
raizes2GrauV3 a b c = (x1, x2)
  where
    x1 = if delta >= 0 then ((-b) + sqDelta) / (2 * a) else 0
    x2 = if delta >= 0 then ((-b) - sqDelta) / (2 * a) else 0
    sqDelta = sqrt delta
    delta = b^2 - 4 * a * c

raizes2GrauV4 :: (Ord a, Floating a) => a -> a -> a -> (a, a)
raizes2GrauV4 a b c =
  if delta < 0
  then error "Delta negativo"
  else (x1, x2)
  where
    x1 = ((-b) + sqDelta) / (2 * a)
    x2 = ((-b) - sqDelta) / (2 * a)
    sqDelta = sqrt delta
    delta = b^2 - 4 * a * c


abs :: (Num a, Ord a) => a -> a 
abs n = if n < 0 then (-n) else n

signum :: (Num a, Ord a) => a -> a
signum n = if n < 0
           then -1
           else if n == 0
                then 0
                else 1

signumV2 :: (Num a, Ord a) => a -> a
signumV2 n
  | n < 0     = -1
  | n == 0    = 0
  | otherwise = 1

nao :: Bool -> Bool
nao x = if x then False else True

naoV2 :: Bool -> Bool 
naoV2 x 
  | x = False
  | otherwise = True

naoV3 :: Bool -> Bool 
naoV3 True = False
naoV3 False = True

soma :: (Eq a, Num a) => a -> a -> a
soma 0 y = y
soma x 0 = x
soma x y = x + y

mult :: (Eq a, Num a) => a -> a -> a
mult 0 _ = 0
mult _ 0 = 0
mult x 1 = x
mult 1 y = y
mult x y = x * y

indexa :: [a] -> Int -> a
indexa xs i = head (drop i xs)

fatorial :: Integer -> Integer
fatorial n = product [2..n]

fatorial2 :: Integer -> Integer 

fatorial2 0 = 1
fatorial2 n = n * fatorial2 (n - 1)

mdc :: Int -> Int -> Int 
mdc a 0 = a
mdc a b = mdc b (a `mod` b)

somaLista :: Num a => [a] -> a
somaLista [] = 0
somaLista (x:xs) = x + somaLista xs

tamanho2 :: [a] -> Int
tamanho2 [] = 0
tamanho2 (_:xs) 1 + tamanho2 xs

produtoLista :: Num a => [a] -> a
produtoLista [] = 1
produtoLista (x:xs) = x * produtoLista xs

pairs :: [a] -> [(a, a)]
pairs xs = zip xs (tail xs)

sorted :: Ord a => [a] -> Bool
sorted xs = null[() | (p,s) <- pairs xs, p > s]

qsort :: Ord a => [a] -> [a]
qsort [] = []
qsort (x:xs) = 
  qsort menores ++ [x] ++ qsort maiores
  where
    menores = [e | e <- xs, e < x]
    maiores = [e | e <- xs, e >= x]

main :: IO ()
main = do
  putStrLn "hello world"
