module Main where

import Prelude hiding (sum, head, last, all, any, product, length)
import Data.Foldable (foldl')
import Data.Monoid
  {-# LANGUAGE ExistentialQuantification #-}

-- Monoid

  {- M = (V, <>, e)

     (Integer, +, 0)
     (Integer, *, 1)
     (String, ++, "")
 
     (a <> b) <> c = a <> (b <> c)
     a <> e = a
     e <> a = a

     a <> b = b <> a -- comutativos

  -}

  {-
     class Monoid a where
       mempty :: a
       mappend :: a -> a -> a

       mconcat :: [a] -> a
       mconcat = foldr mappend mempty

-- Monoid livre = possui as propriedades de um monoid e nada além.
     intance Monoid [a] where
       mempty = []
       mappend (++) -- nao comutativo, associativo
  -}

  {-

    data Sum a = Sum a
    
    instance Sum a where
      mempty = Sum 0
      mappend = (+) -- comutativo e associativo
      
  -}

   {-

    instance Monoid a => Monoid (Maybe a) where
      mempty = Nothing
      mappend Nothing y = y
      mappend x Nothing = x
      mappend (Just x) (Just y) = Just (x `mappend` y)
      
      mappend = (<>) -- operador binario de concatenação do monoid
   
   -}

-- Foldable - Todas as estruturas que podem ser dobradas
 
 {-
  fold :: Monoid a => [a] -> a
  fold [] = mempty
  fold (x:xs) = x `mappend` fold xs
 -}

-- fold xs = foldr mappend mempty xs
  

 {-
  fold' :: Monoid a => Tree a -> a
  fold' (Leaf x) = x
  fold' (Node l r) = fold' l <> fold' r
 -}

  {-
class Foldable t where 
  fold :: Monoid a => t a -> a
  foldMap :: Monoid b => (a -> b) -> t a -> b
  foldr :: (a -> b -> a) -> b -> t a -> b
  foldl :: (a -> b -> a) -> a -> t b -> a

newtype Sum a = Sum a
newtype Product a => Product

instance Num a => Monoid (Sum a) where
  mempty = Sum 0
  mappend x y = x + y
  mappend (Sum x) (Sum y) = Sum (x+y)

instance Num a => Monoid (Product a) where
  mempty = Product 1
  mappend (Product x) (Product y) = Product (x*y) 

-}

-- > foldMap Sum [1..10]
--
-- > foldMap Product [1..10]

data Tree a = Leaf a | Node (Tree a) (Tree a)

instance Foldable Tree where
  foldMap f (Leaf a) = f a
  foldMap f (Node l r) = foldMap f l <> foldMap f r

t = Node
      (Node
        (Leaf 1)
        (Leaf 2)
      )
      (Node 
        (Leaf 3)
        (Leaf 4)
      )

-- > foldMap Sum t
--
-- > foldMap Product t

toList' :: Foldable t => t a -> [a]
toList' = foldMap (\x -> [x])

-- > toList' t 

average :: [Double] -> Double
average ns = sum ns / (fromIntegral.length) ns

-- > average t

------------------------------------------------
-- Fold

average' :: Foldable t => t Double -> Double
average' xs = getSum soma / getSum contagem
  where
    (soma, contagem) = foldMap (\x -> (Sum x, Sum 1.0)) xs

-- foldMap (\x -> (Sum x, Sum 1.0, Product x, And (x>0))) xs

data Fold i o = forall m . Monoid m  =>  Fold (i -> m) (m -> o)

fold' :: Fold i o -> [i] -> o
fold' (Fold toMonoid summarize) is =
  summarize (foldl' (<>) mempty (map toMonoid is))
-- summarize (foldMap toMonoid is)

sum :: Num n => Fold n n 
sum = Fold Sum getSum

head :: Fold a (Maybe a)
head = Fold (First . Just) getFirst

last :: Fold a (Maybe a)
last = Fold (Last . Just) getLast

all :: (a -> Bool) -> Fold a Bool
all p = Fold (All . p) getAll

any :: (a -> Bool) -> Fold a Bool
any p = Fold (Any . p) getAny

product :: Num n => Fold n n 
product = Fold Product getProduct

length :: Num n => Fold i n 
length = Fold (\_ -> Sum 1) get/Sum
-- length = Fold (Sum . const 1) getSum

(<+>) :: Fold i a -> Fold i b -> Fold i (a,b)
Fold mL sL <+> Fold mR sR = Fold toMonoid summarize
  where
    toMonoid x = (mL x, mR x)
    summarize (x, y) = (sL x, sR y)

(<.>) :: (o1 -> o2) -> Fold i o1 -> Fold i o2
f <.> Fold toMonoid summarize = Fold toMonoid (f . summarize)

infixr 6 <+>
infixl 5 <.>
avg :: Fractional n => Fold n n
avg = uncurry (/) <.> sum <+> length

-- > fold' avg [0..10]


main :: IO ()
main = do
  putStrLn "hello world"
