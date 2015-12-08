%macro printing 1
    push %1
    call _printf
    add esp, 4
%endmacro 

%macro leer 2
    push %1
    push %2
    call _scanf
    add esp, 8
%endmacro 

%macro intArt 2
    mov dword [posicion], %1
    cmp dword [gato + %2],48+%1
    je juega 
%endmacro

%macro casos 1
    add eax, dword [gato + %1]
%endmacro

%macro casoVert 3
    xor eax, eax
    casos %1
    casos %2
    casos %3
    cmp eax, 237
    je player1
    cmp eax, 264
    je player2
%endmacro

extern _printf
extern _scanf

    size equ 4
section .data
    message1: db "Jugador 1, ingrese un valor:",10,0
    message2: db "Jugador 2, ingrese un valor:",10,0
    message3: db "La computadora ha jugado en %d",10,0
    cambioLinea: db 10,0
    formato: db "%d",0
    fmt: db " %c ",0
    count: dw 0
    
section .bss 
    gato: resd 9
    cat: resd 9
    posicion: resd 1
    tipoJuego: resd 1
    stop: resb 1
    ganador: resd 1
    qPlayers: resd 1
    
section .text
     global _player

 _player:
    push ebp
    mov ebp, esp
 
    mov eax, [ebp + 8]
    mov dword [qPlayers], eax
    call matriz  
    call imprimir
    
 interaccion:    
    call estadoJuego 
    call jugar1
    call estadoJuego
    cmp byte [stop], 1
    je end    
    call hayJuego
    call jugar2
    call estadoJuego 
    cmp byte [stop], 1
    je end    
    call hayJuego      
    jmp interaccion
    
 match:
    mov dword [ganador], 3
    jmp end

 end: 
    mov eax, dword [ganador]
    mov esp, ebp
    pop ebp 
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
        printing cambioLinea
        printing cambioLinea
        mov ecx, ebx
        pop ecx   
        loop externo1
 ret
 
;------------------------------------------------ 
 hayJuego:
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
 ret

;------------------------------------------------ 
 jugar1:
    printing message1      
    leer posicion, formato 
    
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
 
    cmp dword [qPlayers], 2
    jne jugar2IA
 
    printing message2
    leer posicion, formato

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
  
 jugar2IA:
    intArt 5,16   
    intArt 7,24   
    intArt 9,32  
    intArt 3,8   
    intArt 8,28  
    intArt 1,0   
    intArt 6,20   
    intArt 4,12  
    intArt 2,4   
    ret
    
 juega:    
    push dword [posicion]
    push message3
    call _printf
    add esp, 8
        
    mov eax, -4
    mov ebx, 49
    mov ecx, [posicion]
    llenarPosP3:
        push ecx 
        add eax, 4
        pop ecx
    loop llenarPosP3
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
    casos 8
    casos 16
    casos 24
            
    cmp eax, 237
    je player1
    cmp eax, 264
    je player2
    
 casoVertical:
    casoVert 0, 12, 24
    casoVert 4, 16, 28
    casoVert 8, 20, 32
    jmp fin
    
 player1:
    mov dword [ganador], 1
    mov byte [stop], 1    
    jmp fin
 player2:
    mov dword [ganador], 2
    mov byte [stop], 1
    jmp fin
 fin:
ret