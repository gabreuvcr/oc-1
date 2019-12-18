#Gabriel Victor Carvalho Rocha
#Exercicio 2

main:
    .data
    input: .word 5          #valor do input

    .text
    lw a0, input            #carrega o input do usuario
    jal ra, fat
    jal ra, end
    
fat:
    addi sp, sp, -8
    sw t0, 4(sp)
    sw t1, 0(sp)
    mv t0, a0               #copia o valor de a0 em t0
    li t1, 2                #coloca em t1 o valor 2
    blt zero, a0, loop      #se a0 > 0, vai para o loop
    li a0, 1                #senao, recebe o valor 1 por padrao
    loop:
        bge t1, t0, exitLoop    #se o t0 <= 2, sai do loop
    	addi t0, t0, -1         #decrementa 1 de t0
        mul a0, a0, t0          #multiplica em a0
        beq zero, zero, loop    #retorna para o loop
    exitLoop:
    	lw t1, 0(sp)
        lw t0, 4(sp)
        addi sp, sp, 8
    	jalr zero, 0(ra)

end:
