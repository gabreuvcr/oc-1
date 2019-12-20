#Exercicio 3

#O programa consiste em analisar cada valor do vetor a
#tentando achar se possui o valor correspondente no vetor b, que
#em caso positivo, coloca-se o valor 1 no vetor c na mesma posicao (j)
#que foi encontrado o valor em b. O programa funciona mesmo que o vetor
#possua valores repetidos, pois apos achar um valor correspondente, ainda
#possui uma condição onde o valor em c deve ser 0 para se preencher 1.

main:
    .data
    tamanho: .word 4            #tamanho do vetor
    a: .word 1, 4, 3, 2         #vetor a
    b: .word 2, 1, 4, 3         #vetor b
    c: .word 0, 0, 0, 0         #vetor c para verificacao

    .text
    lw a0, tamanho              #carrega o tamanho dos vetores
    la a1, a                    #carrega o vetor a
    la a2, b                    #carrega o vetor b
    la a3, c                    #carrega o vetor c
    
    jal ra, permutation
    jal ra, end
    
permutation:
    addi sp, sp, -32
    sw t0, 28(sp)
    sw t1, 24(sp)
    sw t3, 20(sp)
    sw t4, 16(sp)
    sw t5, 12(sp)
    sw s1, 8(sp)
    sw s2, 4(sp)
    sw s3, 0(sp)
    
    li t0, 0                    #t0 = 0 (i)
    
    loop1:
        bge t0, a0, verificacao    #se t0 >= a0, vai para verificacao
        
        #vetor a
        slli s1, t0, 2          #s1 = t0 * 4
        add s1, s1, a1          #s1 = offset + endereco do save
        
        addi t0, t0, 1          #t0++ (vale para o proximo loop)
        li t1, 0                #t1 = 0 (j)
        beq zero, zero, loop2   #vai para o loop2

    loop2:
    	bge t1, a0, loop1       #se t1 >= a0, volta pro loop1
        
        #vetor b
        slli s2, t1, 2          #s2 = t1 * 4
        add s2, s2, a2          #s2 = offset + endereco do save

        #vetor c
        slli s3, t1, 2          #s3 = t1 * 4
        add s3, s3, a3          #s3 = offset + endereco do save
        
        addi t1, t1, 1          #t1++ (vale para o proximo loop)
        lw t3, 0(s1)            #t3 = a[t0]
        lw t4, 0(s2)            #t4 = b[t1]
        
        bne t3, t4, loop2       #se a[t0] != b[t1], volta pro loop2
        
        lw t5, 0(s3)            #t5 = c[t1]
        bne t5, zero, loop2     #se c[t1] != 0, volta pro loop2
        
        li t5, 1                #t5 = 1
        sw t5, 0(s3)            #c[t1] = 1
        beq zero, zero, loop1   #volta pro loop1
      	
    verificacao:
        #verifica se o c possui algum 0 (nao permutacao)
        li t0, 0                #t0 = 0
        li t1, 1                #t1 = 1
        loop3:
            bge t0, a0, retorno     #se t0 >= a0, sai do loop3
            slli s3, t0, 2          #s3 = t0 * 4
            add s3, s3, a3          #s3 = offset + endereco do save
            addi t0, t0, 1          #t0++ (vale para o proximo loop)
            lw t5, 0(s3)            #t5 = c[t0]
            beq t5, t1, loop3       #se c[t0] == 1, volta pro loop3
            li t1, 0                #t1 = 0 (achou um 0)
            beq zero, zero, retorno     #sai do loop3
            
    retorno:
        mv a0, t1               # a0 = t1
        #retorna em a0: 
        #0 se nao e permutacao e 1 se e permutacao
        lw s3, 0(sp)
        lw s2, 4(sp)
        lw s1, 8(sp)
        lw t5, 12(sp)
        lw t4, 16(sp)
        lw t3, 20(sp)
        lw t1, 24(sp)
       	lw t0, 28(sp)  
        jalr zero, 0(ra)
      	
end:
