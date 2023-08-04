module Main (main) where

allBips :: [a] -> [([a], [a])]
allBips [] = error "lista vazia"
allBips [_] = error "lista unitaria"
allBips xs = [(take n xs, drop n xs) | n <- [1..length xs -1]]

data BTPar a = Leaf a | Node (BTPar a) (BTPar a)
    deriving Show

allTrees :: [a] -> [BTPar a]
allTrees [] = []
allTrees [x] = [Leaf x]
allTrees xs = [Node l r |   (ys, zs) <- pss,
                            l <- allTrees ys,
                            r <- allTrees zs]
    where pss = allBips xs

class Semigroup a where
    (<>) :: a -> a -> a
    stimes :: Integral b => b -> a -> a
    stimes n _ | n <= 0 = error "deve ser pelo menos 1"
    stimes 1 x = x
    stimes n x  | even n = k <> k
                | otherwise = x <> stimes (n-1) x
        where k = stimes (div n 2) x

    sconcat :: NonEmpty a -> a
    sconcat (x :| []) = x
    sconcat (x :| (y:xs)) = x <> sconcat (y :| xs)

data NonEmpty a = a :| [a]
    deriving Show

class Functor f where
    fmap, (<$>) :: (a -> b) -> f a -> f b
    (<*>) = fmap

instance Functor NonEmpty where
    fmap f (x :| []) = f x :| []
    fmap f (x :| (y:xs)) = f x :| (z:zs) 
        where (z :| zs) = fmap f (y :| xs)

naiveTimes :: (Semigroup a, Integral b) => b -> a -> a
naiveTimes n _ | n <= 0 = error "deve ser pelo menos 1"
naiveTimes 1 x = x
naiveTimes n x = x <> naiveTimes (n-1) x

newType Sum a = Sum a
newType Prod a = Prod a

instance Num a => Semigroup (Sum a) where
    (Sum x) <> (Sum y) = Sum (x + y)

instance Num a => Semigroup (Prod a) where
    (Prod x) <> (Prod y) = Prod (x * y)

pairing :: (a -> a -> a) -> [a] -> [a]
pairing _ [] = []
pairing _ [x] = [x]
pairing f (x:y:xs) = f x y : pairing f xs

fastConcat :: Semigroup a => NonEmpty a -> a
fastConcat (x :| []) = x
fastConcat (x :| xs) = fastConcat (head ys :| tail ys)
    where ys = pairing (<>) (x:xs)

class Semigroup a => Monoid a where
    mempty :: a
    mtimes :: Integral b => b -> a -> a
    mtimes 0 _ = mempty
    mtimes n x = stimes n xs

    mconcat :: [a] -> a
    mconcat [] = mempty
    mconcat (x:xs) = sconcat (x :| xs)

merge :: Ord a => [a] -> [a] -> [a]
merge xs [] = xs
merge [] ys = ys
merge (x:xs) (y:ys) | x <= y = x : merge xs (y:ys)
                    | otherwise = y : merge (x:xs) ys

newtype Sorted a = Sorted [a]

instance Ord a => Semigroup (Sorted a) where
    (Sorted xs) <> (Sorted ys) = Sorted (merge xs ys)

instance Ord a => Monoid (Sorted a) where
    mempty = Sorted []

mergeSort :: Ord a => [a] -> [a]
mergeSort xs = rs
    where Sorted rs = mconcat [Sorted [x] | x <- xs]

main :: IO ()
main = do
    print $ allTrees [1,2,3,4,5]
    print $ stimes 5 (Sum 10)
    print $ stimes 10 (Prod 2)
    print $ sconcat (Sum <$> (1 :| [2,3,4,5]))