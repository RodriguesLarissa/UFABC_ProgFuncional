{-# LANGUAGE DeriveFunctor #-}
module Main where

import Data.Char
-- Functors 

-- f :: (a -> b) -> (F a -> F b)

  {-
    class Functor f where
      fmap :: (a -> b) -> (f a -> f b)

    Functor Map =/= flat map

    fmap id = id
    fmap f . fmap g = fmap (f.g)

    instance Functor [] where
      fmap f []     = []      
      fmap f (x:xs) = f x : fmap f xs

    instance Functor Maybe where
      fmap _ Nothing = Nothing
      fmap f (Just x) = Just (f x)
  -}

-- > fmap chr (Just 65)
--
-- > fmap(chr . (+1)) (Just 65)
--
-- x = (n+36) `mod` y
-- fmap chr x

    data Tree a = Leaf a | Node (Tree a) a (Tree a)
        deriving (Show, Functor)    

    {-
   
     instance Functor Tree where
       fmap f (Leaf x) = Leaf (f x)
       fmap f (Node l x r) = Node (fmap f l) (f x) (f map f r) 
    
    -}

    t = Node (Node (Leaf 1) 2 (Leaf 3)) 5 (Node (Leaf 6) 7 (Leaf 8))

-- > fmap even t === even <$> t

data Const b a = Const b
  deriving Show

instance Functor (Const b) where
    fmap f (Const x) = Const x 


data Identity a = Identity a

instance Functor Identity where
    fmap f (Identity x) = Identity (f x)

data NadaOuUm a = Lft (Const () a) | Rgt (Identity a)

instance Functor NadaOuUm where
    fmap f (Left x) = Lft (Const c)
    fmap f (Right x) = Rgt (Identity (f x))
-- > c = Const 10 :: Const Int Int

------------------------------------------------------------------
--SafeNum

data SafeNum a = NaN | NegInf | PosInf | SafeNum a
    deriving Show

safeAdd :: Int -> Int -> SafeNum Int
safeAdd x y
  | signum x /= signum y = SafeNum z
  | signum z /= signum x = if signum x > 0
                             then PosInf else NegInf
  | otherwise = SafeNum z 
    where z = x+y

safeDiv :: Int -> Int -> SafeNum Int
safeDiv 0 0 = NaN
safeDiv x 0
  | x > 0     = PosInf
  | otherwise = NegInf
  safeDiv x y = SafeNum (x `div` y)

-- | (x/y) + (y/x)
f0 :: Int -> Int -> SafeNum Int
f0 x y 
  | isSafe xy && isSafe yx = safeAdd (unbox xy) (unbox yx)
  | (not.isSafe) xy        = xy
  | otherwise              = yx
  where xy = safeDiv x y
        yx = safeDiv y x
        unbox (SafeNum x)  = x
        isSafe (SafeNum _) = True
        isSafe _           = False

-- > fmap negate $ safeAdd 5 7
boxedCoerce :: SafeNum a -> SafeNum b
boxedCoerce NaN    = NaN
boxedCoerce NegInf = NegInf
boxedCoerce PosInf = PosInf
boxedCoerce _      = error "Proibido valores seguros"

instance Functor SafeNum where
  fmap f (SafeNum x) = SafeNum (f x)
  fmap _ x           = boxedCoerce x

flatten :: SafeNum (SafeNum a) -> SafeNum a
flatten (SafeNum sn) = sn
flatten v            = boxedCoerce v

f1 :: Int -> Int -> SafeNum Int
f1 x y = 
  let xy = safeDiv x y 
      yx = safeDiv y x
      safeAddXY = fmap safeAdd xy
      safeXYPlusYX = fmap (<$> yx) safeAddXY
  in (flatten.flatten) safeXYPlusYX

main :: IO ()
main = do
  putStrLn "hello world"
