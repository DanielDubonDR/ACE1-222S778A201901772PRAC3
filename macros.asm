printc macro txt, color
    ; carga en memoria las variables del semento de datos
    mov ax, @data
    mov ds, ax

    ; impresion por pantalla
    mov ah, 09h
    mov bl, color
    mov cx, lengthof txt - 1
    int 10h
    lea dx, txt
    int 21h
endm

printn macro n
    mov ax, 0
    mov al, n
    div baux

    mov naux[0], al
    mov naux[1], ah

    add naux[0], 48
    add naux[1], 48

    lea dx, naux
    mov ah, 09h
    int 21h
endm

print macro txt
    ; carga en memoria las variables del semento de datos
    mov ax, @data
    mov ds, ax

    ; impresion por pantalla
    mov ah, 09h
    lea dx, txt
    int 21h
endm

cls macro
    mov ax, 03h
    int 10h
endm

getch macro
    mov ah, 01h
    int 21h
endm

imprimirTB1 macro
    ; printc ln, 0d
    print line
    printc ln, 0d
    printc j, 10d
    print sep
    printRow r1tb1
    printc ln, 0d
    
    printc i, 10d
    print sep
    printRow r2tb1
    printc ln, 0d

    printc h, 10d
    print sep
    printRow r3tb1
    printc ln, 0d

    printc g, 10d
    print sep
    printRow r4tb1
    printc ln, 0d

    printc f, 10d
    print sep
    printRow r5tb1
    printc ln, 0d

    printc e, 10d
    print sep
    printRow r6tb1
    printc ln, 0d

    printc d, 10d
    print sep
    printRow r7tb1
    printc ln, 0d

    printc lc, 10d
    print sep
    printRow r8tb1
    printc ln, 0d

    printc b, 10d
    print sep
    printRow r9tb1
    printc ln, 0d

    printc a, 10d
    print sep
    printRow r10tb1
    printc ln, 0d
    print line

    printc ln, 0d
    printc inferior, 10d
endm

printRow macro row 
    local ciclo, printBarco1, printBarco2, printBarco3, printBarco4, printBarco5, printEspacio, incrementar, printAgua, printBomba
    mov cx, 10
    xor si, si
    ciclo:
        cmp row[si], 1
        jz printBarco1
        cmp row[si], 2
        jz printBarco2
        cmp row[si], 3
        jz printBarco3
        cmp row[si], 4
        jz printBarco4
        cmp row[si], 5
        jz printBarco5
        cmp row[si], 6
        jz printBomba
        cmp row[si], 7
        jz printAgua
        print espacio
        jmp incrementar

        printBarco1:
            print numero1
            jmp incrementar
        
        printBarco2:
            print numero2
            jmp incrementar
        
        printBarco3:
            print numero3
            jmp incrementar
        
        printBarco4:
            print numero4
            jmp incrementar
        
        printBarco5:
            print numero5
            jmp incrementar
        
        printBomba:
            print bomba
            jmp incrementar
        
        printAgua:
            print agua
            jmp incrementar

        incrementar:
            inc si
        
    dec cx
    jnz ciclo
endm

printBarcosDisponiblesTB1 macro
    local ciclo, printB1, printB2, printB3, printB4, printB5, incrementar
    printc ln, 0d
    mov cx, 5
    xor si, si
    ciclo:
        cmp barcosDisponiblesJ1[si], 1
        jz printB1
        cmp barcosDisponiblesJ1[si], 2
        jz printB2
        cmp barcosDisponiblesJ1[si], 3
        jz printB3
        cmp barcosDisponiblesJ1[si], 4
        jz printB4
        cmp barcosDisponiblesJ1[si], 5
        jz printB5
        jmp incrementar

        printB1:
            print b1
            jmp incrementar
        
        printB2:
            print b2
            jmp incrementar
        
        printB3:
            print b3
            jmp incrementar
        
        printB4:
            print b4
            jmp incrementar
        
        printB5:
            print b5
            jmp incrementar
        
        incrementar:
            inc si
        
    loop ciclo
endm

llenandoTB1 macro
    local salir

    cls
    printc ln, 0d
    imprimirTB1
    printc ln, 0d
    printBarcosDisponiblesTB1
    printc ln, 0d
    printc msgLlenar1, 14d
    verificarTipoBarco
    printc ln, 0d
    printc msgLlenar2, 14d
    verificarPosicionTB
    printc ln, 0d
    printc msgLlenar3, 14d
    verificarFilaTB
    printc ln, 0d
    printc msgLlenar4, 14d
    verificarColumnaTB
    verificarPosicion filaTBAux, columnaTB
    cmp posOcupada, 0
    jnz salir
    asignarBarcoTB1
        getch

    salir:
        mov posOcupada, 0
endm

verificarTipoBarco macro
    local tipoB1, tipoB2, tipoB3, tipoB4, tipoB5, error, salir

    repetir:
        cls
        printc ln, 0d
        imprimirTB1
        printc ln, 0d
        printBarcosDisponiblesTB1
        printc ln, 0d
        printc msgLlenar1, 14d
        getch
        cmp al, 49
        jz tipoB1
        cmp al, 50
        jz tipoB2
        cmp al, 51
        jz tipoB3
        cmp al, 52
        jz tipoB4
        cmp al, 53
        jz tipoB5
        jmp repetir

    tipoB1:
        mov barcosDisponiblesJ1[0], 0
        mov tipoB, 1
        jmp salir
    
    tipoB2:
        mov barcosDisponiblesJ1[1], 0
        mov tipoB, 2
        jmp salir
    
    tipoB3:
        mov barcosDisponiblesJ1[2], 0
        mov tipoB, 3
        jmp salir
    
    tipoB4:
        mov barcosDisponiblesJ1[3], 0
        mov tipoB, 4
        jmp salir
    
    tipoB5:
        mov barcosDisponiblesJ1[4], 0
        mov tipoB, 5
        jmp salir
    
    salir:
endm

verificarPosicionTB macro
    local repetir, vertical, horizontal, salir

    repetir:
        cls
        printc ln, 0d
        imprimirTB1
        printc ln, 0d
        printBarcosDisponiblesTB1
        printc ln, 0d
        printc msgLlenar1, 14d
        printn tipoB
        printc ln, 0d
        printc msgLlenar2, 14d
        getch
        cmp al, 118
        jz vertical
        cmp al, 104
        jz horizontal
        jmp repetir

    vertical:
        mov posicionTB, 118
        jmp salir
    
    horizontal:
        mov posicionTB, 104
        jmp salir
    
    salir:
endm

verificarFilaTB macro
    local repetir, FA, FB, FC, FD, FE, FF, FG, FH, FI, FJ, salir

    repetir:
        cls
        printc ln, 0d
        imprimirTB1
        printc ln, 0d
        printBarcosDisponiblesTB1
        printc ln, 0d
        printc msgLlenar1, 14d
        printn tipoB
        printc ln, 0d
        printc msgLlenar2, 14d
        print posicionTB
        printc ln, 0d
        printc msgLlenar3, 14d
        getch
        cmp al, 65
        jz FA
        cmp al, 66
        jz FB
        cmp al, 67
        jz FC
        cmp al, 68
        jz FD
        cmp al, 69
        jz FE
        cmp al, 70
        jz FF
        cmp al, 71
        jz FG
        cmp al, 72
        jz FH
        cmp al, 73
        jz FI
        cmp al, 74
        jz FJ
        jmp repetir

    FA:
        mov filaTB, 65
        mov filaTBAux, 9
        jmp salir
    
    FB:
        mov filaTB, 66
        mov filaTBAux, 8
        jmp salir
    
    FC:
        mov filaTB, 67
        mov filaTBAux, 7
        jmp salir
    
    FD:
        mov filaTB, 68
        mov filaTBAux, 6
        jmp salir

    FE:
        mov filaTB, 69
        mov filaTBAux, 5
        jmp salir
    
    FF:
        mov filaTB, 70
        mov filaTBAux, 4
        jmp salir
    
    FG:
        mov filaTB, 71
        mov filaTBAux, 3
        jmp salir
    
    FH:
        mov filaTB, 72
        mov filaTBAux, 2
        jmp salir
    
    FI:
        mov filaTB, 73
        mov filaTBAux, 1
        jmp salir
    
    FJ:
        mov filaTB, 74
        mov filaTBAux, 0
        jmp salir
    
    salir:
endm

verificarColumnaTB macro
    local repetir, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, salir

    repetir:
        cls
        printc ln, 0d
        imprimirTB1
        printc ln, 0d
        printBarcosDisponiblesTB1
        printc ln, 0d
        printc msgLlenar1, 14d
        printn tipoB
        printc ln, 0d
        printc msgLlenar2, 14d
        print posicionTB
        printc ln, 0d
        printc msgLlenar3, 14d
        print filaTB
        printc ln, 0d
        printc msgLlenar4, 14d
        getn2
        cmp n2[1], 48
        jz C10
        cmp n2[0], 49
        jz C1
        cmp n2[0], 50
        jz C2
        cmp n2[0], 51
        jz C3
        cmp n2[0], 52
        jz C4
        cmp n2[0], 53
        jz C5
        cmp n2[0], 54
        jz C6
        cmp n2[0], 55
        jz C7
        cmp n2[0], 56
        jz C8
        cmp n2[0], 57
        jz C9
        jmp repetir
    
    C1:
        mov columnaTB, 0
        jmp salir
    
    C2:
        mov columnaTB, 1
        jmp salir
    
    C3:
        mov columnaTB, 2
        jmp salir
    
    C4:
        mov columnaTB, 3
        jmp salir
    
    C5:
        mov columnaTB, 4
        jmp salir
    
    C6:
        mov columnaTB, 5
        jmp salir
    
    C7:
        mov columnaTB, 6
        jmp salir
    
    C8:
        mov columnaTB, 7
        jmp salir
    
    C9:
        mov columnaTB, 8
        jmp salir
    
    C10:
        mov columnaTB, 9
        jmp salir
    
    salir:
endm

getn2 macro
    local ciclo, salir, incrementar
    mov n2[0], 32
    mov n2[1], 32
    mov cx, 3
    xor si, si

    ciclo:
        getch
        cmp al, 0dh
        jz salir
        jnz incrementar

        incrementar:
            mov n2[si], al
            inc si
    
    loop ciclo

    salir:

endm

asignarBarcoTB1 macro
    local asignarBarco1TB1, asignarBarco2TB1, asignarBarco3TB1, asignarBarco4TB1, asignarBarco5TB1, asignarBarco1TB1V, asignarBarco1TB1H, salir, asignarBarco2TB1V, asignarBarco2TB1H, asignarBarco3TB1V, asignarBarco3TB1H, asignarBarco4TB1V, asignarBarco4TB1H, asignarBarco5TB1V, asignarBarco5TB1H

    cmp tipoB, 1
    jz asignarBarco1TB1
    cmp tipoB, 2
    jz asignarBarco2TB1
    cmp tipoB, 3
    jz asignarBarco3TB1
    cmp tipoB, 4
    jz asignarBarco4TB1
    cmp tipoB, 5
    jz asignarBarco5TB1

    asignarBarco1TB1:
        cmp posicionTB, 118
        jz asignarBarco1TB1V
        cmp posicionTB, 104
        jz asignarBarco1TB1H
    
        asignarBarco1TB1H:
            asignarBarcoTB1Horizontal 2, filaTBAux, columnaTB, 1
            jmp salir
        
        asignarBarco1TB1V:
            asignarBarcoTB1Vertical 2, filaTBAux, columnaTB, 1
            jmp salir
    
    asignarBarco2TB1:
        cmp posicionTB, 118
        jz asignarBarco2TB1V
        cmp posicionTB, 104
        jz asignarBarco2TB1H
    
        asignarBarco2TB1H:
            asignarBarcoTB1Horizontal 3, filaTBAux, columnaTB, 2
            jmp salir
        
        asignarBarco2TB1V:
            asignarBarcoTB1Vertical 3, filaTBAux, columnaTB, 2
            jmp salir
    
    asignarBarco3TB1:
        cmp posicionTB, 118
        jz asignarBarco3TB1V
        cmp posicionTB, 104
        jz asignarBarco3TB1H
    
        asignarBarco3TB1H:
            asignarBarcoTB1Horizontal 3, filaTBAux, columnaTB, 3
            jmp salir
        
        asignarBarco3TB1V:
            asignarBarcoTB1Vertical 3, filaTBAux, columnaTB, 3
            jmp salir
    
    asignarBarco4TB1:
        cmp posicionTB, 118
        jz asignarBarco4TB1V
        cmp posicionTB, 104
        jz asignarBarco4TB1H
    
        asignarBarco4TB1H:
            asignarBarcoTB1Horizontal 4, filaTBAux, columnaTB, 4
            jmp salir
        
        asignarBarco4TB1V:
            asignarBarcoTB1Vertical 4, filaTBAux, columnaTB, 4
            jmp salir
    
    asignarBarco5TB1:
        cmp posicionTB, 118
        jz asignarBarco5TB1V
        cmp posicionTB, 104
        jz asignarBarco5TB1H
    
        asignarBarco5TB1H:
            asignarBarcoTB1Horizontal 5, filaTBAux, columnaTB, 5
            jmp salir
        
        asignarBarco5TB1V:
            asignarBarcoTB1Vertical 5, filaTBAux, columnaTB, 5
            jmp salir

    salir:

endm

asignarBarcoTB1Horizontal macro pos, fila, columna, tipo
    local F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, salir

    mov cx, pos
    mov si, columna
    cmp fila, 0
    jz F1
    cmp fila, 1
    jz F2
    cmp fila, 2
    jz F3
    cmp fila, 3
    jz F4
    cmp fila, 4
    jz F5
    cmp fila, 5
    jz F6
    cmp fila, 6
    jz F7
    cmp fila, 7
    jz F8
    cmp fila, 8
    jz F9
    cmp fila, 9
    jz F10

    F1:
        mov r1tb1[si], tipo
        inc si
        loop F1
        jmp salir
    
    F2:
        mov r2tb1[si], tipo
        inc si
        loop F2
        jmp salir
    
    F3:
        mov r3tb1[si], tipo
        inc si
        loop F3
        jmp salir
    
    F4:
        mov r4tb1[si], tipo
        inc si
        loop F4
        jmp salir
    
    F5:
        mov r5tb1[si], tipo
        inc si
        loop F5
        jmp salir
    
    F6:
        mov r6tb1[si], tipo
        inc si
        loop F6
        jmp salir
    
    F7:
        mov r7tb1[si], tipo
        inc si
        loop F7
        jmp salir
    
    F8:
        mov r8tb1[si], tipo
        inc si
        loop F8
        jmp salir
    
    F9:
        mov r9tb1[si], tipo
        inc si
        loop F9
        jmp salir
    
    F10:
        mov r10tb1[si], tipo
        inc si
        loop F10
        jmp salir
    
    salir:
endm

asignarBarcoTB1Vertical macro pos, fila, columna, tipo
    local ciclo, salir

    mov cx, pos
    mov si, fila
    ciclo:
        intepreteFilasTB1 si, columna, tipo
        inc si
    loop ciclo
    salir:
endm

intepreteFilasTB1 macro fila, columna, tipo
    local F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, salir

    mov bx, columna
    cmp fila, 0
    jz F1
    cmp fila, 1
    jz F2
    cmp fila, 2
    jz F3
    cmp fila, 3
    jz F4
    cmp fila, 4
    jz F5
    cmp fila, 5
    jz F6
    cmp fila, 6
    jz F7
    cmp fila, 7
    jz F8
    cmp fila, 8
    jz F9
    cmp fila, 9
    jz F10

    F1:
        mov r1tb1[bx], tipo
        jmp salir
    
    F2:
        mov r2tb1[bx], tipo
        jmp salir
    
    F3:
        mov r3tb1[bx], tipo
        jmp salir
    
    F4:
        mov r4tb1[bx], tipo
        jmp salir
    
    F5:
        mov r5tb1[bx], tipo
        jmp salir
    
    F6:
        mov r6tb1[bx], tipo
        jmp salir
    
    F7:
        mov r7tb1[bx], tipo
        jmp salir
    
    F8:
        mov r8tb1[bx], tipo
        jmp salir
    
    F9:
        mov r9tb1[bx], tipo
        jmp salir
    
    F10:
        mov r10tb1[bx], tipo
        jmp salir
    
    salir:
endm

verificarPosicion macro fila, columna
    local F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, salir, errorPos

    mov bx, columnaTB
    cmp filaTBAux, 0
    jz F1
    cmp filaTBAux, 1
    jz F2
    cmp filaTBAux, 2
    jz F3
    cmp filaTBAux, 3
    jz F4
    cmp filaTBAux, 4
    jz F5
    cmp filaTBAux, 5
    jz F6
    cmp filaTBAux, 6
    jz F7
    cmp filaTBAux, 7
    jz F8
    cmp filaTBAux, 8
    jz F9
    cmp filaTBAux, 9
    jz F10

    F1:
        cmp r1tb1[bx], 0
        jz salir
        jmp errorPos
    
    F2:
        mov r2tb1[bx], 0
        jz salir
        jmp errorPos
    
    F3:
        mov r3tb1[bx], 0
        jz salir
        jmp errorPos
    
    F4:
        mov r4tb1[bx], 0
        jz salir
        jmp errorPos
    
    F5:
        mov r5tb1[bx], 0
        jz salir
        jmp errorPos
    
    F6:
        mov r6tb1[bx], 0
        jz salir
        jmp errorPos
    
    F7:
        mov r7tb1[bx], 0
        jz salir
        jmp errorPos
    
    F8:
        mov r8tb1[bx], 0
        jz salir
        jmp errorPos
    
    F9:
        mov r9tb1[bx], 0
        jz salir
        jmp errorPos
    
    F10:
        mov r10tb1[bx], 0
        jz salir
        jmp errorPos
    
    errorPos:
        dec di
        printc ln, 0d
        print msgPos
        mov posOcupada, 1
        regresarBarco
        getch
        jmp salir
    
    salir:
endm

regresarBarco macro
    local tipoB1, tipoB2, tipoB3, tipoB4, tipoB5, error, salir, repetir

    repetir:
        cmp tipoB, 1
        jz tipoB1
        cmp tipoB, 2
        jz tipoB2
        cmp tipoB, 3
        jz tipoB3
        cmp tipoB, 4
        jz tipoB4
        cmp tipoB, 5
        jz tipoB5
        jmp repetir

    tipoB1:
        mov barcosDisponiblesJ1[0], 1
        mov tipoB, 1
        jmp salir
    
    tipoB2:
        mov barcosDisponiblesJ1[1], 2
        mov tipoB, 2
        jmp salir
    
    tipoB3:
        mov barcosDisponiblesJ1[2], 3
        mov tipoB, 3
        jmp salir
    
    tipoB4:
        mov barcosDisponiblesJ1[3], 4
        mov tipoB, 4
        jmp salir
    
    tipoB5:
        mov barcosDisponiblesJ1[4], 5
        mov tipoB, 5
        jmp salir
    
    salir:
endm

; ------------------------------------------------------------------------------------------------------------------------------

llenandoTB2 macro
    local salir

    cls
    printc ln, 0d
    imprimirTB2
    printc ln, 0d
    printBarcosDisponiblesTB2
    printc ln, 0d
    printc msgLlenar1, 14d
    verificarTipoBarcoJ2
    printc ln, 0d
    printc msgLlenar2, 14d
    verificarPosicionTBJ2 
    printc ln, 0d
    printc msgLlenar3, 14d
    verificarFilaTBJ2
    printc ln, 0d
    printc msgLlenar4, 14d
    verificarColumnaTBJ2
    verificarPosicionJ2 filaTBAux, columnaTB 
    cmp posOcupada, 0
    jnz salir
    asignarBarcoTB2 ;aqui
        getch

    salir:
        mov posOcupada, 0
endm

imprimirTB2 macro
    ; printc ln, 0d
    print line
    printc ln, 0d
    printc j, 10d
    print sep
    printRow r1tb2
    printc ln, 0d
    
    printc i, 10d
    print sep
    printRow r2tb2
    printc ln, 0d

    printc h, 10d
    print sep
    printRow r3tb2
    printc ln, 0d

    printc g, 10d
    print sep
    printRow r4tb2
    printc ln, 0d

    printc f, 10d
    print sep
    printRow r5tb2
    printc ln, 0d

    printc e, 10d
    print sep
    printRow r6tb2
    printc ln, 0d

    printc d, 10d
    print sep
    printRow r7tb2
    printc ln, 0d

    printc lc, 10d
    print sep
    printRow r8tb2
    printc ln, 0d

    printc b, 10d
    print sep
    printRow r9tb2
    printc ln, 0d

    printc a, 10d
    print sep
    printRow r10tb2
    printc ln, 0d
    print line

    printc ln, 0d
    printc inferior, 10d
endm

printBarcosDisponiblesTB2 macro
    local ciclo, printB1, printB2, printB3, printB4, printB5, incrementar
    printc ln, 0d
    mov cx, 5
    xor si, si
    ciclo:
        cmp barcosDisponiblesJ2[si], 1
        jz printB1
        cmp barcosDisponiblesJ2[si], 2
        jz printB2
        cmp barcosDisponiblesJ2[si], 3
        jz printB3
        cmp barcosDisponiblesJ2[si], 4
        jz printB4
        cmp barcosDisponiblesJ2[si], 5
        jz printB5
        jmp incrementar

        printB1:
            print b1
            jmp incrementar
        
        printB2:
            print b2
            jmp incrementar
        
        printB3:
            print b3
            jmp incrementar
        
        printB4:
            print b4
            jmp incrementar
        
        printB5:
            print b5
            jmp incrementar
        
        incrementar:
            inc si
        
    loop ciclo
endm

verificarTipoBarcoJ2 macro
    local tipoB1, tipoB2, tipoB3, tipoB4, tipoB5, error, salir, repetir

    repetir:
        cls
        printc ln, 0d
        imprimirTB2
        printc ln, 0d
        printBarcosDisponiblesTB2
        printc ln, 0d
        printc msgLlenar1, 14d
        getch
        cmp al, 49
        jz tipoB1
        cmp al, 50
        jz tipoB2
        cmp al, 51
        jz tipoB3
        cmp al, 52
        jz tipoB4
        cmp al, 53
        jz tipoB5
        jmp repetir

    tipoB1:
        mov barcosDisponiblesJ2[0], 0
        mov tipoB, 1
        jmp salir
    
    tipoB2:
        mov barcosDisponiblesJ2[1], 0
        mov tipoB, 2
        jmp salir
    
    tipoB3:
        mov barcosDisponiblesJ2[2], 0
        mov tipoB, 3
        jmp salir
    
    tipoB4:
        mov barcosDisponiblesJ2[3], 0
        mov tipoB, 4
        jmp salir
    
    tipoB5:
        mov barcosDisponiblesJ2[4], 0
        mov tipoB, 5
        jmp salir
    
    salir:
endm

verificarPosicionTBJ2 macro
    local repetir, vertical, horizontal, salir

    repetir:
        cls
        printc ln, 0d
        imprimirTB2
        printc ln, 0d
        printBarcosDisponiblesTB2
        printc ln, 0d
        printc msgLlenar1, 14d
        printn tipoB
        printc ln, 0d
        printc msgLlenar2, 14d
        getch
        cmp al, 118
        jz vertical
        cmp al, 104
        jz horizontal
        jmp repetir

    vertical:
        mov posicionTB, 118
        jmp salir
    
    horizontal:
        mov posicionTB, 104
        jmp salir
    
    salir:
endm

verificarFilaTBJ2 macro
    local repetir, FA, FB, FC, FD, FE, FF, FG, FH, FI, FJ, salir

    repetir:
        cls
        printc ln, 0d
        imprimirTB2
        printc ln, 0d
        printBarcosDisponiblesTB2
        printc ln, 0d
        printc msgLlenar1, 14d
        printn tipoB
        printc ln, 0d
        printc msgLlenar2, 14d
        print posicionTB
        printc ln, 0d
        printc msgLlenar3, 14d
        getch
        cmp al, 65
        jz FA
        cmp al, 66
        jz FB
        cmp al, 67
        jz FC
        cmp al, 68
        jz FD
        cmp al, 69
        jz FE
        cmp al, 70
        jz FF
        cmp al, 71
        jz FG
        cmp al, 72
        jz FH
        cmp al, 73
        jz FI
        cmp al, 74
        jz FJ
        jmp repetir

    FA:
        mov filaTB, 65
        mov filaTBAux, 9
        jmp salir
    
    FB:
        mov filaTB, 66
        mov filaTBAux, 8
        jmp salir
    
    FC:
        mov filaTB, 67
        mov filaTBAux, 7
        jmp salir
    
    FD:
        mov filaTB, 68
        mov filaTBAux, 6
        jmp salir

    FE:
        mov filaTB, 69
        mov filaTBAux, 5
        jmp salir
    
    FF:
        mov filaTB, 70
        mov filaTBAux, 4
        jmp salir
    
    FG:
        mov filaTB, 71
        mov filaTBAux, 3
        jmp salir
    
    FH:
        mov filaTB, 72
        mov filaTBAux, 2
        jmp salir
    
    FI:
        mov filaTB, 73
        mov filaTBAux, 1
        jmp salir
    
    FJ:
        mov filaTB, 74
        mov filaTBAux, 0
        jmp salir
    
    salir:
endm

verificarColumnaTBJ2 macro
    local repetir, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, salir

    repetir:
        cls
        printc ln, 0d
        imprimirTB2
        printc ln, 0d
        printBarcosDisponiblesTB2
        printc ln, 0d
        printc msgLlenar1, 14d
        printn tipoB
        printc ln, 0d
        printc msgLlenar2, 14d
        print posicionTB
        printc ln, 0d
        printc msgLlenar3, 14d
        print filaTB
        printc ln, 0d
        printc msgLlenar4, 14d
        getn2
        cmp n2[1], 48
        jz C10
        cmp n2[0], 49
        jz C1
        cmp n2[0], 50
        jz C2
        cmp n2[0], 51
        jz C3
        cmp n2[0], 52
        jz C4
        cmp n2[0], 53
        jz C5
        cmp n2[0], 54
        jz C6
        cmp n2[0], 55
        jz C7
        cmp n2[0], 56
        jz C8
        cmp n2[0], 57
        jz C9
        jmp repetir
    
    C1:
        mov columnaTB, 0
        jmp salir
    
    C2:
        mov columnaTB, 1
        jmp salir
    
    C3:
        mov columnaTB, 2
        jmp salir
    
    C4:
        mov columnaTB, 3
        jmp salir
    
    C5:
        mov columnaTB, 4
        jmp salir
    
    C6:
        mov columnaTB, 5
        jmp salir
    
    C7:
        mov columnaTB, 6
        jmp salir
    
    C8:
        mov columnaTB, 7
        jmp salir
    
    C9:
        mov columnaTB, 8
        jmp salir
    
    C10:
        mov columnaTB, 9
        jmp salir
    
    salir:
endm

verificarPosicionJ2 macro fila, columna
    local F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, salir, errorPos

    mov bx, columnaTB
    cmp filaTBAux, 0
    jz F1
    cmp filaTBAux, 1
    jz F2
    cmp filaTBAux, 2
    jz F3
    cmp filaTBAux, 3
    jz F4
    cmp filaTBAux, 4
    jz F5
    cmp filaTBAux, 5
    jz F6
    cmp filaTBAux, 6
    jz F7
    cmp filaTBAux, 7
    jz F8
    cmp filaTBAux, 8
    jz F9
    cmp filaTBAux, 9
    jz F10

    F1:
        cmp r1tb2[bx], 0
        jz salir
        jmp errorPos
    
    F2:
        mov r2tb2[bx], 0
        jz salir
        jmp errorPos
    
    F3:
        mov r3tb2[bx], 0
        jz salir
        jmp errorPos
    
    F4:
        mov r4tb2[bx], 0
        jz salir
        jmp errorPos
    
    F5:
        mov r5tb2[bx], 0
        jz salir
        jmp errorPos
    
    F6:
        mov r6tb2[bx], 0
        jz salir
        jmp errorPos
    
    F7:
        mov r7tb2[bx], 0
        jz salir
        jmp errorPos
    
    F8:
        mov r8tb2[bx], 0
        jz salir
        jmp errorPos
    
    F9:
        mov r9tb2[bx], 0
        jz salir
        jmp errorPos
    
    F10:
        mov r10tb2[bx], 0
        jz salir
        jmp errorPos
    
    errorPos:
        dec di
        printc ln, 0d
        print msgPos
        mov posOcupada, 1
        regresarBarcoJ2
        getch
        jmp salir
    
    salir:
endm

regresarBarcoJ2 macro
    local tipoB1, tipoB2, tipoB3, tipoB4, tipoB5, error, salir, repetir

    repetir:
        cmp tipoB, 1
        jz tipoB1
        cmp tipoB, 2
        jz tipoB2
        cmp tipoB, 3
        jz tipoB3
        cmp tipoB, 4
        jz tipoB4
        cmp tipoB, 5
        jz tipoB5
        jmp repetir

    tipoB1:
        mov barcosDisponiblesJ2[0], 1
        mov tipoB, 1
        jmp salir
    
    tipoB2:
        mov barcosDisponiblesJ2[1], 2
        mov tipoB, 2
        jmp salir
    
    tipoB3:
        mov barcosDisponiblesJ2[2], 3
        mov tipoB, 3
        jmp salir
    
    tipoB4:
        mov barcosDisponiblesJ2[3], 4
        mov tipoB, 4
        jmp salir
    
    tipoB5:
        mov barcosDisponiblesJ2[4], 5
        mov tipoB, 5
        jmp salir
    
    salir:
endm

asignarBarcoTB2 macro
    local asignarBarco1TB1, asignarBarco2TB1, asignarBarco3TB1, asignarBarco4TB1, asignarBarco5TB1, asignarBarco1TB1V, asignarBarco1TB1H, salir, asignarBarco2TB1V, asignarBarco2TB1H, asignarBarco3TB1V, asignarBarco3TB1H, asignarBarco4TB1V, asignarBarco4TB1H, asignarBarco5TB1V, asignarBarco5TB1H

    cmp tipoB, 1
    jz asignarBarco1TB1
    cmp tipoB, 2
    jz asignarBarco2TB1
    cmp tipoB, 3
    jz asignarBarco3TB1
    cmp tipoB, 4
    jz asignarBarco4TB1
    cmp tipoB, 5
    jz asignarBarco5TB1

    asignarBarco1TB1:
        cmp posicionTB, 118
        jz asignarBarco1TB1V
        cmp posicionTB, 104
        jz asignarBarco1TB1H
    
        asignarBarco1TB1H:
            asignarBarcoTB2Horizontal 2, filaTBAux, columnaTB, 1
            jmp salir
        
        asignarBarco1TB1V:
            asignarBarcoTB2Vertical 2, filaTBAux, columnaTB, 1
            jmp salir
    
    asignarBarco2TB1:
        cmp posicionTB, 118
        jz asignarBarco2TB1V
        cmp posicionTB, 104
        jz asignarBarco2TB1H
    
        asignarBarco2TB1H:
            asignarBarcoTB2Horizontal 3, filaTBAux, columnaTB, 2
            jmp salir
        
        asignarBarco2TB1V:
            asignarBarcoTB2Vertical 3, filaTBAux, columnaTB, 2
            jmp salir
    
    asignarBarco3TB1:
        cmp posicionTB, 118
        jz asignarBarco3TB1V
        cmp posicionTB, 104
        jz asignarBarco3TB1H
    
        asignarBarco3TB1H:
            asignarBarcoTB2Horizontal 3, filaTBAux, columnaTB, 3
            jmp salir
        
        asignarBarco3TB1V:
            asignarBarcoTB2Vertical 3, filaTBAux, columnaTB, 3
            jmp salir
    
    asignarBarco4TB1:
        cmp posicionTB, 118
        jz asignarBarco4TB1V
        cmp posicionTB, 104
        jz asignarBarco4TB1H
    
        asignarBarco4TB1H:
            asignarBarcoTB2Horizontal 4, filaTBAux, columnaTB, 4
            jmp salir
        
        asignarBarco4TB1V:
            asignarBarcoTB2Vertical 4, filaTBAux, columnaTB, 4
            jmp salir
    
    asignarBarco5TB1:
        cmp posicionTB, 118
        jz asignarBarco5TB1V
        cmp posicionTB, 104
        jz asignarBarco5TB1H
    
        asignarBarco5TB1H:
            asignarBarcoTB2Horizontal 5, filaTBAux, columnaTB, 5
            jmp salir
        
        asignarBarco5TB1V:
            asignarBarcoTB2Vertical 5, filaTBAux, columnaTB, 5
            jmp salir

    salir:

endm

asignarBarcoTB2Horizontal macro pos, fila, columna, tipo
    local F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, salir

    mov cx, pos
    mov si, columna
    cmp fila, 0
    jz F1
    cmp fila, 1
    jz F2
    cmp fila, 2
    jz F3
    cmp fila, 3
    jz F4
    cmp fila, 4
    jz F5
    cmp fila, 5
    jz F6
    cmp fila, 6
    jz F7
    cmp fila, 7
    jz F8
    cmp fila, 8
    jz F9
    cmp fila, 9
    jz F10

    F1:
        mov r1tb2[si], tipo
        inc si
        loop F1
        jmp salir
    
    F2:
        mov r2tb2[si], tipo
        inc si
        loop F2
        jmp salir
    
    F3:
        mov r3tb2[si], tipo
        inc si
        loop F3
        jmp salir
    
    F4:
        mov r4tb2[si], tipo
        inc si
        loop F4
        jmp salir
    
    F5:
        mov r5tb2[si], tipo
        inc si
        loop F5
        jmp salir
    
    F6:
        mov r6tb2[si], tipo
        inc si
        loop F6
        jmp salir
    
    F7:
        mov r7tb2[si], tipo
        inc si
        loop F7
        jmp salir
    
    F8:
        mov r8tb2[si], tipo
        inc si
        loop F8
        jmp salir
    
    F9:
        mov r9tb2[si], tipo
        inc si
        loop F9
        jmp salir
    
    F10:
        mov r10tb2[si], tipo
        inc si
        loop F10
        jmp salir
    
    salir:
endm

asignarBarcoTB2Vertical macro pos, fila, columna, tipo
    local ciclo, salir

    mov cx, pos
    mov si, fila
    ciclo:
        intepreteFilasTB2 si, columna, tipo
        inc si
    loop ciclo
    salir:
endm

intepreteFilasTB2 macro fila, columna, tipo
    local F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, salir

    mov bx, columna
    cmp fila, 0
    jz F1
    cmp fila, 1
    jz F2
    cmp fila, 2
    jz F3
    cmp fila, 3
    jz F4
    cmp fila, 4
    jz F5
    cmp fila, 5
    jz F6
    cmp fila, 6
    jz F7
    cmp fila, 7
    jz F8
    cmp fila, 8
    jz F9
    cmp fila, 9
    jz F10

    F1:
        mov r1tb2[bx], tipo
        jmp salir
    
    F2:
        mov r2tb2[bx], tipo
        jmp salir
    
    F3:
        mov r3tb2[bx], tipo
        jmp salir
    
    F4:
        mov r4tb2[bx], tipo
        jmp salir
    
    F5:
        mov r5tb2[bx], tipo
        jmp salir
    
    F6:
        mov r6tb2[bx], tipo
        jmp salir
    
    F7:
        mov r7tb2[bx], tipo
        jmp salir
    
    F8:
        mov r8tb2[bx], tipo
        jmp salir
    
    F9:
        mov r9tb2[bx], tipo
        jmp salir
    
    F10:
        mov r10tb2[bx], tipo
        jmp salir
    
    salir:
endm

;-----------------------------------------------------------------------------------------------------------------------------
startGG macro
    local J1, J11, salir, marcarDisparoJ1, marcarDisparoJ2

    J1:
        cls
        printc ln, 0d
        printc turnoJ1, 15d
        getch
        jmp J11
    
    J11:
        cls
        printc ln, 0d
        printTBBatalla1
        ; !Estoy trabajando en esto!
        printc ln, 0d
        printc ln, 0d
        printc ln, 0d
        verificarFilaTB3
        printc ln, 0d
        verificarColumnaTB3
        printc ln, 0d
        printc msgConfirmacion, 9d
        getch
        cmp al, 121
        jz marcarDisparoJ1
        jmp J11
    
    marcarDisparoJ1:
        cls
        dispararJ1 filaTBAux, columnaTB
        printc ln, 0d
        printc msgDisparoRealizado, 15d
        printc ln, 0d
        printTBBatalla1
        printc ln, 0d
        printc ln, 0d
        printc ln, 0d
        printc msgContinuar, 14d
        getch
        cls
        printc ln, 0d
        printc msgMio, 15d
        printc ln, 0d
        printc ln, 0d
        imprimirTB1
        printc ln, 0d
        printc ln, 0d
        printc ln, 0d
        printc msgContinuar, 14d
        getch
        cls
        verificarBarcoDerribadoJ2 filaTBAux, columnaTB
        printc ln, 0d
        printc msgBarcoDisp1, 15d
        printc ln, 0d
        printBarcosDisponiblesTBJ1
        printc ln, 0d
        printc msgDisparoBarco, 15d
        printn disBarco1
        printc ln, 0d
        printc ln, 0d
        printc msgBarcoDisp2, 15d
        printc ln, 0d
        printBarcosDisponiblesTBJ2
        printc ln, 0d
        printc msgDisparoBarco, 15d
        printn disBarco2
        getch
        cmp contJ1, 5
        jz salir
        jmp J2
    
    J2:
        cls
        printc ln, 0d
        printc turnoJ2, 15d
        getch
        jmp J22
    
    J22:
        cls
        printc ln, 0d
        printTBBatalla2
        printc ln, 0d
        printc ln, 0d
        printc ln, 0d
        verificarFilaTB4 
        printc ln, 0d
        verificarColumnaTB4 
        printc ln, 0d
        printc msgConfirmacion, 9d
        getch
        cmp al, 121
        jz marcarDisparoJ2 ; !
        jmp J22
    
    marcarDisparoJ2:
        cls
        dispararJ2 filaTBAux, columnaTB 
        printc ln, 0d
        printc msgDisparoRealizado, 15d
        printc ln, 0d
        printTBBatalla2
        printc ln, 0d
        printc ln, 0d
        printc ln, 0d
        printc msgContinuar, 14d
        getch
        jmp J1
        
    salir:
        cls
        printc ln, 0d
        printc msgG1, 15d
        getch

endm

printTBBatalla1 macro
    ; printc ln, 0d
    print line
    printc ln, 0d
    printc j, 10d
    print sep
    printRow r1tb3
    printc ln, 0d
    
    printc i, 10d
    print sep
    printRow r2tb3
    printc ln, 0d

    printc h, 10d
    print sep
    printRow r3tb3
    printc ln, 0d

    printc g, 10d
    print sep
    printRow r4tb3
    printc ln, 0d

    printc f, 10d
    print sep
    printRow r5tb3
    printc ln, 0d

    printc e, 10d
    print sep
    printRow r6tb3
    printc ln, 0d

    printc d, 10d
    print sep
    printRow r7tb3
    printc ln, 0d

    printc lc, 10d
    print sep
    printRow r8tb3
    printc ln, 0d

    printc b, 10d
    print sep
    printRow r9tb3
    printc ln, 0d

    printc a, 10d
    print sep
    printRow r10tb3
    printc ln, 0d
    print line

    printc ln, 0d
    printc inferior, 10d
endm

printTBBatalla2 macro
    ; printc ln, 0d
    print line
    printc ln, 0d
    printc j, 10d
    print sep
    printRow r1tb4
    printc ln, 0d
    
    printc i, 10d
    print sep
    printRow r2tb4
    printc ln, 0d

    printc h, 10d
    print sep
    printRow r3tb4
    printc ln, 0d

    printc g, 10d
    print sep
    printRow r4tb4
    printc ln, 0d

    printc f, 10d
    print sep
    printRow r5tb4
    printc ln, 0d

    printc e, 10d
    print sep
    printRow r6tb4
    printc ln, 0d

    printc d, 10d
    print sep
    printRow r7tb4
    printc ln, 0d

    printc lc, 10d
    print sep
    printRow r8tb4
    printc ln, 0d

    printc b, 10d
    print sep
    printRow r9tb4
    printc ln, 0d

    printc a, 10d
    print sep
    printRow r10tb4
    printc ln, 0d
    print line

    printc ln, 0d
    printc inferior, 10d
endm

verificarFilaTB3 macro
    local repetir, FA, FB, FC, FD, FE, FF, FG, FH, FI, FJ, salir

    repetir:
        cls
        printc ln, 0d
        printTBBatalla1
        printc ln, 0d
        printc ln, 0d
        printc ln, 0d
        printc msgLlenar3, 14d
        getch
        cmp al, 65
        jz FA
        cmp al, 66
        jz FB
        cmp al, 67
        jz FC
        cmp al, 68
        jz FD
        cmp al, 69
        jz FE
        cmp al, 70
        jz FF
        cmp al, 71
        jz FG
        cmp al, 72
        jz FH
        cmp al, 73
        jz FI
        cmp al, 74
        jz FJ
        jmp repetir

    FA:
        mov filaTB, 65
        mov filaTBAux, 9
        jmp salir
    
    FB:
        mov filaTB, 66
        mov filaTBAux, 8
        jmp salir
    
    FC:
        mov filaTB, 67
        mov filaTBAux, 7
        jmp salir
    
    FD:
        mov filaTB, 68
        mov filaTBAux, 6
        jmp salir

    FE:
        mov filaTB, 69
        mov filaTBAux, 5
        jmp salir
    
    FF:
        mov filaTB, 70
        mov filaTBAux, 4
        jmp salir
    
    FG:
        mov filaTB, 71
        mov filaTBAux, 3
        jmp salir
    
    FH:
        mov filaTB, 72
        mov filaTBAux, 2
        jmp salir
    
    FI:
        mov filaTB, 73
        mov filaTBAux, 1
        jmp salir
    
    FJ:
        mov filaTB, 74
        mov filaTBAux, 0
        jmp salir
    
    salir:
endm

verificarColumnaTB3 macro
    local repetir, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, salir

    repetir:
        cls
        printc ln, 0d
        printTBBatalla1
        printc ln, 0d
        printc ln, 0d
        printc ln, 0d
        printc msgLlenar3, 14d
        print filaTB
        printc ln, 0d
        printc msgLlenar4, 14d
        getn2
        cmp n2[1], 48
        jz C10
        cmp n2[0], 49
        jz C1
        cmp n2[0], 50
        jz C2
        cmp n2[0], 51
        jz C3
        cmp n2[0], 52
        jz C4
        cmp n2[0], 53
        jz C5
        cmp n2[0], 54
        jz C6
        cmp n2[0], 55
        jz C7
        cmp n2[0], 56
        jz C8
        cmp n2[0], 57
        jz C9
        jmp repetir
    
    C1:
        mov columnaTB, 0
        jmp salir
    
    C2:
        mov columnaTB, 1
        jmp salir
    
    C3:
        mov columnaTB, 2
        jmp salir
    
    C4:
        mov columnaTB, 3
        jmp salir
    
    C5:
        mov columnaTB, 4
        jmp salir
    
    C6:
        mov columnaTB, 5
        jmp salir
    
    C7:
        mov columnaTB, 6
        jmp salir
    
    C8:
        mov columnaTB, 7
        jmp salir
    
    C9:
        mov columnaTB, 8
        jmp salir
    
    C10:
        mov columnaTB, 9
        jmp salir
    
    salir:
endm

dispararJ1 macro fila, columna
    local F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, salir, MarcarAguaF1, MarcarAguaF2, MarcarAguaF3, MarcarAguaF4, MarcarAguaF5, MarcarAguaF6, MarcarAguaF7, MarcarAguaF8, MarcarAguaF9, MarcarAguaF10, MarcarBombaF1, MarcarBombaF2, MarcarBombaF3, MarcarBombaF4, MarcarBombaF5, MarcarBombaF6, MarcarBombaF7, MarcarBombaF8, MarcarBombaF9, MarcarBombaF10

    mov bx, columna
    cmp fila, 0
    jz F1
    cmp fila, 1
    jz F2
    cmp fila, 2
    jz F3
    cmp fila, 3
    jz F4
    cmp fila, 4
    jz F5
    cmp fila, 5
    jz F6
    cmp fila, 6
    jz F7
    cmp fila, 7
    jz F8
    cmp fila, 8
    jz F9
    cmp fila, 9
    jz F10

    F1:
        cmp r1tb2[bx], 0
        jz MarcarAguaF1
        jmp MarcarBombaF1
    
    F2:
        mov r2tb2[bx], 0
        jz MarcarAguaF2
        jmp MarcarBombaF2
    
    F3:
        mov r3tb2[bx], 0
        jz MarcarAguaF3
        jmp MarcarBombaF3
    
    F4:
        mov r4tb2[bx], 0
        jz MarcarAguaF4
        jmp MarcarBombaF4
    
    F5:
        mov r5tb2[bx], 0
        jz MarcarAguaF5
        jmp MarcarBombaF5
    
    F6:
        mov r6tb2[bx], 0
        jz MarcarAguaF6
        jmp MarcarBombaF6
    
    F7:
        mov r7tb2[bx], 0
        jz MarcarAguaF7
        jmp MarcarBombaF7
    
    F8:
        mov r8tb2[bx], 0
        jz MarcarAguaF8
        jmp MarcarBombaF8
    
    F9:
        mov r9tb2[bx], 0
        jz MarcarAguaF9
        jmp MarcarBombaF9
    
    F10:
        mov r10tb2[bx], 0
        jz MarcarAguaF10
        jmp MarcarBombaF10
    
    MarcarAguaF1:
        mov r1tb3[bx], 7
        jmp salir
    
    MarcarBombaF1:
        mov r1tb3[bx], 6
        incremetarJ1
        incremetarDisparioBarco1
        jmp salir
    
    MarcarAguaF2:
        mov r2tb3[bx], 7
        jmp salir
    
    MarcarBombaF2:
        mov r2tb3[bx], 6
        incremetarJ1
        incremetarDisparioBarco1
        jmp salir
    
    MarcarAguaF3:
        mov r3tb3[bx], 7
        jmp salir
    
    MarcarBombaF3:
        mov r3tb3[bx], 6
        incremetarJ1
        incremetarDisparioBarco1
        jmp salir
    
    MarcarAguaF4:
        mov r4tb3[bx], 7
        jmp salir
    
    MarcarBombaF4:
        mov r4tb3[bx], 6
        incremetarJ1
        incremetarDisparioBarco1
        jmp salir
    
    MarcarAguaF5:
        mov r5tb3[bx], 7
        jmp salir
    
    MarcarBombaF5: 
        mov r5tb3[bx], 6
        incremetarJ1
        incremetarDisparioBarco1
        jmp salir
    
    MarcarAguaF6:
        mov r6tb3[bx], 7
        jmp salir
    
    MarcarBombaF6:
        mov r6tb3[bx], 6
        incremetarJ1
        incremetarDisparioBarco1
        jmp salir
    
    MarcarAguaF7:
        mov r7tb3[bx], 7
        jmp salir
    
    MarcarBombaF7:
        mov r7tb3[bx], 6
        incremetarJ1
        incremetarDisparioBarco1
        jmp salir
    
    MarcarAguaF8:
        mov r8tb3[bx], 7
        jmp salir
    
    MarcarBombaF8:
        mov r8tb3[bx], 6
        incremetarJ1
        incremetarDisparioBarco1
        jmp salir
    
    MarcarAguaF9:
        mov r9tb3[bx], 7
        jmp salir
    
    MarcarBombaF9:
        mov r9tb3[bx], 6
        incremetarJ1
        incremetarDisparioBarco1
        jmp salir
    
    MarcarAguaF10:
        mov r10tb3[bx], 7
        jmp salir
    
    MarcarBombaF10: 
        mov r10tb3[bx], 6
        incremetarJ1
        incremetarDisparioBarco1
        jmp salir
    
    salir:
endm


printBarcosDisponiblesTBJ1 macro
    local ciclo, printB1, printB2, printB3, printB4, printB5, incrementar
    printc ln, 0d
    mov cx, 5
    xor si, si
    ciclo:
        cmp barcosDisponiblesJ11[si], 1
        jz printB1
        cmp barcosDisponiblesJ11[si], 2
        jz printB2
        cmp barcosDisponiblesJ11[si], 3
        jz printB3
        cmp barcosDisponiblesJ11[si], 4
        jz printB4
        cmp barcosDisponiblesJ11[si], 5
        jz printB5
        jmp incrementar

        printB1:
            print b1
            jmp incrementar
        
        printB2:
            print b2
            jmp incrementar
        
        printB3:
            print b3
            jmp incrementar
        
        printB4:
            print b4
            jmp incrementar
        
        printB5:
            print b5
            jmp incrementar
        
        incrementar:
            inc si
        
    loop ciclo
endm

printBarcosDisponiblesTBJ2 macro
    local ciclo, printB1, printB2, printB3, printB4, printB5, incrementar
    printc ln, 0d
    mov cx, 5
    xor si, si
    ciclo:
        cmp barcosDisponiblesJ22[si], 1
        jz printB1
        cmp barcosDisponiblesJ22[si], 2
        jz printB2
        cmp barcosDisponiblesJ22[si], 3
        jz printB3
        cmp barcosDisponiblesJ22[si], 4
        jz printB4
        cmp barcosDisponiblesJ22[si], 5
        jz printB5
        jmp incrementar

        printB1:
            print b1
            jmp incrementar
        
        printB2:
            print b2
            jmp incrementar
        
        printB3:
            print b3
            jmp incrementar
        
        printB4:
            print b4
            jmp incrementar
        
        printB5:
            print b5
            jmp incrementar
        
        incrementar:
            inc si
        
    loop ciclo
endm

verificarBarcoDerribadoJ2 macro fila, columna
    local F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, salir, Barco1, Barco2, Barco3, Barco4, Barco5

    mov bx, columna
    cmp fila, 0
    jz F1
    cmp fila, 1
    jz F2
    cmp fila, 2
    jz F3
    cmp fila, 3
    jz F4
    cmp fila, 4
    jz F5
    cmp fila, 5
    jz F6
    cmp fila, 6
    jz F7
    cmp fila, 7
    jz F8
    cmp fila, 8
    jz F9
    cmp fila, 9
    jz F10

    F1:
        cmp r1tb2[bx], 1
        jz Barco1
        cmp r1tb2[bx], 2
        jz Barco2
        cmp r1tb2[bx], 3
        jz Barco3
        cmp r1tb2[bx], 4
        jz Barco4
        cmp r1tb2[bx], 5
        jz Barco5
        jmp salir
    
    F2:
        mov r2tb2[bx], 1
        jz Barco1
        cmp r2tb2[bx], 2
        jz Barco2
        cmp r2tb2[bx], 3
        jz Barco3
        cmp r2tb2[bx], 4
        jz Barco4
        cmp r2tb2[bx], 5
        jz Barco5
        jmp salir
    
    F3:
        mov r3tb2[bx], 1
        jz Barco1
        cmp r3tb2[bx], 2
        jz Barco2
        cmp r3tb2[bx], 3
        jz Barco3
        cmp r3tb2[bx], 4
        jz Barco4
        cmp r3tb2[bx], 5
        jmp salir
    
    F4:
        mov r4tb2[bx], 1
        jz Barco1
        cmp r4tb2[bx], 2
        jz Barco2
        cmp r4tb2[bx], 3
        jz Barco3
        cmp r4tb2[bx], 4
        jz Barco4
        cmp r4tb2[bx], 5
        jz Barco5
        jmp salir
    
    F5:
        mov r5tb2[bx], 1
        jz Barco1
        cmp r5tb2[bx], 2
        jz Barco2
        cmp r5tb2[bx], 3
        jz Barco3
        cmp r5tb2[bx], 4
        jz Barco4
        cmp r5tb2[bx], 5
        jz Barco5
        jmp salir
    
    F6:
        mov r6tb2[bx], 1
        jz Barco1
        cmp r6tb2[bx], 2
        jz Barco2
        cmp r6tb2[bx], 3
        jz Barco3
        cmp r6tb2[bx], 4
        jz Barco4
        cmp r6tb2[bx], 5
        jz Barco5
        jmp salir
    
    F7:
        mov r7tb2[bx], 1
        jz Barco1
        cmp r7tb2[bx], 2
        jz Barco2
        cmp r7tb2[bx], 3
        jz Barco3
        cmp r7tb2[bx], 4
        jz Barco4
        cmp r7tb2[bx], 5
        jz Barco5
        jmp salir
    
    F8:
        mov r8tb2[bx], 1
        jz Barco1
        cmp r8tb2[bx], 2
        jz Barco2
        cmp r8tb2[bx], 3
        jz Barco3
        cmp r8tb2[bx], 4
        jz Barco4
        cmp r8tb2[bx], 5
        jz Barco5
        jmp salir
    
    F9:
        mov r9tb2[bx], 1
        jz Barco1
        cmp r9tb2[bx], 2
        jz Barco2
        cmp r9tb2[bx], 3
        jz Barco3
        cmp r9tb2[bx], 4
        jz Barco4
        cmp r9tb2[bx], 5
        jz Barco5
    
    F10:
        mov r10tb2[bx], 1
        jz Barco1
        cmp r10tb2[bx], 2
        jz Barco2
        cmp r10tb2[bx], 3
        jz Barco3
        cmp r10tb2[bx], 4
        jz Barco4
        cmp r10tb2[bx], 5
        jz Barco5
        jmp salir
    
    Barco1:
        mov barcosDisponiblesJ22[0], 0
        jmp salir

    Barco2:
        mov barcosDisponiblesJ22[1], 0
        jmp salir
    
    Barco3:
        mov barcosDisponiblesJ22[2], 0
        jmp salir
    
    Barco4:
        mov barcosDisponiblesJ22[3], 0
        jmp salir
    
    Barco5:
        mov barcosDisponiblesJ22[4], 0
        jmp salir
    
    salir:
endm


verificarFilaTB4 macro
    local repetir, FA, FB, FC, FD, FE, FF, FG, FH, FI, FJ, salir

    repetir:
        cls
        printc ln, 0d
        printTBBatalla2
        printc ln, 0d
        printc ln, 0d
        printc ln, 0d
        printc msgLlenar3, 14d
        getch
        cmp al, 65
        jz FA
        cmp al, 66
        jz FB
        cmp al, 67
        jz FC
        cmp al, 68
        jz FD
        cmp al, 69
        jz FE
        cmp al, 70
        jz FF
        cmp al, 71
        jz FG
        cmp al, 72
        jz FH
        cmp al, 73
        jz FI
        cmp al, 74
        jz FJ
        jmp repetir

    FA:
        mov filaTB, 65
        mov filaTBAux, 9
        jmp salir
    
    FB:
        mov filaTB, 66
        mov filaTBAux, 8
        jmp salir
    
    FC:
        mov filaTB, 67
        mov filaTBAux, 7
        jmp salir
    
    FD:
        mov filaTB, 68
        mov filaTBAux, 6
        jmp salir

    FE:
        mov filaTB, 69
        mov filaTBAux, 5
        jmp salir
    
    FF:
        mov filaTB, 70
        mov filaTBAux, 4
        jmp salir
    
    FG:
        mov filaTB, 71
        mov filaTBAux, 3
        jmp salir
    
    FH:
        mov filaTB, 72
        mov filaTBAux, 2
        jmp salir
    
    FI:
        mov filaTB, 73
        mov filaTBAux, 1
        jmp salir
    
    FJ:
        mov filaTB, 74
        mov filaTBAux, 0
        jmp salir
    
    salir:
endm

verificarColumnaTB4 macro
    local repetir, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, salir

    repetir:
        cls
        printc ln, 0d
        printTBBatalla2
        printc ln, 0d
        printc ln, 0d
        printc ln, 0d
        printc msgLlenar3, 14d
        print filaTB
        printc ln, 0d
        printc msgLlenar4, 14d
        getn2
        cmp n2[1], 48
        jz C10
        cmp n2[0], 49
        jz C1
        cmp n2[0], 50
        jz C2
        cmp n2[0], 51
        jz C3
        cmp n2[0], 52
        jz C4
        cmp n2[0], 53
        jz C5
        cmp n2[0], 54
        jz C6
        cmp n2[0], 55
        jz C7
        cmp n2[0], 56
        jz C8
        cmp n2[0], 57
        jz C9
        jmp repetir
    
    C1:
        mov columnaTB, 0
        jmp salir
    
    C2:
        mov columnaTB, 1
        jmp salir
    
    C3:
        mov columnaTB, 2
        jmp salir
    
    C4:
        mov columnaTB, 3
        jmp salir
    
    C5:
        mov columnaTB, 4
        jmp salir
    
    C6:
        mov columnaTB, 5
        jmp salir
    
    C7:
        mov columnaTB, 6
        jmp salir
    
    C8:
        mov columnaTB, 7
        jmp salir
    
    C9:
        mov columnaTB, 8
        jmp salir
    
    C10:
        mov columnaTB, 9
        jmp salir
    
    salir:
endm

dispararJ2 macro fila, columna
    local F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, salir, MarcarAguaF1, MarcarAguaF2, MarcarAguaF3, MarcarAguaF4, MarcarAguaF5, MarcarAguaF6, MarcarAguaF7, MarcarAguaF8, MarcarAguaF9, MarcarAguaF10, MarcarBombaF1, MarcarBombaF2, MarcarBombaF3, MarcarBombaF4, MarcarBombaF5, MarcarBombaF6, MarcarBombaF7, MarcarBombaF8, MarcarBombaF9, MarcarBombaF10

    mov bx, columna
    cmp fila, 0
    jz F1
    cmp fila, 1
    jz F2
    cmp fila, 2
    jz F3
    cmp fila, 3
    jz F4
    cmp fila, 4
    jz F5
    cmp fila, 5
    jz F6
    cmp fila, 6
    jz F7
    cmp fila, 7
    jz F8
    cmp fila, 8
    jz F9
    cmp fila, 9
    jz F10

    F1:
        cmp r1tb1[bx], 0
        jz MarcarAguaF1
        jmp MarcarBombaF1
    
    F2:
        mov r2tb1[bx], 0
        jz MarcarAguaF2
        jmp MarcarBombaF2
    
    F3:
        mov r3tb1[bx], 0
        jz MarcarAguaF3
        jmp MarcarBombaF3
    
    F4:
        mov r4tb1[bx], 0
        jz MarcarAguaF4
        jmp MarcarBombaF4
    
    F5:
        mov r5tb1[bx], 0
        jz MarcarAguaF5
        jmp MarcarBombaF5
    
    F6:
        mov r6tb1[bx], 0
        jz MarcarAguaF6
        jmp MarcarBombaF6
    
    F7:
        mov r7tb1[bx], 0
        jz MarcarAguaF7
        jmp MarcarBombaF7
    
    F8:
        mov r8tb1[bx], 0
        jz MarcarAguaF8
        jmp MarcarBombaF8
    
    F9:
        mov r9tb1[bx], 0
        jz MarcarAguaF9
        jmp MarcarBombaF9
    
    F10:
        mov r10tb1[bx], 0
        jz MarcarAguaF10
        jmp MarcarBombaF10
    
    MarcarAguaF1:
        mov r1tb4[bx], 7
        incremetarDisparioBarco2
        jmp salir
    
    MarcarBombaF1:
        mov r1tb4[bx], 6
        jmp salir
    
    MarcarAguaF2:
        mov r2tb4[bx], 7
        incremetarDisparioBarco2
        jmp salir
    
    MarcarBombaF2:
        mov r2tb4[bx], 6
        jmp salir
    
    MarcarAguaF3:
        mov r3tb4[bx], 7
        incremetarDisparioBarco2
        jmp salir
    
    MarcarBombaF3:
        mov r3tb4[bx], 6
        jmp salir
    
    MarcarAguaF4:
        mov r4tb4[bx], 7
        incremetarDisparioBarco2
        jmp salir
    
    MarcarBombaF4:
        mov r4tb4[bx], 6
        jmp salir
    
    MarcarAguaF5:
        mov r5tb4[bx], 7
        incremetarDisparioBarco2
        jmp salir
    
    MarcarBombaF5: 
        mov r5tb4[bx], 6
        jmp salir
    
    MarcarAguaF6:
        mov r6tb4[bx], 7
        incremetarDisparioBarco2
        jmp salir
    
    MarcarBombaF6:
        mov r6tb4[bx], 6
        jmp salir
    
    MarcarAguaF7:
        mov r7tb4[bx], 7
        incremetarDisparioBarco2
        jmp salir
    
    MarcarBombaF7:
        mov r7tb4[bx], 6
        jmp salir
    
    MarcarAguaF8:
        mov r8tb4[bx], 7
        incremetarDisparioBarco2
        jmp salir
    
    MarcarBombaF8:
        mov r8tb4[bx], 6
        jmp salir
    
    MarcarAguaF9:
        mov r9tb4[bx], 7
        incremetarDisparioBarco2
        jmp salir
    
    MarcarBombaF9:
        mov r9tb4[bx], 6
        jmp salir
    
    MarcarAguaF10:
        mov r10tb4[bx], 7
        incremetarDisparioBarco2
        jmp salir
    
    MarcarBombaF10: 
        mov r10tb4[bx], 6
        jmp salir
    
    salir:
endm

incremetarJ1 macro
    mov si, contJ1
    inc si
    mov contJ1, si
endm

incremetarDisparioBarco1 macro
    mov si, disBarco1
    inc si
    mov disBarco1, si

incremetarDisparioBarco2 macro
    mov si, disBarco2
    inc si
    mov disBarco2, si