.data
    mensajeGrado:     .asciiz "Indique el grado del polinomio: "
    mensajeCoef:      .asciiz "Introduzca el coeficiente: "
    mensajeValorX:    .asciiz "Introduzca el valor de x: "
    mensajeResultado: .asciiz "El resultado del polinomio es: "
    saltoLinea:       .asciiz "\n"

.text
    
    li $v0, 4
    la $a0, mensajeGrado
    syscall
    li $v0, 5        
    syscall
    move $t4, $v0      
    addi $t5, $t4, 1  
    li $v0, 9           
    sll $a0, $t5, 2     
    syscall
    move $s3, $v0       
    move $s4, $s3         
    li $t6, 0       
        
pedirCoeficientes:
    li $v0, 4
    la $a0, mensajeCoef
    syscall
    li $v0, 6          
    syscall
    s.s $f0, 0($s3)     
    addiu $s3, $s3, 4   
    addi $t6, $t6, 1
    blt $t6, $t5, pedirCoeficientes    
    li $v0, 4
    la $a0, mensajeValorX
    syscall
    li $v0, 6           
    syscall
    mov.s $f3, $f0      
    move $s3, $s4       
    move $t6, $t4     
    l.s $f5, 0($s3)     
    addiu $s3, $s3, 4  
    addi $t6, $t6, -1   

evaluarPolinomio:
    bltz $t6, mostrarResultado 
    mul.s $f5, $f5, $f3        
    l.s $f7, 0($s3)            
    addiu $s3, $s3, 4           
    add.s $f5, $f5, $f7         
    addi $t6, $t6, -1           
    j evaluarPolinomio           

mostrarResultado:
    li $v0, 4
    la $a0, mensajeResultado
    syscall
    li $v0, 2           
    mov.s $f12, $f5
    syscall
    li $v0, 10
    syscall
