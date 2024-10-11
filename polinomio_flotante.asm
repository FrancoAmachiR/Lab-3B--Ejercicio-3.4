.data
    mensajeGrado:       .asciiz "Introduzca el grado del polinomio: "
    mensajeCoeficiente: .asciiz "Introduzca el coeficiente (float): "
    mensajeValorX:      .asciiz "Introduzca el valor de x: "
    mensajeResultado:   .asciiz "El resultado del polinomio es: "
    nuevaLinea:         .asciiz "\n"

.text
    
    li $v0, 4
    la $a0, mensajeGrado
    syscall
    li $v0, 5            
    syscall
    move $t2, $v0        
    addi $t4, $t2, 1    
    li $v0, 9            
    mul $a0, $t4, 4     
    syscall
    move $s4, $v0       
    move $s5, $s4        
    li $t3, 0          
     
pedirCoeficiente:
    li $v0, 4
    la $a0, mensajeCoeficiente
    syscall
    li $v0, 6           
    syscall
    s.s $f0, 0($s4)    
    addiu $s4, $s4, 4    
    addi $t3, $t3, 1
    blt $t3, $t4, pedirCoeficiente 
    li $v0, 4
    la $a0, mensajeValorX
    syscall
    li $v0, 6          
    syscall
    mov.s $f3, $f0       
    move $s4, $s5        
    move $t3, $t2      
    l.s $f5, 0($s4)     
    addiu $s4, $s4, 4   
    addi $t3, $t3, -1    

evaluarPolinomio:
    bltz $t3, mostrarResultado  
    mul.s $f5, $f5, $f3         
    l.s $f7, 0($s4)          
    addiu $s4, $s4, 4           
    add.s $f5, $f5, $f7       
    addi $t3, $t3, -1           
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
