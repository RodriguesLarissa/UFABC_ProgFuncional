{-# LANGUAGE FlexibleInstances    #-}
{-# LANGUAGE TypeSynonymInstances #-}

module Exercicios where

ehTriangulo :: (Ord a, Num a) => a -> a -> a -> Bool
ehTriangulo a b c
  | a + b > c &&
    b + c > a &&
    a + c > b = True
  | otherwise = False


data TipoTriangulo = Escaleno | Isosceles | Equilatero | Nenhum
    deriving (Show, Eq)

determinaTriangulo :: (Ord a, Num a) => a -> a -> a -> TipoTriangulo
determinaTriangulo a b c 
  | not (ehTriangulo a b c)    = Nenhum
  | a == b && b == c           = Equilatero
  | a == b || b == c || a == c = Isosceles
  | otherwise                  = Escaleno


data Horario = HoraMinuto Int Int
  deriving (Show, Read)

somarHorario :: Horario -> Horario -> Horario
somarHorario (HoraMinuto h1 m1) (HoraMinuto h2 m2) =
  if mt >= 60
     then HoraMinuto (ht+1) (mt-60)
     else HoraMinuto ht mt
  where
  mt = m1 + m2
  ht = h1 + h2

data Periodo = Madrugada | Manha | Tarde | Noite
  deriving (Show)

horarioToPeriodo :: Horario -> Periodo
horarioToPeriodo (HoraMinuto h m) 
  | h >= 0 && h <= 5   = Madrugada
  | h >= 6 && h <= 11  = Manha
  | h >= 12 && h <= 17 = Tarde
  | otherwise          = Noite

class Booleanable a where
  toBool :: a -> Bool

instance Booleanable Bool where
  toBool False = False
  toBool _     = True

instance Booleanable Int where
  toBool 0 = False
  toBool _ = True

instance Booleanable Float where
  toBool 0.0 = False
  toBool _   = True

instance Booleanable String where
  toBool "0" = False
  toBool ""  = False
  toBool _   = True

instance Booleanable [Int] where
  toBool [] = False
  toBool _  = True

data Medida = Polegada | Palmo | Pe | Jarda | Milha
  deriving (Show, Read)

converter :: (Num a, Fractional a) => Medida -> Medida -> a -> a
converter Polegada x v 
  | show x == show Polegada = v
  | show x == show Palmo    = v/9
  | show x == show Pe       = v/12
  | show x == show Jarda    = v/36
  | show x == show Milha    = v/63360

converter Palmo x v
  | show x == show Polegada = v*9
  | show x == show Palmo    = v
  | show x == show Pe       = (3*v)/4
  | show x == show Jarda    = v/4
  | show x == show Milha    = v/7040

converter Pe x v
  | show x == show Polegada = v*12
  | show x == show Palmo    = (4*v)/3
  | show x == show Pe       = v
  | show x == show Jarda    = v/3
  | show x == show Milha    = v/5280

converter Jarda x v
  | show x == show Polegada = v*36
  | show x == show Palmo    = v*4
  | show x == show Pe       = v*3
  | show x == show Jarda    = v
  | show x == show Milha    = v/1760

converter Milha x v
  | show x == show Polegada = v*63360
  | show x == show Palmo    = v*7040
  | show x == show Pe       = v*5280
  | show x == show Jarda    = v*1760
  | show x == show Milha    = v

data Nota = Do | Re | Mi | Fa | Sol | La | Si
  deriving (Show, Enum)

data ModoGrego = Jonio | Dorico | Frigio | Lidio | Mixolidio | Eolio | Locrio
  deriving (Show, Read)

gerarModo :: Int -> ModoGrego -> [Nota]
gerarModo n modo
  | show modo == show Jonio     = take n (cycle xs)
  | show modo == show Dorico    = drop 1 (take (n+1) (cycle xs))
  | show modo == show Frigio    = drop 2 (take (n+2) (cycle xs))
  | show modo == show Lidio     = drop 3 (take (n+3) (cycle xs))
  | show modo == show Mixolidio = drop 4 (take (n+4) (cycle xs))
  | show modo == show Eolio     = drop 5 (take (n+5) (cycle xs))
  | show modo == show Locrio    = drop 6 (take (n+6) (cycle xs))
  
  where xs = [Do .. Si]




