module Main where

-- Classes de Tipo
--
-- Exemplos: Eq, Ord, Show, Read, Num, Integral, Fractional, Floating, Enum

-- class Eq a where
--  (==), (/=) :: a -> a -> Bool
--
--  x /= y = not (x==y)
--  x == y = not (x/=y)

data Bool' = Falso | Verdadeiro

instance Eq Bool' where
  Falso == Falso           = True
  Verdadeiro == Verdadeiro = True
  _ == _                   = False

-- > Falso == Falso
--
-- > Falso /= Verdadeiro

-- Tipo: coleção de valores relacionados
-- Classe: coleção de tipos
-- Métodos: funções de uma classe
-- Instância: a definição dos métodos de uma classe pra um tipo

-- Read
data Ponto = P Double Double deriving (Show, Read)
-- > read "P 0.1 0.3" :: Ponto

-- Integral
--
-- > 10 `quot` (-3)
--
-- > 10 `div` (-3)

-- Enum
data Dias = Dom | Seg | Ter | Qua | Qui | Sex | Sab
  deriving (Show, Enum)

-- $> succ Dom
--
-- $> pred Seg
-- 
-- $> fromEnum Seg
--
-- $> toEnum 1 :: Dias
--
-- $> [Dom, Qua .. Sab]

main :: IO ()
main = do
  putStrLn "hello world"
