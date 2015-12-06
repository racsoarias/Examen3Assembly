extern _printf
extern _scanf

    size equ 4
section .data
    msgA: db "Gano el jugador 1",10,0
    msgB: db "Gano la computadora",10,0
    msgD: db "El juego finaliza sin ganadores :(",10,0
    message1: db "Jugador 1, ingrese un valor:",10,0
    message2: db "La computadora ha jugado en %d",10,0
    msgSalida: db "Fin del juego",10,0
    cambioLinea: db 10,0
    formato: db "%d",0
    fmt: db "%c ",0
    count: dw 0

section .bss 
    gato: resd 9
    cat: resd 9
    posicion: resd 1
    tipoJuego: resd 1
    stop: resd 1
    
section .text
     global _singlePlayer

 _singlePlayer:

 ; Implementación
    call matriz  
    call imprimir
    
 interaccion:    
    
    call estadoJuego 
   
    call jugar1
    call estadoJuego
    cmp dword [stop], 1
    je end
    
    call jugar2
    call estadoJuego 
    cmp dword [stop], 1
    je end
    
    xor eax, eax
    mov ecx, 9
    mov edx, 0
    revisarCampos:
        push ecx            
        add eax, dword [cat + edx]
        add edx, 4 
        pop ecx    
    loop revisarCampos
    cmp eax, 9
    je match    
    jmp interaccion
    
 match:
    push msgD
    call _printf
    add esp,4
    jmp end

end: 
ret

;------------------------------------------------ 
 matriz:
    mov eax, 0
    mov ebx, 49
    mov ecx, 9
    llenar:
        push ecx 
        mov dword [gato + eax], ebx
        add eax, 4
        inc ebx
        pop ecx
    loop llenar
 ret
 
;------------------------------------------------ 
 imprimir:
    mov dword [count],0
    mov ecx, 3
        externo1:
        push ecx
        mov ebx, ecx
        mov ecx, 3
            interno1:
            push ecx
            mov ebx, [count]
            push dword [gato + ebx]
            push fmt
            call _printf
            add esp, 8
            add dword[count], size
            pop ecx
            loop interno1
        push cambioLinea
        call _printf
        add esp, 4
        mov ecx, ebx
        pop ecx   
        loop externo1
 ret

;------------------------------------------------ 
 jugar1:
    push message1
    call _printf
    add esp, 4
      
    push posicion
    push formato
    call _scanf
    add esp, 8
    
    mov eax, -4
    mov ecx, [posicion]
    llenarPosP1:
        push ecx 
        add eax, 4
        pop ecx
    loop llenarPosP1
    mov dword [gato + eax], 79
    mov dword [cat + eax], 1
    call imprimir
    
 ret
    
;------------------------------------------------     
 jugar2: 
 
    mov dword [posicion], 3
    cmp dword [gato + 8], 51
    je juega       
    mov dword [posicion], 7
    cmp dword [gato + 24], 55
    je juega       
    mov dword [posicion], 9
    cmp dword [gato + 32], 57
    je juega       
    mov dword [posicion], 5
    cmp dword [gato + 16], 53
    je juega       
    mov dword [posicion], 6
    cmp dword [gato + 20], 54
    je juega      
    mov dword [posicion], 8
    cmp dword [gato + 28], 56
    je juega       
    mov dword [posicion], 1
    cmp dword [gato + 0], 49
    je juega
    mov dword [posicion], 4
    cmp dword [gato + 12],52
    je juega
    mov dword [posicion], 2
    cmp dword [gato + 4], 50
    je juega
    ret
    
 juega:    
    push dword [posicion]
    push message2
    call _printf
    add esp, 8
        
    mov eax, -4
    mov ebx, 49
    mov ecx, [posicion]
    llenarPosP2:
        push ecx 
        add eax, 4
        pop ecx
    loop llenarPosP2
    mov dword [gato + eax], 88
    mov dword [cat + eax], 1
    call imprimir

 ret

;------------------------------------------------     
estadoJuego:
 casoHorizontal:
    mov ecx, 3
    mov ebx, 0
    cicloExt: 
        push ecx
        xor eax,eax
        mov ecx, 3 ; reinicia en 3 para el loop interno
        cicloInt:
            push ecx
            add eax, dword [gato + ebx]
            add ebx, 4
            pop ecx
         loop cicloInt
         pop ecx  

         cmp eax, 237
         je player1
         cmp eax, 264
         je player2
    loop cicloExt


 casoDiagonales:
    xor ebx, ebx
    mov ecx, 3
    cicloDiagonal:
        push ecx
        dec ecx 
        mov eax, 16
        mul ecx
        add ebx, dword [gato + eax]
        pop ecx
    loop cicloDiagonal
            
    mov eax, ebx; para que siempre se revise el registro eax
    cmp eax, 237
    je player1
    cmp eax, 264
    je player2
            
    xor eax, eax
    add eax, dword [gato + 8]
    add eax, dword [gato + 16]
    add eax, dword [gato + 24]
            
    cmp eax, 237
    je player1
    cmp eax, 264
    je player2
    
    
 casoVertical:
    xor eax, eax
    add eax, dword [gato + 0]
    add eax, dword [gato + 12]
    add eax, dword [gato + 24]
    cmp eax, 237
    je player1
    cmp eax, 264
    je player2
                
    xor eax, eax
    add eax, dword [gato + 4]
    add eax, dword [gato + 16]
    add eax, dword [gato + 28]
    cmp eax, 237
    je player1
    cmp eax, 264
    je player2
        
    xor eax, eax
    add eax, dword [gato + 8]
    add eax, dword [gato + 20]
    add eax, dword [gato + 32]
    cmp eax, 237
    je player1
    cmp eax, 264
    je player2
        
    jmp fin
    
 player1:
    push msgA
    call _printf
    add esp,4
    mov eax, 1
    mov [stop], eax
    jmp fin
        
 player2:
    push msgB
    call _printf
    add esp,4
    mov eax, 1
    mov [stop], eax
    jmp fin


 fin:

ret