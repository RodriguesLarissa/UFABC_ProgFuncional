module Main where

--Type

type Produto = (Integer, String, Double)
type Cliente = (Integer, String, Double)

preco :: Produto -> Double
preco (_, _, p) = p

pago :: Cliente -> Double
pago  (_, _, p) = p

atualizaPreco :: Produto -> Double -> Produto
atualizaPreco (idProd, nome, preco) inflacao = (idProd, nome, preco*(1 + inflacao))

troco :: Produto -> Cliente -> Double
troco p c = pago c - preco p

-- > prod = (1, "queijo", 100)
--
-- > cli = (1, "Lucas", 200)
--
-- > troco prod cli

type Assoc k v = [(k,v)]

find :: Eq k => k -> Assoc k v -> v
find k t = head [v | (k', v) <- t, k' == k]

-- > find 5 [(1,3), (5,4), (2,3), (1,1)]

--ADT
--
-- Tipo Soma

data Dir = Norte | Sul | Leste | Oeste
                 deriving Show

-- > print Norte

type Coord = (Int, Int)
type Passo = Coord -> Coord

para :: Dir -> Passo
para Norte (x, y) = (x, y+1)
para Sul   (x, y) = (x, y-1)
para Leste (x, y) = (x+1, y)
para Oeste (x, y) = (x-1, y)

-- > para Norte (0, 0)
--
-- > para Leste (0, 0)

caminhar :: [Dir] -> Passo
caminhar ds coord = foldl (flip para) coord ds

-- > caminhar [Norte, Norte, Leste, Norte, Sul, Oeste] (0,0)

-- Tipo Produto

data Ponto = MkPonto Double Double
                     deriving Show

dist :: Ponto -> Ponto -> Double
dist (MkPonto x y) (MkPonto x' y') =
  sqrt $ (x-x')^2 + (y-y')^2

-- > dist (MkPonto 3 4) (MkPonto 2 2)

data Forma = Circulo Ponto Double
           | Retangulo Ponto Double Double

quadrado :: Ponto -> Double -> Forma
quadrado p l = Retangulo p l l

-- Tipos parametrizados

data Identidade a = Id a

data Maybe' a = Nothing' | Just' a

maybeDiv :: Int -> Int -> Maybe' Int
maybeDiv _ 0 = Nothing'
maybeDiv x y = Just' (x `div` y)

maybeHead :: [a] -> Maybe' a
maybeHead [] = Nothing'
maybeHead (x:xs) = Just' x

divComErro :: Int -> Int -> Int
divComErro m n =
  case maybeDiv m n of
    Nothing' -> error $ show m ++ " dividido por " ++ show n ++ " nao existe!"
    Just' x -> x

-- > divComErro 4 2
--
-- > divComErro 4 0

-- data Either a b = Left a | Right b

eitherDiv :: Int -> Int -> Either String Int
eitherDiv _ 0 = Left "divisao por 0"
eitherDiv m n = Right (m `div` n)

-- > eitherDiv 4 2
-- 
-- > eitherDiv 4 0

-- Exercicio
--
-- Tipo Fuzzy = Verdadeiro, Falso, Pertinencia Double
-- fuzzifica = Falso se <= 0, Verdadeiro se >= 1, Pertinencia valor c.c.

data Fuzzy =  Verdadeiro | Falso | Pertinencia Double
                         deriving Show

fuzzifica :: Double -> Fuzzy
fuzzifica n
  | n <= 0    = Falso
  | n >= 1    = Verdadeiro
  | otherwise = Pertinencia n

-- > fuzzifica 0
--
-- > fuzzifica 9
--
-- > fuzzifica 0.5

-- newtype Identidade = Id Int

-- f :: Identidade -> Int -> Int
-- f (Id 10)

-- Tipos Recursivos

data Lista a = Vazia | Cons a (Lista a)

-- [1,2,3] = Cons 1 (Cons 3 (Cons 3 Vazia))
--  1 : 2 : 3 : []

data Tree a = Leaf a | Node (Tree a) a (Tree a)
                     deriving Show

data Tree' a = Leaf' a
             | Node' { _right :: Tree' a
                     , _value :: a
                     , _left  :: Tree' a
                     } deriving Show

t :: Tree Int
t = Node t1 5 t2

t1 = Node (Leaf 1) 3 (Leaf 4)
t2 = Node (Leaf 6) 7 (Leaf 9)
  {-
              5
             / \
            3   7
           / \ / \
          1  4 6  9
  -}


contem :: Eq a => Tree a -> a -> Bool
contem (Leaf y) x     = x == y
contem (Node l y r) x = x == y || l `contem` x
                               || r `contem` x

-- > t `contem` 3
--
-- > t `contem` 0

-- Arvore Binária

contem' :: Ord a => Tree a -> a -> Bool
contem' (Leaf y) x     = x == y
contem' (Node l y r) x | x == y    = True
                       | x < y     = l `contem'` x
                       | otherwise = r `contem'` x

-- Record Type

data Ponto3D = Ponto { coordX :: Double
                     , coordY :: Double
                     , coordZ :: Double
                     } deriving Show

-- > :t coordY (Função)

-- coordX (Ponto x _ _) = x
-- coordY (Ponto _ y _) = y
-- coordZ (Ponto _ _ z) = z

-- Algebra dos Tipos

-- data Zero    --Void
-- data Um = Um -- ()

-- absurdo :: Void -> a
-- absurdo x = undefined

inteiro :: () -> Int
inteiro () = 10 --qualquer retorno

-- val_inteiro :: Int
-- val_inteiro = 42

-- > inteiro ()

fim :: a -> ()
fim x = () -- nao acontece nada

-- data Bool = False | True
type Bool' = Either () ()
data Pair a b = Pair a b

bool2bool' False = Left ()
bool2bool' True  = Right ()

bool'2bool (Left()) = False
bool'2bool (Right()) = True

-- (bool2bool' . bool'2bool) (Left())
-- bool2bool' False
-- Left ()

data Dir' = Either (Either () ()) (Either () ())

type CodProd = Either Char Char
-- Char = 256
-- Cod_Prod = 256 + 256 = 512

-- type ZeroVezesUm = Pair Void () = 0
-- 0 * 1 = 0

-- type UmUm = Pair () ()
-- 1 * 1 = 1 --> Pair () ()

-- type Pontos3D' = Pair (Double) (Pair Double Double)
-- type Pontos3D'' = Pair (Pair Double Double) (Double)

type ValidaCod = Pair Char Bool
-- Char = 256
-- Bool = 2 
-- ValidaCod = 512

-- Propriedade: 2 * x = x + x
prod2valida (Left c) = Pair c False
prod2valida (Right c) = Pair c True

valida2prod (Pair c False) = Left c
valida2prod (Pair c True) = Right c

-- valida2prod $  prod2valida (Left 'a')

-- Propriedade: (x + y) * z = (x * z) + (y * z)

type Tipo1 x y z = Pair (Either x y) z
type Tipo2 x y z = Either (Pair x z) (Pair y z)

t1t2 (Pair (Left x) z) = Left (Pair x z)
t1t2 (Pair (Right y) z) = Right (Pair y z)

t2t1 (Left (Pair x z)) = Pair (Left x) z
t2t1 (Right (Pair y z)) = Pair (Right y) z

-- t1t2 . t2t1 = id
-- t2t1 . t1t2 = id

-- Tipo Exponencial

data Funcao a b = F(a -> b)

-- f :: Funcao a b -> [a] -> [b]
-- f (F g) xs = map g xs

-- a -> b = b ^ a possiveis valores

-- Funcao Bool a == Bool -> a -- a^2 funcoes diferentes

{-
 f :: Bool -> Dir -- 4^2 = 16 possibilidades
 f True = Norte
 f False = Norte

 f True = Sul
 f False = Sul

 f True = Leste
 f False = Oeste
 ...
-}

-- f :: Bool -> Bool == 2^2 = 4 possiveis funcoes

idB :: Bool -> Bool
idB False = False
idB True = True

allFalse :: Bool -> Bool 
allFalse _ = False

allTrue :: Bool -> Bool
allTrue _ = True

nao :: Bool -> Bool
nao False = True
nao True = False

id :: a -> a -- (Polimorfismo Parametrico)
id x = x

main :: IO ()
main = do
  putStrLn "hello world"
