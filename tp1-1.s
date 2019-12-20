#Exercicio 1

main: 
    .data
    input: .word 19     #valor do input

    .text
    lw a0, input        #carrega o input do usuario
    jal ra, evenOrOdd
    jal ra, end

evenOrOdd:
    addi sp, sp, -4
    sw t0, 0(sp)
    li t0, 2            #coloca o valor 2 em t0
    rem a0, a0, t0      #tira o mod 2 do valor enviado
    lw t0, 0(sp)
    addi sp, sp, 4
    jalr zero, 0(ra)
    
end:
