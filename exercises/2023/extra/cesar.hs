let2int :: Char -> Int
let2int n = ord n - ord 'a'

int2let :: Int -> Char
int2let n = chr (ord 'a' + n)

table :: [Float]
table = [8.1, 1.5, 2.8, 4.2, 12.7, 2.2, 2.0, 6.1, 7.0,
        0.2, 0.8, 4.0, 2.4, 6.7, 7.5, 1.9, 0.1, 6.0,
        6.3, 9.0, 2.8, 1.0, 2.4, 0.2, 2.0, 0.1]

-- retorna a n-ésima letra seguinte
-- evite ultrapassar o limite com `mod` 26
shift :: Int -> Char -> Char
shift _ ' ' = ' '
shift s c = int2let((let2int c + s') `mod` 26)
    where s' = s `mod` 26

-- aplica a função shift em cada letra da string
enconde :: Int -> String -> String
enconde s xs = [shift s x | x <- xs]

crack :: String -> String
crack xs = encode (-factor) xs
    where 
        factor = head (positions (minimum chitab) chitab)
        chitab = [chisqr (rotate n table') table | n <- [0..25]]
        table' = freqs xs

-- quantidade de letras minúsculas em uma String
lowers :: String -> Int
lowers xs = length [x | x <- xs, isLower x]

-- conta a ocorrencia de um caracter em uma String
count :: Char -> String -> Int
count y xs = length [x | x <- xs, x == y]

-- dado um n e m, calcule 100*n/m
percent :: Int -> Int -> Float
percent n m = 100 * fromIntegral n / fromIntegral m

-- calcule a porcentagem de cada letra minuscula do alfabeto em uma String
-- a porcentagem é a contagem de ocorrência pelo total de letras minúsuculas
freqs :: String -> [Float]
freqs xs = [percent (count c xs) m | c <- ['a'..'z']]
    where m = lowers xs

-- calcule a medida de Chi-quadrado de duas tabelas de freq
-- Soma (Observado - Esperado)^2 / Esperado
chisqr :: [Float] -> [Float] -> Float
chisqr os es = sum [(o-e)**2/e | (o, e) <- zip os es]

-- rotaciona uma tabela em n posicoes
rotate :: Int -> [a] -> [a]
rotate s xs = take n (drop s (xs ++ xs))
    where   s' = s `mod` len xs
            n = length xs

-- retorna a lista de posições que contem um elemento x
positions :: Eq a => a -> [a] -> [Int]
positions y xs = [i | (i, x) <- zip [0..] xs, x == y]