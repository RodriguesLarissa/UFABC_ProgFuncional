module Exercicios where

import Data.Char (isAlphaNum)

comprimentoAoQuadrado :: [String] -> [Int]
comprimentoAoQuadrado = map ((^2) . tamanho) 

tamanho :: [a] -> Int  
tamanho = foldr(\_ n -> 1 + n) 0 

---------------------------------------------------

findLast :: (a -> Bool) -> [a] -> a
findLast f xs
  | f x         = x
  | otherwise   = findLast f (init xs)
    where x = last xs

---------------------------------------------------

gerarUsuarios :: Int -> String -> [String]
gerarUsuarios n xs = map xss [1..n]
  where xss x = xs ++ show x

---------------------------------------------------

descontoDaSorte :: [Int] -> [Int]
descontoDaSorte = filter notMultSeven . map (-10 +)

notMultSeven :: Int -> Bool
notMultSeven n 
  | n `mod` 7 == 0 = False 
  | otherwise      = True

---------------------------------------------------

limparUsernames :: [String] -> [String]
limparUsernames = map limpaPalavra

limpaPalavra :: String -> String
limpaPalavra xs = [x | x <- xs, isAlphaNum x]

--------------------------------------------------- 

maisDaMetade :: (a -> Bool) -> [a] -> Bool
maisDaMetade f xs
  | (length xs `div` 2) < quantidade f xs = True
  | otherwise                         = False

quantidade :: (a -> Bool) -> [a] -> Int
quantidade f xs = length (filter f xs)

---------------------------------------------------

filterDesastrado :: (a -> Bool) -> [a] -> [a]
filterDesastrado f [] = []
filterDesastrado f (x:xs)
  | null xs && f x     = x : filterDesastrado f xs
  | null xs            = filterDesastrado f xs
  | f (head xs) && f x = x : filterDesastrado f xs
  | otherwise          = filterDesastrado f xs
    where flag = 0   
  
---------------------------------------------------

palavraMaisLonga :: [String] -> String
palavraMaisLonga xss = head (filterMaiores xss)

filterMaiores :: [String] -> [String]
filterMaiores xss = filter (\n -> length n == intMaior xss) xss

intMaior :: [String] -> Int
intMaior = maximum . map length

---------------------------------------------------

jogadorBlackJack :: [Int] -> Bool
jogadorBlackJack xs
  | valorTotal xs <= 21 = True
  | otherwise           = False
 
valorTotal ::[Int] -> Int
valorTotal xs
  | sum xs <= 18 = 18
  | otherwise = head $ dropWhile (<= 18) $ scanl1 (+) xs 
