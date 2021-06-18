module Main where

-- * Fold

{-

  foldr :: (a -> b -> b) -> b -> [a] -> b
  foldr f v [] = v
  foldr f v (x:xs) = f x (foldr f v xs)

  a1 `f` (a2 `f` (a3 `f` v))

-}

-- > foldr (+) 0 [1..3]
-- 1 + (2 + (3 + 0))

produto :: Num a => [a] -> a
produto = foldr (*) 1
-- > produto [1..3]

tamanho :: [a] -> Int
tamanho = foldr(\_ n -> 1 + n) 0
-- > tamanho [1..10]

snoc x xs = xs ++ [x]
reverso  :: [a] -> [a]
-- reverso [] = []
-- reverso (x:xs) = reverso xs ++ [x]

reverso = foldr snoc []
-- > reverso [1..10]

soma :: Num a => [a] -> a
soma = soma' 0
  where
    soma' v [] = v
    soma' v (x:xs) = soma' (v+x) xs

-- foldl :: (a -> b -> a) -> a -> [b] -> a
-- foldl f v [] = v
-- foldl f v (x:xs) = foldl f (f v x) xs
--
-- 1 : (2 : (3 : []))
-- ((v `f` 3) `f` 2) `f` 1)

soma'', produto'' :: Num a => [a] -> a
soma'' = foldl (+) 0
produto'' = foldl (*) 1

tamanho'' :: [a] -> Int
tamanho'' =  foldl (\n _ -> n + 1) 0
-- > tamanho'' [1..10]
-- flip :: (a -> b -> c) -> (b -> a -> c)
-- flip f = \x y -> f y x

reverso'' :: [a] -> [a]
reverso'' = foldl (flip (:)) []
-- > reverso'' [1..10]
--
-- foldl (&&) False [False, False, False, False]
-- (False && False) && False) && False ...
--
-- foldr
-- False && (False && (False ..
--
-- False && _ = False
-- _ && False = False
-- _ && _ = True

-- É possível importar o foldl' que evita o estouro de pilha de recursão

-- * Funções
-- (f . g) x = f (g x)
-- (.) :: (b -> c) -> (a -> b) -> (a -> c)
-- f . g = \x -> f (g x)

-- São associativas: (f . g) . h = f . (g . h)
-- Função identidade: f . id = id . f = f

-- fn x = ceiling (negate (tan (cos (max 50 x))))
-- fn = (ceiling . negate . tan . cos . max 50)

somaDosQuadradosImpares = 
  sum (takeWhile (<10000) (filter odd (map (^2) [1..])))

somaDosQuadradosImpares' = sum
                         $ takeWhile (<10000)
                         $ filter odd
                         $ map (^2) [1..]

somaDosQuadradosImpares'' = sum . takeWhile (<10000) . filter odd . map (^2) $ [1..]

somaDosQuadradosImpares''' = 
  let oddSquares = (filter odd . map (^2)) [1..]
      belowLimit = takeWhile (<10000) oddSquares
  in sum belowLimit

-- Outro exemplo:
-- $>  map ((+1).(*2)) [1..100]


main :: IO ()
main = do
  putStrLn "hello world"
