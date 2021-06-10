module Exercicios where

-- 1. Quantos segundos existem em 42 minutos e 42 segundos?
ex01 = (42*60)+42

-- 2. Sabendo que uma milha equivale a 1.61 km, quantas milhas temos em 10 km?
ex02 = (10/1.61)

-- 3. Se você correr uma corrida de 10km em 42 minutos e 42 segundos, quantos segundos você levou para correr cada milha?
ex03 = ex01/ex02

-- 4. Na situação do exercício anterior, qual a sua velocidade média em milhas por hora?
ex04 = ex02/(ex01/3600)

-- 5. Suponha que o preço de venda de um livro é R$24.95, mas livrarias tem 40% de desconto. O frete custa R$3.00 para a primeira cópia e 75 centavos para cada cópia adicional. Qual é o custo total, para uma livraria, para comprar 60 cópias?

preço = 24.95*0.6
ex05 = 3 + (0.75*59) + (preço*60)  
