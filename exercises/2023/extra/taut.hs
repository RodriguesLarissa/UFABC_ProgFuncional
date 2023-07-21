module Main (main) where

data Prop a = T
            | F
            | Var a
            -- | (Prop a) :&& (Prop a)
            | And (Prop a) (Prop a) 
            | Or (Prop a) (Prop a)
            | Imp (Prop a) (Prop a)
            | Not (Prop a)

-- infixr 3 :&&

type ValFn a = ([a], a -> Bool)
type Substs a = [(a, Bool)]

valFn2Substs :: ValFn a -> Substs a
valFn2Substs (ds, v) = [(d, v d)| d <- ds]

empty :: ValFn a 
empty = ([], \_ -> error "Valoracao vazia")

extend :: Eq a => (a, Bool) -> ValFn a -> ValFn a
extend (d, b) (ds, v) = (d:ds, w)
    where w x = if x == d then b else v x

substs2ValFn :: Eq a => Substs a -> ValFn a
substs2ValFn = foldr extend empty

-- substs2ValFn [] = empty
-- substs2ValFn (p : tb) = extend p substs2ValFn tb

clean :: Eq a => [a] -> [a] -> [a]
clean xs ys = xs ++ [y | y <- ys, not (elem y xs)]

vars :: Eq a => Prop a -> [a]
vars T = []
vars F = []
vars (Var x) = [x]
vars (And p q) = clean (vars p) (vars q)
vars (Or p q) = clean (vars p) (vars q)
vars (Imp p q) = clean (vars p) (vars q)
vars (Not p) = vars p

eval :: Eq a => ValFn a -> Prop a > Bool
eval _ T = True
eval _ F = False
eval (_, v) (Var x) = v x
eval phi (And p q) = eval phi p && eval phi q
eval phi (Or p q) = eval phi p || eval phi q
eval phi (Imp p q) = eval phi (Or (Not p) q)
eval phi (Not p) = not (eval phi p)

allValFns :: Eq a => [a] -> [ValFn a]
allValFns [] = [empty]
allValFns (x:xs) = [extend (x, b) v| v <- vs, b < [True, False]]
    where vs = allValFns xs

taut :: Eq a => Prop a -> Bool
taut p = and [eval phi p | phi <- allValFns (vars p)]

sat :: Eq a => Prop a -> Bool
sat p = or [eval phi p | phi <- allValFns (vars p)]

satVals :: Eq a => Prop a -> [Substs a]
satVals p = [valFn2Substs phi | phi <- allValFns (vars p), eval phi p]

main :: IO ()
main = do
    let p = And (Or (Var 'A') (Var 'B')) (Or (Not (Var 'A')) (Var 'B'))
    print (taut p)
    print(satVals p)
    putStrLn "Hello World"