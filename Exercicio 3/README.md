# Semana 04

## Conteúdo

| Tópico                    | Material de Estudo                                                       | Playlist                                                                 |
| ------------------------- | ------------------------------------------------------------------------ | ------------------------------------------------------------------------ |
Tipos de Dados Algébricos|https://haskell.pesquisa.ufabc.edu.br/posts/haskell/07.adt.html|https://www.youtube.com/playlist?list=PLYItvall0TqJWdfiLuMsIm_4ag3fJjHTo

## Resumo (2 pontos)

**⚠️ Não se esqueça de escrever o seu resumo no arquivo `resumo.txt`. Os resumos deverão possuir no máximo 300 palavras e serão publicados no site da disciplina junto ao tópico de estudo dessa semana.**

# Exercícios (8 pontos)

> A princípio o seu código não irá compilar! Será necessário preencher pelo menos o básico do exercício 5, mesmo que com `undefined`s por enquanto. Aproveitamos a oportunidade para lembrar a vocês que códigos que não compilarem receberão a nota 0.
>
> A estrutura básica dos ADTs está disponível no código, sempre com um construtor `DummyXXX`, que deve ser substituído pelos seus próprios. Não remova as derivações de `Show` e `Read`, se existirem. Você pode adicionar novas derivações se quiser.

1. ★☆☆ Desenvolva uma função `ehTriangulo a b c` que retorna `True` caso os comprimentos a, b, c possam formar um triângulo, ou `False` caso contrário. Essa função deve aceitar **pelo menos Ints, Floats e Doubles**.

2. ★☆☆ Crie um ADT `TipoTriangulo` que tem 4 possíveis valores: `Escaleno`, `Isosceles`, `Equilatero` ou `Nenhum`, com uma instância padrão para `Show`. Desenvolva uma função `determinaTriangulo a b c` que determina o tipo do triângulo formado pelos comprimentos a, b, c. Essa função deve funcionar para **pelo menos Ints, Floats e Doubles**.

3. ★☆☆ Crie um ADT `Horario` composto do construtor `HoraMinuto` que recebe dois valores do tipo `Int`, um para hora e outro para minuto. Não é necessário fazer validação alguma sobre os `Int`s. Implemente a função `somarHorario :: Horario -> Horario -> Horario`, que soma os dois horário fazendo o controle de `minutos > 60 => +1 hora`.

4. ★☆☆ Crie um ADT `Periodo` que tem os possível valores: `Madrugada`, `Manha`, `Tarde` e `Noite`. Crie uma função `horarioToPeriodo :: Horario -> Periodo` que determina o período em que se encontra cada horário, segundo o esquema abaixo:
    - 00h00-05h59 -> Madrugada
    - 06h00-11h59 -> Manhã
    - 12h00-17h59 -> Tarde
    - 18h00-23h59 -> Noite

5. ★★☆ Considere a classe de tipos `Booleanable`, composta pela função `toBool`. Essa classe de tipos tem a função de definir uma conversão de um tipo qualquer para bool. Implemente instâncias dessa classe para os tipos `Bool`, `Int`, `Float`, `String` e `[Int]`, conforme as regras do PHP (https://www.php.net/manual/pt_BR/language.types.boolean.php, seção "Convertendo para booleano").

6. ★★☆ Crie um ADT `Medida` que tem os possíveis valores: `Polegada`, `Palmo`, `Pe`, `Jarda` e `Milha`, derivando a instância padrão de Show. Considere a função de `converter` que recebe uma `Medida` de **origem**, uma `Medida` de **destino**, e um **valor** de qualquer tipo fracional. A função deve interpretar o valor como sendo da unidade de origem e retornar esse valor convertido para a unidade de destino. Veja a tabela na [Wikipedia](https://pt.wikipedia.org/wiki/Unidade_inglesa#Unidades_de_comprimento). Exemplos:
    - `converter Milha Jarda 1 = 1760`
    - `converter Pe Polegada 1 = 12`
    - `converter Palmo Polegada 1 = 9` _(Não está na wikipedia)_
    - `converter Polegada Pe 17.45 = 1.4541667`

7. ★★★ Considere o ADT `Nota`, cujos possíveis valores são `Do`, `Re`, `Mi`, `Fa`, `Sol`, `La`, `Si`. Considere ainda o ADT `ModoGrego`, com os valores `Jonio`, `Dorico`, `Frigio`, `Lidio`, `Mixolidio`, `Eolio` e `Locrio`. Implemente a função `gerarModo :: Int -> ModoGrego -> [Nota]` seguindo a regra a seguir.

    > Podemos gerar a escala (i.e. uma sequência de notas) de Dó em um determinado modo grego de acordo com a seguinte regra:
    > - Modo Jônio (offset de 0): `[Do, Re, Mi, Fa, Sol, La, Si, Do]`
    > - Modo Dórico (offset de 1): `[Re, Mi, Fa, Sol, La, Si, Do, Re]`
    > - Modo Frígio (offset de 2): `[Mi, Fa, Sol, La, Si, Do, Re, Mi]`
    > - ...
    > - Modo Lócrio (offset de 6): `[Si, Do, Re, Mi, Fa, Sol, La, Si]`
    >
    > Os exemplos aqui foram gerados para 8 notas, mas a sua função deve ser capaz de gerar escalas de tamanho arbitrário, configurado pelo primeiro argumento.
    
