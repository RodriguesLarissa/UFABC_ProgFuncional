module Test where
import Cesar
import Test.QuickCheck

lowerChar :: Gen Char
lowerChar = elements caracteresValidos

lowerString :: Gen String
lowerString = listOf lowerChar

-- aplicando shift duas vezes, uma com o valor negativo, o caracter deve ser o mesmo
prop_neg_shift :: Int -> Property
prop_neg_shift s = 
    forAll lowerChar prop
        where prop c = shift (-s) (shift s c) == c

-- o tamanho da mensagem codificada deve ser o mesmo da original
prop_enc_length :: Int -> Property
prop_enc_length s =
    forAll lowerString prop
        where prop xs = length (encode s xs) == length xs

-- o decode do encode deve ser a string original
prop_enc_dec :: Int -> Property
prop_enc_dec s = 
    forAll lowerString prop
        where prop xs = enconde (-s) (encode s xs) == xs