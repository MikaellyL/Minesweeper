.include "macros.asm"
	
.globl checkVictory

checkVictory:
# your code here                                                                                                                               
  save_context
  move $s0, $a0                 # $s0 = board
  li $s1, 0                     # contador
  li $t9, SIZE			# $t9 = Size 
  
  li $s2, 0                     # i = 0 no início do loop
loop_i:
    bge $s2, $t9, end_loop_i    # i >= SIZE, sai do loop ext

  li $s3, 0                             # j = 0 no início do loop             
loop_j:
    bge $s3, $t9, end_loop_j            # j >= SIZE, sai do loop int
    
    sll $t2, $s2, 5			# i * 32
    sll $t3, $s3, 2			# j * 4
    add $t1, $t2, $t3			# $t1 = (i * 32) + (j * 4)
    add $t0, $t1, $s0			# guarda em $t0 a soma do endereço se board + $t1
    lw $t4, 0($t0)                      # Carrega o valor de boar[i][j] em $t4
    
    bltz $t4, skip                      # Se board[i][j] é negativo, pula count++
    addi $s1, $s1, 1 			# count++

skip:
    addi $s3, $s3, 1		# j++
    j loop_j         
                                    
end_loop_j:
    addi $s2, $s2, 1            # i++
    j loop_i 

end_loop_i:
    mul $t1, $t9, $t9                # guarda o valor de SIZE X SIZE em $t1              
    li $t3, BOMB_COUNT               # endereço da constante BOMB_COUNT em $t3
    sub $t1, $t1, $t3                # atualiza o valor de $t1 para $t1 - $t3     
    bge $s1, $t1, win                # Se o contador for 54, pula para o win
    restore_context
    li $v0, 0                        # Caso contrário, retorna 0
    jr $ra			     # retorna para o endereço de chamada da função

win:
    restore_context
    li $v0, 1                        # Retorna 1
    jr $ra			     # retorna para o endereço de chamada da função
