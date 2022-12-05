include macros.asm ; include the macros file

.model small
.stack


.data
	ln db 0ah, '$'
    intro0 db 'Universidad de San Carlos de Guatemala','$'
	intro1 db 'Facultad de Ingenieria','$'
	intro2 db 'Escuela de Ciencias y Sistemas','$'
	intro3 db 'Arquitectura de Computadores y Ensambladores 1','$'
	intro4 db 'Seccion A','$'
	intro5 db 'Daniel Reginaldo Dubon Rodriguez','$'
	intro6 db '201901772','$'
	msg db '          MENU', '$'
	op1 db '-> 1. Inciar Juego', '$'
	op2 db '-> 2. Cargar Juego', '$'
	op3 db '-> 3. Salir', '$'
	iop db 'Ingrese una opcion: $'
	mayor db '    >  $'
	msgJ1 db 'Inicia Jugador 1', '$'
	msgJ2 db 'Inicia Jugador 2', '$'
	turnoJ2 db 'Turno Jugador 2', '$'
	turnoJ1 db 'Turno Jugador 1', '$'
	msgCargar db 'Cargar Juego: ', '$'
	msgLlenarTBJ1 db 'Llenar Tablero Jugador 1', '$'
	msgLlenarTBJ2 db 'Llenar Tablero Jugador 2', '$'
	msgLlenar1 db 'Ingrese el tipo de barco (1-5): $'
	msgLlenar2 db 'Ingrese la posicion Veritcal (v), Horizontal (h): $'
	msgLlenar3 db 'Ingrese la fila (A-J): $'
	msgLlenar4 db 'Ingrese la columna (1-10): $'
	msgPos db 'No se puede sobreponer los barcos: $'
	pruebass db 'Si aaaaaaa $'
	msgEmpiezaBatalla db 'Empieza la Batalla Jugador 1', '$'
	msgConfirmacion db 'Confirmar disparo [y/n]: $'
	msgDisparoRealizado db 'Disparo realizado', '$'
	msgContinuar db 'Presione Enter para continuar: $'
	msgBarcoDisp1 db 'Barcos faltantes Jugador 1', '$'
	msgBarcoDisp2 db 'Barcos faltantes Jugador 2', '$'
	msgDisparoAgua db 'Disparo en agua: ', '$'
	msgDisparoBarco db 'Disparo en barco: ', '$'
	msgMio db 'Mis barcos', '$'
	msgG1 db 'Ganador Jugador 1', '$'
	a db ' A ', '$'
	b db ' B ', '$'
	lc db ' C ', '$'
	d db ' D ', '$'
	e db ' E ', '$'
	f db ' F ', '$'
	g db ' G ', '$'
	h db ' H ', '$'
	i db ' I ', '$'
	j db ' J ', '$'
	sep db '|', '$'
	line db '    ----------------------------------------', '$'
	inferior db '     1   2   3   4   5   6   7   8   9   10', '$'
	espacio db '   |','$'
	barco db ' B |', '$'
	numero1 db ' 1 |', '$'
	numero2 db ' 2 |', '$'
	numero3 db ' 3 |', '$'
	numero4 db ' 4 |', '$'
	numero5 db ' 5 |', '$'
	bomba db ' X |', '$'
	agua db ' 0 |', '$'
	turno db 0
	naux db 2 dup(' '), '$'
	baux db 10
	n2 db 2 dup(' '), '$'

	b1 db '-> 1. Bote neumatico',0ah, 0dh, '$'
	b2 db '-> 2. Destructor americano',0ah, 0dh, '$'
	b3 db '-> 3. Destructor japones',0ah, 0dh, '$'
	b4 db '-> 4. Acorozanado',0ah, 0dh, '$'
	b5 db '-> 5. Portaaviones',0ah, 0dh, '$'

	barcosDisponiblesJ1 db 1,2,3,4,5
	barcosDisponiblesJ2 db 1,2,3,4,5

	barcosDisponiblesJ11 db 1,2,3,4,5
	barcosDisponiblesJ22 db 1,2,3,4,5
	tipoB db 0
	posicionTB db '0', '$'
	filaTB db '0', '$'
	filaTBAux dw 0
	columnaTB dw 0
	posOcupada db 0

	contJ1 dw 0
	contJ2 dw 0
	disAgua1 dw 0
	disAgua2 dw 0
	disBarco2 dw 0
	disBarco1 dw 0

	r1tb1 db 0,0,0,0,0,0,0,0,0,0
	r2tb1 db 0,0,0,0,0,0,0,0,0,0
	r3tb1 db 0,0,0,0,0,0,0,0,0,0
	r4tb1 db 0,0,0,0,0,0,0,0,0,0
	r5tb1 db 0,0,0,0,0,0,0,0,0,0
	r6tb1 db 0,0,0,0,0,0,0,0,0,0
	r7tb1 db 0,0,0,0,0,0,0,0,0,0
	r8tb1 db 0,0,0,0,0,0,0,0,0,0
	r9tb1 db 0,0,0,0,0,0,0,0,0,0
	r10tb1 db 0,0,0,0,0,0,0,0,0,0

	r1tb2 db 0,0,0,0,0,0,0,0,0,0
	r2tb2 db 0,0,0,0,0,0,0,0,0,0
	r3tb2 db 0,0,0,0,0,0,0,0,0,0
	r4tb2 db 0,0,0,0,0,0,0,0,0,0
	r5tb2 db 0,0,0,0,0,0,0,0,0,0
	r6tb2 db 0,0,0,0,0,0,0,0,0,0
	r7tb2 db 0,0,0,0,0,0,0,0,0,0
	r8tb2 db 0,0,0,0,0,0,0,0,0,0
	r9tb2 db 0,0,0,0,0,0,0,0,0,0
	r10tb2 db 0,0,0,0,0,0,0,0,0,0

	r1tb3 db 0,0,0,0,0,0,0,0,0,0
	r2tb3 db 0,0,0,0,0,0,0,0,0,0
	r3tb3 db 0,0,0,0,0,0,0,0,0,0
	r4tb3 db 0,0,0,0,0,0,0,0,0,0
	r5tb3 db 0,0,0,0,0,0,0,0,0,0
	r6tb3 db 0,0,0,0,0,0,0,0,0,0
	r7tb3 db 0,0,0,0,0,0,0,0,0,0
	r8tb3 db 0,0,0,0,0,0,0,0,0,0
	r9tb3 db 0,0,0,0,0,0,0,0,0,0
	r10tb3 db 0,0,0,0,0,0,0,0,0,0

	r1tb4 db 0,0,0,0,0,0,0,0,0,0
	r2tb4 db 0,0,0,0,0,0,0,0,0,0
	r3tb4 db 0,0,0,0,0,0,0,0,0,0
	r4tb4 db 0,0,0,0,0,0,0,0,0,0
	r5tb4 db 0,0,0,0,0,0,0,0,0,0
	r6tb4 db 0,0,0,0,0,0,0,0,0,0
	r7tb4 db 0,0,0,0,0,0,0,0,0,0
	r8tb4 db 0,0,0,0,0,0,0,0,0,0
	r9tb4 db 0,0,0,0,0,0,0,0,0,0
	r10tb4 db 0,0,0,0,0,0,0,0,0,0

; segemento de codigo    
.code

    ; procedimiento principal main
	main PROC
		INICIO:
			cls
			printc ln, 0d
			printc intro0, 10d
			printc ln, 0d
			printc intro1, 10d
			printc ln, 0d
			printc intro2, 10d
			printc ln, 0d
			printc intro3, 10d
			printc ln, 0d
			printc intro4, 10d
			printc ln, 0d
			printc intro5, 10d
			printc ln, 0d
			printc intro6, 10d
			getch
			cmp al, 0dh
			je MENU
			jne INICIO

		MENU:
			cls
			printc ln, 0d
			printc msg, 4d
			printc ln, 0d
			printc ln, 0d
			printc op1, 9d
			printc ln, 0d
			printc op2, 9d
			printc ln, 0d
			printc op3, 9d
			printc ln, 0d
			printc ln, 0d
			printc iop, 15d
			printc ln, 0d
			printc mayor, 15d
			getch
			cmp al, 49
			je INICIARJUEGO
			cmp al, 50
			je CARGARJUEGO
			cmp al, 51
			je SALIR
			jmp MENU

		INICIARJUEGO:
			call random
			cmp turno, 0
			je INICIAJ1
			cmp turno, 1
			je INICIAJ2
			jmp MENU
		
		INICIAJ1:
			xor di, di
			cls
			printc ln, 0d
			printc msgJ1, 4d
			getch
			cmp al, 0dh
			je LLENARTABLEROJ1
			jmp INICIAJ1
		
		INICIAJ2:
			xor di, di
			cls
			printc ln, 0d
			printc msgJ2, 4d
			getch
			cmp al, 0dh
			je LLENARTABLEROJ222
			; je STARTGAME
			jmp INICIAJ2
		
		LLENARTABLEROJ1:
			llenandoTB1
			cmp di, 4
			je INTROLLENARTABLEROJ2
			jne INCREMENTAR
		
		INCREMENTAR:
			inc di
			jmp LLENARTABLEROJ1

		INTROLLENARTABLEROJ2:
			xor di, di
			cls
			imprimirTB1
			getch
			cls
			printc ln, 0d
			printc turnoJ2, 4d
			getch
			jmp LLENARTABLEROJ2

		LLENARTABLEROJ2:
			llenandoTB2
			cmp di, 4
			je INTROINICIAJUEGOJ1
			jne INCREMENTAR2
		
		INCREMENTAR2:
			inc di
			jmp LLENARTABLEROJ2
		
		INTROINICIAJUEGOJ1:
			cls
			imprimirTB2
			getch
			cls
			printc ln, 0d
			printc msgEmpiezaBatalla, 4d
			getch
			jmp STARTGAME
		
		STARTGAME:
			startGG
			jmp MENU
		
		LLENARTABLEROJ222:
			cls
			printc ln, 0d
			printc msgLlenarTBJ2, 4d
			getch
			jmp MENU

		CARGARJUEGO:
			cls
			printc ln, 0d
			printc msgCargar, 4d
			getch
			jmp MENU

		SALIR:
			.exit

	main ENDP   

	random PROC
		mov ah, 0h
		int 1ah

		mov ax, dx
		mov dx, 0
		mov bx, 2
		div bx

		mov turno, dl
		ret
	random ENDP

end main