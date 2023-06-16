module Main where

-- Estrutura Zippers

-- data Lista a = [] | a : Lista a (Lista Unicamente Ligada)

data List a = Empty | Cons a (List a)
-- L(a) = 1 + (a * L(a))
-- L(a) - a * L(a) = 1 
-- L(a) * (1 - a) = 1
-- L(a) = 1 / (1 - a) = 1 + a + a² + a³ + ... (Série de Taylor)
--
-- L(a) = 1 + (a * (1 + a * L(a)))
--      = 1 + a + a² * L(a)
--      = 1 + a + a² + a³ * L(a)
--
-- L'(a) = 1 / (1 - a)² = (1/(1-a))*(1/(1-a))
--       = L(a) * L(a)

-- type DiffList a = Pair (List a) (List a)

data Zipper a = Z [a] [a]
            deriving Show

toZipper :: [a] -> Zipper a
toZipper xs = Z [] xs

fromZipper :: Zipper a -> [a]
fromZipper (Z lft rgt) = reverse lft ++ rgt

-- Exemplo:
-- Z [] (x:xs)
-- Z [x] (y:xs)
-- Z [y,x] (z:xs)

focus :: Zipper a -> a
focus (Z _ []) = error "List vazia!"
focus (Z _ (x:xs)) = x

walkLeft, walkRight :: Zipper a -> Zipper a
walkRight (Z lft [])      = Z lft []
walkRight (Z lft (x:rgt)) = Z (x:lft) rgt

walkLeft (Z [] rgt)      = Z [] rgt
walkLeft (Z (x:lft) rgt) = Z lft (x:rgt)

-- > xs = [1,2,3,4]
-- 
-- > zs = toZipper xs
--
-- > print zs
--
-- > (walkLeft . walkRight . walkRight) zs

-- Arvore

data Tree a = Leaf | Node (Tree a) a (Tree a)
                   deriving Show

-- T(a) = 1 + a * T(a) * T(a)
-- T'(a) = T(a)² * (1 / 1 - 2 * a * T(a))

data ZipTree' a = ZT' { left' :: Tree a
                     , right' :: Tree a
                     , focus' :: [Either (a, Tree a) (a, Tree a)]
                     } deriving Show

-- 1 + 1*T + 2*T² + 4*T³ + ...
-- Somatoria i=1 .. (2^{i-1}T^{i}) = T / (1 - 2*T)

data ZipTree a = ZT { tfocus :: Tree a
                    , histo  :: [Either (Tree a) (Tree a)]
                    } deriving Show

toZipTree :: Tree a -> ZipTree a
toZipTree Leaf = ZT Leaf []
toZipTree n    = ZT n []

fromZipTree :: ZipTree a -> Tree a
fromZipTree tz =
  case histo tz of
    [] -> tfocus tz
    _  -> fromZipTree (goUp tz)

goLeft, goRight, goUp :: ZipTree a -> ZipTree a
goLeft tz = 
  case tfocus tz of
    Node Leaf _ _ -> tz
    Node l x r    -> ZT l (Left (Node Leaf x r) : histo tz)

goRight tz =
  case tfocus tz of
    Node _ _ Leaf -> tz
    Node l x r     -> ZT r (Right (Node l x Leaf) : histo tz)

goUp tz@(ZT f [])  = tz
goUp (ZT f (h:hs)) =
  case h of 
    Left (Node _ x r) -> ZT (Node f x r) hs
    Right (Node l x _) -> ZT (Node l x f) hs

t :: Tree Int
t = Node
     (Node
      (Node Leaf 4 Leaf)
      2
      (Node Leaf 5 Leaf))
     1
     (Node Leaf 3 Leaf)

 {- 
          1
       2     3
     4   5

 -} 

tz = toZipTree t

-- $> tz
--
-- $> goLeft tz
--
-- $> (goUp . goLeft) tz

main :: IO ()
main = do
  putStrLn "hello world"
