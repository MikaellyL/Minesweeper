# Minesweeper

Equipe: Mikaelly Almeida e Francisco Guilherme 


## Visão geral do Minesweeper
O Minesweeper é um jogo de computador clássico onde o jogador precisa desvendar um campo minado, evitando bombas escondidas em uma grade de células. O objetivo é revelar todas as células sem bombas sem acionar nenhuma delas. Os números nas células indicam quantas bombas estão adjacentes, e os jogadores usam essas pistas para evitar áreas perigosas. O jogo combina lógica e estratégia, sendo popular por sua simplicidade e desafio.

## Explicando cada arquivo de código
### InitializeBoard
Essa função objetiva inicializar uma matriz bidimensional chamada board. A matriz é percorrida usando dois loops aninhados, um para iterar sobre as linhas e outro para as colunas. Durante esse processo de iteração, cada elemento da matriz recebe o valor -2, indicando a ausência de bomba nessa posição.

A função initializeBoard recebe um ponteiro para a matriz board como argumento, que é armazenado no registrador `$s0`. Os loops externo e interno usam os registradores `$s1` e `$s2` como índices para as linhas e colunas, respectivamente.

Dentro do loop interno, são realizados os seguintes passos:

São calculados os deslocamentos necessários para acessar a posição [i][j] na matriz usando operações de deslocamento à esquerda `(sll).`
Os deslocamentos são somados para obter o endereço efetivo na matriz, e o valor imediato -2 é armazenado nessa posição.
Os loops externo e interno são controlados por instruções de comparação (bge) e desvio condicional (j). Após a conclusão de cada loop, os índices são incrementados, e o processo é repetido até que toda a matriz seja inicializada.

Ao final da função, o contexto do registrador é restaurado e a função retorna.
Por fim, o contexto dos registradores é restaurado, e a função retorna.

Essa implementação é comum em jogos como o Minesweeper, onde a matriz `board` representa o tabuleiro inicial sem bombas. O valor `-2` é utilizado como marcador para indicar a ausência de bombas nas células do tabuleiro.


### PlantBombs
A função tem como objetivo distribuir bombas aleatoriamente em um tabuleiro representado por uma matriz chamada board. A função utiliza um loop externo para plantar um número específico de bombas no tabuleiro.

Para realizar a distribuição de bombas, a função configura um gerador de números aleatórios com base no tempo atual. Em seguida, ela entra em um loop externo para plantar cada bomba. Dentro desse loop, um loop interno é utilizado para gerar coordenadas aleatórias (row e column) dentro das dimensões do tabuleiro. A função verifica se a posição escolhida já contém uma bomba; se sim, ela repete o processo até encontrar uma posição sem bomba.

Quando uma posição adequada é encontrada, a função atribui o valor -1 a essa posição na matriz board, indicando a presença de uma bomba naquela célula. Esse processo é repetido até que todas as bombas desejadas tenham sido plantadas.

Ao final, o contexto dos registradores é restaurado, e a função retorna. Esse trecho de código é essencial para a inicialização do tabuleiro do jogo, garantindo uma distribuição aleatória e diversificada das bombas no campo minado.

### Play
A função `play` é usada para processar a jogada do usuário em um jogo representado por uma matriz chamada `board`.

A função começa salvando o contexto dos registradores e movendo os argumentos (o tabuleiro `board`, a linha e a coluna) para registradores específicos. Em seguida, calcula o endereço da célula na matriz correspondente à linha e coluna fornecidas.

O código verifica se a célula contém uma bomba. Se sim, a função pula para uma etiqueta chamada `bomb_hit`, indicando o fim do jogo. Caso contrário, verifica se a célula já foi revelada. Se sim, restaura o contexto e retorna 1, indicando que o jogo continua.

Se a célula não contém bomba e não foi revelada, a função chama uma função externa chamada `countAdjacentBombs` para contar o número de bombas nas células adjacentes. O resultado é armazenado na célula atual.

Em seguida, verifica se o número de bombas adjacentes é zero. Se for, a função chama outra função externa chamada `revealNeighboringCells` para revelar automaticamente as células adjacentes não reveladas.

Ao final, restaura o contexto dos registradores e retorna 1, indicando que o jogo continua.

Existe uma etiqueta chamada `bomb_hit` que é alcançada se uma bomba for revelada. Nesse caso, a função restaura o contexto e retorna 0, indicando o fim do jogo.

Essa função `play` é crucial para o fluxo do jogo, determinando as consequências da jogada do usuário, como revelar células, verificar bombas e decidir se o jogo continua ou termina.


### PrintBoard 
Essa função tem como objetivo imprimir o tabuleiro de um jogo na saída padrão.

A função inicia salvando o contexto dos registradores e movendo os argumentos da função (o ponteiro para o tabuleiro `board` e o tamanho do tabuleiro `SIZE`) para registradores específicos.

Em seguida, utiliza chamadas de sistema (`syscall`) para imprimir linhas em branco, criando espaçamento visual entre as linhas do tabuleiro. Também imprime linhas horizontais para criar a aparência de uma grade.

A função entra em um loop externo para iterar sobre as linhas do tabuleiro. Dentro desse loop, há um loop interno para iterar sobre as colunas da linha. Para cada célula, a função determina o que imprimir com base nas condições do jogo (número, bomba ou célula vazia) e utiliza chamadas de sistema para realizar a impressão.

Ao final de cada linha, adiciona novas linhas para melhor formatação. Os índices são incrementados, e os loops continuam até que todas as linhas e colunas tenham sido percorridas.

A função restaura o contexto dos registradores e retorna à função chamadora.

Essencialmente, a função `printBoard` é responsável por representar visualmente o estado atual do tabuleiro do jogo na saída padrão.

### RevealNeighboringCells
Essa função é usada para revelar as células vizinhas de uma posição específica (`row`, `column`) em um tabuleiro de jogo representado pela matriz `board`.

A função começa salvando o contexto dos registradores e movendo os argumentos da função (`board`, `row`, e `column`) para registradores específicos.

Em seguida, utiliza dois loops aninhados para iterar sobre as células vizinhas, ajustando os índices `i` e `j`. Verifica se `i` e `j` estão dentro dos limites do tabuleiro (`SIZE`).

Dentro do loop, a função verifica se a célula na posição (`i`, `j`) ainda não foi revelada (valor -2). Se não foi revelada, chama a função `countAdjacentBombs` para contar o número de bombas nas células vizinhas. O resultado é armazenado em `$s5`.

Se o número de bombas adjacentes for zero, a função chama recursivamente a si mesma (`revealNeighboringCells`) para revelar as células vizinhas da célula atual.

Ao final dos loops, os índices `i` e `j` são incrementados, e os loops continuam até que todas as células vizinhas tenham sido processadas.

O contexto dos registradores é restaurado, e a função retorna ao endereço de chamada.

Em resumo, a função `revealNeighboringCells` desempenha a função de revelar as células vizinhas de uma posição específica no tabuleiro do jogo, seguindo as regras do jogo e garantindo a eficiente revelação das células adjacentes.


### CheckVictory
Essa função é responsável por verificar se o jogo foi vencido, ou seja, se todas as células que não contêm bombas foram reveladas. 

A função inicia salvando o contexto dos registradores e movendo o argumento da função (`board`) para um registrador específico. Em seguida, ela inicializa contadores e utiliza dois loops aninhados para iterar sobre todas as células do tabuleiro.

Dentro do loop interno, o código calcula o endereço da célula atual no tabuleiro, verifica o valor da célula e incrementa um contador caso a célula não contenha uma bomba. Após percorrer todas as células, a função compara o contador com um valor calculado com base no tamanho do tabuleiro e na quantidade de bombas. Se o contador for igual ou maior, significa que todas as células que não contêm bombas foram reveladas, e o jogo é considerado vencido.

A função retorna 1 em caso de vitória e 0 em caso de derrota. O contexto dos registradores é restaurado antes do retorno. Essencialmente, `checkVictory` desempenha um papel fundamental na verificação do estado de vitória no jogo.


### CountAdjacentsBombs
Essa função é responsável por contar o número de bombas nas células vizinhas de uma posição específica (`row`, `column`) em um tabuleiro de jogo representado pela matriz `board`.

A função começa salvando o contexto dos registradores e movendo os argumentos da função para registradores específicos. Em seguida, utiliza dois loops aninhados para iterar sobre as células vizinhas, calculando o endereço da célula atual.

Durante a iteração, a função verifica se os índices `i` e `j` estão dentro dos limites do tabuleiro (`SIZE`). Para cada célula vizinha, verifica o valor da célula no tabuleiro. Se a célula contiver uma bomba (valor -1), incrementa um contador (`$s3`). Ao final, o valor do contador é movido para o registrador de retorno (`$v0`).

Após essa contagem eficiente das bombas nas células vizinhas, a função restaura o contexto dos registradores e retorna ao endereço de chamada da função.

em resumo, `countAdjacentBombs` proporciona a contagem correta das bombas nas células ao redor de uma posição específica no tabuleiro.
