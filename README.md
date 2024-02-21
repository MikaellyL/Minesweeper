# Minesweeper

Equipe: Mikaelly Almeida e Francisco Guilherme 


## Visão geral do Minesweeper
O Minesweeper é um jogo de computador clássico onde o jogador precisa desvendar um campo minado, evitando bombas escondidas em uma grade de células. O objetivo é revelar todas as células sem bombas sem acionar nenhuma delas. Os números nas células indicam quantas bombas estão adjacentes, e os jogadores usam essas pistas para evitar áreas perigosas. O jogo combina lógica e estratégia, sendo popular por sua simplicidade e desafio.

## Explicando cada arquivo de código
### InitializeBoard
O código em Assembly MIPS fornecido tem como objetivo principal inicializar uma matriz bidimensional chamada board. A matriz é percorrida usando dois loops aninhados, um para iterar sobre as linhas e outro para as colunas. Durante esse processo de iteração, cada elemento da matriz recebe o valor -2, indicando a ausência de bomba nessa posição.

A função initializeBoard recebe um ponteiro para a matriz board como argumento, que é armazenado no registrador $s0. Os loops externo e interno usam os registradores $s1 e $s2 como índices para as linhas e colunas, respectivamente.

Dentro do loop interno, são realizados os seguintes passos:

São calculados os deslocamentos necessários para acessar a posição [i][j] na matriz usando operações de deslocamento à esquerda (sll).
Os deslocamentos são somados para obter o endereço efetivo na matriz, e o valor imediato -2 é armazenado nessa posição.
Os loops externo e interno são controlados por instruções de comparação (bge) e desvio condicional (j). Após a conclusão de cada loop, os índices são incrementados, e o processo é repetido até que toda a matriz seja inicializada.

Ao final da função, o contexto do registrador é restaurado e a função retorna.
Por fim, o contexto dos registradores é restaurado, e a função retorna.

Essa implementação é comum em jogos como o Minesweeper, onde a matriz `board` representa o tabuleiro inicial sem bombas. O valor `-2` é utilizado como marcador para indicar a ausência de bombas nas células do tabuleiro.
