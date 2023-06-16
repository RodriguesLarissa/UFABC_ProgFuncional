module Exercicios where

-- Função multiplicar, que recebe dois valores inteiros e retorna o produto do primeiro pelo segundo
multiplicar :: Int -> Int -> Int
multiplicar x y = x * y

-- Função cumprimentar, que recebe um nome e retorna "A linguagem preferida de nome é Haskell" (considere o operador de concatenação ++)
cumprimentar :: String -> String
cumprimentar nome = "A linguagem preferida de " ++  nome ++  " é Haskell"

-- Função velocidade, que recebe uma distância em km e a quantidade de horas que ela levou para ser percorrida, ambos do tipo Double, e retorna a string "Isso equivale a {x} km por hora!"
velocidade :: Float -> Float -> String
velocidade distancia tempo = "Isso equivale a " ++ show(distancia/tempo) ++  " kilômetros por hora!"
  where
    x = distancia/tempo

-- Função mult7 n que retorne True caso a entrada seja múltiplo de 7 e False caso contrário.
mult7 :: Int -> Bool
mult7 x
  | x `mod` 7 == 0 = True
  | otherwise      = False

-- Função somaEhMult7, que recebe um dois valores inteiros e retorna se a soma é múltipla de 7
somaEhMult7 :: Int -> Int -> Bool
somaEhMult7 a b = mult7 (a + b)

-- Faça uma função estaNoIntervalo a b c que recebe três inteiros e decida se a está contido no intervalo fechado entre o b e c. Assuma que b < c sempre.
estaNoIntervalo :: Int -> Int -> Int -> Bool
estaNoIntervalo a b c = a `elem` [b..c]

-- Faça uma função todosNoIntervalo :: [Int] -> Int -> Int -> Bool que determina se todos os números da primeira lista estão no intervalo descrito pelo segundo e terceiro argumento.
todosNoIntervalo :: [Int] -> Int -> Int -> Bool
todosNoIntervalo as b c
  | null as         = True 
  | x `elem` [b..c] = todosNoIntervalo (drop 1 as) b c
  | otherwise       = False
  where
    x = head as

-- Similarmente, faça uma função algumNoIntervalo :: [Int] -> Int -> Int -> Bool que determina se pelo menos um dos números da primeira lista está no intervalo descrito pelo segundo e terceiro argumento.
algumNoIntervalo :: [Int] -> Int -> Int -> Bool
algumNoIntervalo as b c 
  | null as         = False
  | x `elem` [b..c] = True
  | otherwise       = algumNoIntervalo (drop 1 as) b c
  where
    x = head as

-- Faça uma função ehPerfeito n que determine se um número é perfeito.
ehPerfeito :: Int -> Bool
ehPerfeito n
  | sum xs == n = True
  | otherwise   = False
  where
    xs = [x | x <- [1..n-1], n `mod` x == 0]

-- Faça uma função procuraSeis que retorne todos os os números entre 0 e 999 cuja soma dos dígitos é 6.
somaDigitosSeis :: Int -> Bool
somaDigitosSeis x
  | x == 6      = True
  | sum (digs x) == 6 = True
  | otherwise   = False

digs :: Int -> [Int]
digs 0 = []
digs x = digs (x `div` 10) ++ [x `mod` 10]

procuraSeis :: [Int]
procuraSeis = as
  where
    as = [x | x <- [0..999], somaDigitosSeis x]
