%include "simple_io.inc"
global asm_main

section .data
    mes1: db "incorrect number of command line arguments",10,0
    mes2: db "input string too long",10,0
    mes3: db "input string: ",0
    mes4: db "border array:",0
    mes5: db ", ",0
    mes6: db "+++  ",0
    mes7: db "...  ",0
    mes8: db "     ",0
    array: dq 0,0,0,0,0,0,0,0,0,0,0,0

section .text
  display_line:
    enter 0,0
    saveregs
    mov r12,0 ; count
    mov rcx, 0 ; i
    mov r13, [rbp+16] ; array
    mov r15, [rbp+24] ; level
    mov rbx, [rbp+32] ; L
  LOOP6:
    mov r14, [r13+rcx*8] ; value of array[rcx]
    inc r12
    cmp r12,rbx
    ja EXIT
    cmp r15,1
    je IF1
    cmp r14,r15
    jb IF1A
    mov rax,mes6
    call print_string
  LOOP6A:
    inc rcx
    cmp rcx,rbx
    je EXIT
    jmp LOOP6
  IF1:
    cmp r14, qword 0
    ja IF1B
    mov rax,mes7
    call print_string
    jmp LOOP6A
  IF1A:
    mov rax,mes8
    call print_string
    jmp LOOP6A
  IF1B:
    mov rax,mes6
    call print_string
    jmp LOOP6A
  EXIT:
    call print_nl
    restoregs
    leave
    ret



  fancy_display:
    enter 0,0
    saveregs
    mov r12,[rbp+32] ; L
    mov rcx,[rbp+32] ; level
    mov r13,[rbp+24] ; array
  LOOP5:
    push r12
    push rcx
    push r13
    call display_line
    add rsp,24
    loop LOOP5
    restoregs
    leave
    ret



  simple_display:
    enter 0,0
    saveregs
    mov r14,[rbp+24] ; array
    mov rax,mes4
    call print_string
    mov rax,[r14] ; first value
    call print_int
    mov r13, [rbp+32] ; L
    mov r12,1 ; i
  LOOP4:
    cmp r12,r13
    jae END
    mov rax,mes5
    call print_string
    mov rax,[r14+r12*8]
    call print_int
    inc r12
    jmp LOOP4
  END:
    call print_nl
    restoregs
    leave
    ret


  bordar:
    enter  0,0
    saveregs
    mov rcx,1 ; rcx is r
    mov r12, [rbp+32] ; string
    mov r13, [rbp+24] ; r13 is L
    mov r15,qword 0 ; max
  LOOP2A:
    mov r9,qword 1 ; isborder
    mov r10,qword 0 ; i
  LOOP3A:
    cmp r10, rcx
    je LOOP2B
    mov r11b,[r12+r10] ; string[i]
    mov r8,0
    add r8,r13
    sub r8,rcx
    add r8,r10
    mov r8b,[r12+r8]
    cmp r11b,r8b
    je LOOP3B
    mov r9, 0
    jmp LOOP2B
  LOOP3B:
    inc r10
    jmp LOOP3A
  LOOP2B:
    cmp r9,1
    jne LOOP2C
    cmp r15,rcx
    jae LOOP2C
    mov r15,rcx
  LOOP2C:
    inc rcx
    cmp rcx,r13
    jne LOOP2A
    mov rax,r15
    restoregs
    leave
    ret



  asm_main:
  	enter	0,0
  	saveregs
    cmp rdi,qword 2
    je L2
    mov rax,mes1
    call print_string
    jmp LEAVE
  L2:
    mov r12,[rsi+8] ; argv[1]
    mov r13, qword 0 ; character counter
  LEN:
    mov al,[r12+r13] ; character at r13
    cmp al,0
    je L4
    inc r13 ; increment counter
    jmp LEN
  L4:
    cmp r13,12
    ja L3
    mov rax,mes3
    call print_string ; input string: 
    mov rax,r12 ; r12 is argv[1]
    call print_string ; user's input
    call print_nl
    mov rbx, qword 0 ; i
    mov r15,r13 ; r15 is L1
    dec r13 ; L-1
  LOOP1:
    cmp rbx,r13
    je L1
    push qword r12 ; push (incremented) argv[1]
    push qword r15 ; push L1
    sub rsp,8
    call bordar
    add rsp,24 
    mov qword [array+rbx*8], qword rax
    inc r12 ; move the pointer to the string 1 to the right
    inc rbx ; increment the counter
    dec r15 ; decrease L1
    jmp LOOP1
  L3:
    mov rax,mes2 ; "input string too long"
    call print_string
    jmp LEAVE
  L1:
    inc r13 ; re-increment r13 so r13 = L
    push qword r13 ; push L
    push array ; push the array
    sub rsp,8
    call simple_display
    add rsp,24
    push qword r13 ; push L
    push array ; push the array
    sub rsp,8
    call fancy_display
    add rsp,24
  LEAVE:
    restoregs
  	leave
  	ret