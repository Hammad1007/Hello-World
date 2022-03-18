; Task 1
; Printing hello World in Assembly Language
;---------------------------------------------------

[org 0x0100] 
jmp start 
message: db 'Hello World', 0
message1: db 'Hello World again', 0
message2: db 'Hello World again and again', 0

; subroutine to clear the screen 
clrscr: 
    push es 
    push ax 
    push cx 
    push di 
    mov ax, 0xb800 
    mov es, ax ; point es to video base 
    xor di, di ; point di to top left column 
    mov ax, 0x0720 ; space char in normal attribute 
    mov cx, 2000 ; number of screen locations 
    cld ; auto increment mode 
    rep stosw ; clear the whole screen 
    pop di
    pop cx 
    pop ax 
    pop es 
    ret 

start: 
   
   mov ah, 0
   int 0x16
   call clrscr  ; function to clear any content on screen
   
   ; Printing once 
   mov ah, 0x13 ; service 13 - print string 
   mov al, 1 ; subservice 01 – update cursor 
   mov bh, 0 ; output on page 0 
   mov bl, 15 ; normal attribute
   mov dx, 0x0000 ; row 10 column 3 
   mov cx, 11 ; length of string 
   push cs 
   pop es ; segment of string 
   mov bp, message ; offset of string 
   int 0x10 ; call BIOS video service 
   
   mov ah, 0
   int 0x16
   
   mov ah, 0x13 ; service 13 - print string 
   mov al, 1 ; subservice 01 – update cursor 
   mov bh, 0 ; output on page 0 
   mov bl, 2 ; normal attribute 
   mov dx, 0x0500 ; row 10 column 3 
   mov cx, 17 ; length of string 
   push cs 
   pop es ; segment of string 
   mov bp, message1 ; offset of string 
   int 0x10 ; call BIOS video service 
   
   mov ah, 0
   int 0x16
   
   mov ah, 0x13 ; service 13 - print string 
   mov al, 1 ; subservice 01 – update cursor 
   mov bh, 0 ; output on page 0 
   mov bl, 5 ; normal attrib 
   mov dx, 0x0A00 ; row 10 column 3 
   mov cx, 27 ; length of string 
   push cs 
   pop es ; segment of string 
   mov bp, message2 ; offset of string 
   int 0x10 ; call BIOS video service 
   
   mov ah, 0
   int 0x16
   
   mov ax, 0x4c00
   int 0x21
