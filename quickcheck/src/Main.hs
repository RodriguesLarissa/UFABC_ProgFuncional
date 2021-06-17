-- Exemplos realizados pelos professores Emílio Francesquini e Fabrício Olivetti 
-- para aula de "Paradigmas da Programação" na instituição UFABC

module Main where

import Test.QuickCheck
import Data.List

qsort :: Ord a => [a] -> [a]
qsort [] = []
qsort (x:xs) = qsort lhs ++ [x] ++ qsort rhs
  where
    lhs = [e | e <- xs, e <= x]
    rhs = [e | e <- xs, e > x]

prop_idempotencia :: Ord a => [a] -> Bool
prop_idempotencia xs = qsort (qsort xs) == qsort xs

prop_length :: Ord a => [a] -> Bool
prop_length xs = length (qsort xs) == length xs

prop_minimum :: Ord a => [a] -> Property 
prop_minimum xs = not (null xs) 
                  ==> head (qsort xs) == minimum xs

prop_model :: Ord a => [a] -> Bool
prop_model xs = qsort xs == sort xs

-- * Paridade
par x = x `mod` 2 == 0
impar x = x `mod` 2 == 1

prop_alternanciaParImpar :: Integral  a => a -> Bool
prop_alternanciaParImpar n = par n /= par (n+1)

prop_seImparNaoPar :: Integral a => a -> Property 
prop_seImparNaoPar n = par n ==> not (impar n)

-- > quickCheck  prop_alternanciaParImpar
--
-- > quickCheck prop_seImparNaoPar
--
-- * Fatorial

fatorial n
  | n == 0     = 1
  | n == 1     = 1
  | otherwise  = n * fatorial (n-1)

prop_fatorialNFatorialNFatorialNMaisUm (NonNegative n) = 
  fatorial n * (n+1) == fatorial (n+1)

-- > quickCheck prop_fatorialNFatorialNFatorialNMaisUm

-- * Collatz
-- n | par n = n `div` 2
--   | impar n = n*3 + 1
--   n == 1
collatz :: Integral  a => a -> a
collatz 1 = 1
collatz n
  | par n     = collatz (n `div` 2)
  | otherwise = collatz (3*n + 1)

prop_collatz :: Integral a => Positive a -> Bool
prop_collatz (Positive n) = collatz n == 1

-- $> quickCheckWith stdArgs {maxSuccess = 5000} prop_collatz

main :: IO ()
main = do
  putStrLn "hello world"
