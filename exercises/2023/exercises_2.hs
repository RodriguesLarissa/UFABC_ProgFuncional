module Exercicios where

import Data.Char (isAlphaNum)

-- Função multiplicar, que recebe dois valores inteiros e retorna o produto do primeiro pelo segundo
multiplicar :: Num a => a -> a -> a
multiplicar x y = x * y

-- Função cumprimentar, que recebe um nome e retorna "A linguagem preferida de nome é Haskell" (considere o operador de concatenação ++)
cumprimentar :: String -> String
cumprimentar nome = "A linguagem preferida de " ++ nome ++ " é Haskell"

-- Função velocidade, que recebe uma distância em km e a quantidade de horas que ela levou para ser percorrida, ambos do tipo Float, e retorna a string "Isso equivale a {x} km por hora!"
velocidade :: Float -> Float -> String
velocidade distancia tempo = "Isso equivale a " ++ show(distancia/tempo) ++ " kilômetros por hora!"

-- Função mult7 n que retorne True caso a entrada seja múltiplo de 7 e False caso contrário.
mult7 :: Int -> Bool
mult7 x = x `mod` 7 == 0

-- Função somaEhMult7, que recebe um dois valores inteiros e retorna se a soma é múltipla de 7
somaEhMult7 :: Int -> Int -> Bool
somaEhMult7 a b = mult7 (a+b)

-- Faça uma função estaNoIntervalo a b c que recebe três inteiros e decida se a está contido no intervalo fechado entre o b e c. Assuma que b < c sempre.
estaNoIntervalo :: Int -> Int -> Int -> Bool
estaNoIntervalo a b c = a `elem` [b..c]

-- Faça uma função todosNoIntervalo :: [Int] -> Int -> Int -> Bool que determina se todos os números da primeira lista estão no intervalo descrito pelo segundo e terceiro argumento.
todosNoIntervalo :: [Int] -> Int -> Int -> Bool
todosNoIntervalo as b c = all (== True) (listaBoolNoIntervalo as b c)

listaBoolNoIntervalo :: [Int] -> Int -> Int -> [Bool]
listaBoolNoIntervalo as b c = [estaNoIntervalo a b c | a <- as]

-- Similarmente, faça uma função algumNoIntervalo :: [Int] -> Int -> Int -> Bool que determina se pelo menos um dos números da primeira lista está no intervalo descrito pelo segundo e terceiro argumento.
algumNoIntervalo :: [Int] -> Int -> Int -> Bool
algumNoIntervalo as b c = not (all (== False) (listaBoolNoIntervalo as b c))

-- Faça uma função ehPerfeito n que determine se um número é perfeito.
ehPerfeito :: Int -> Bool
ehPerfeito n = sum xs == n
  where
    xs = [x | x <- [1..n-1], n `mod` x == 0]

-- Faça uma função procuraSeis que retorne todos os os números entre 0 e 999 cuja soma dos dígitos é 6.
somaDigitosSeis :: Int -> Bool
somaDigitosSeis x = somaDigitos x == 6

somaDigitos :: Int -> Int
somaDigitos 0 = 0
somaDigitos x = (x `mod` 10) + somaDigitos (x `div` 10)

procuraSeis :: [Int]
procuraSeis = [x | x <- [0..999], somaDigitosSeis x]

comprimentoAoQuadrado :: [String] -> [Int]
comprimentoAoQuadrado xs = map (^2) (map length xs)

findLast :: (a -> Bool) -> [a] -> a
findLast f xs = head [x | x <- (reverse xs), f x]

gerarUsuarios :: Int -> String -> [String]
gerarUsuarios n prefixo = [prefixo ++ show x | x <- [1..n]]

descontoDaSorte :: [Int] -> [Int]
descontoDaSorte xs = [x-10 | x <- xs, not (mult7 (x-10))]

limparUsernames :: [String] -> [String]
limparUsernames xss = map limpaPalavra xss

limpaPalavra :: String -> String
limpaPalavra xs = [x | x <- xs, isAlphaNum x]

maisDaMetade :: (a -> Bool) -> [a] -> Bool
maisDaMetade f xs = length [x | x <- xs, f x] > length xs `div` 2

filterDesastrado :: (a -> Bool) -> [a] -> [a]
filterDesastrado f xs = filterDesastradoAux f xs []

filterDesastradoAux :: (a -> Bool) -> [a] -> [a] -> [a]
filterDesastradoAux f [] aux = reverse aux
filterDesastradoAux f (x:xs) aux  | f x = filterDesastradoAux f xs (x:aux)
                                  | otherwise = filterDesastradoAux f xs (drop 1 aux)

palavraMaisLonga :: [String] -> String
palavraMaisLonga [] = ""
palavraMaisLonga [x] = x
palavraMaisLonga (x:xs)
    | length x >= length (palavraMaisLonga xs) = x
    | otherwise = palavraMaisLonga xs

jogadorBlackJack :: [Int] -> Bool
jogadorBlackJack xs = somaTotal <= 21
    where somaTotal = sum (comprarCartas xs [])

comprarCartas :: [Int] -> [Int] -> [Int]
comprarCartas [] aux = aux
comprarCartas (x:xs) aux
  | sum aux <= 18 = comprarCartas xs (x:aux)
  | otherwise = aux