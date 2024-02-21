.include "macros.asm"

.globl play

play:
    save_context
    move $s0, $a0                          # board $s0
    move $s1, $a1                          # linha  para $s1
    move $s2, $a2                          # Coluna para $s2
    
    sll $t1, $s1, 5 
    sll $t2, $s2, 2
    add $t1, $t1, $t2
    add $s3, $s0, $t1			   # $s3 guarda endereço board[i][j]
    
    # Verifica se revelou uma bomba
    li $t3, -1 
    lw $t4, 0($s3)      
    beq $t4, $t3, bomb_hit                 #se t0 = t3(-1), pula pra bomb_hit

    # Verifica se a célula está revelada
    li $t3, -2         
    beq $t4, $t3, revealed_cell
    restore_context
    li $v0, 1          #Jogo continua, valor de retorno é definido como 1
    jr $ra             # Retorna ao chamador

bomb_hit:
    restore_context
    li $v0, 0          # Define o valor de retorno como 0 (fim do jogo)
    jr $ra             # Retorna ao chamador

revealed_cell:
    jal countAdjacentBombs  # Chama a função countAdjacentBombs
    sw $v0, 0($s3)     # Armazena o resultado em board[L][C]

    # Verifica se x é zero
    beqz $v0, reveal_adjacent_cells
    j return_1
    
reveal_adjacent_cells:
    move $a0, $s0               # $a0 = board          
    move $a1, $s1               # $a1 = row            
    move $a2, $s2               # $a2 = column          
    jal revealNeighboringCells  # Chama função revealNeighboringCells
    
return_1:
    restore_context
    li $v0, 1			# $v0 recebe valor 1 (jogo continua)
    jr $ra			# retorna ao endereço de chamada da função

