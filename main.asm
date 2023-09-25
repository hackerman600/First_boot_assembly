org 0x7C00
bits 16

%define ENDL 0x0D, 0x0A ; macro = new line as cursor repos

start:
    jmp main


dsputs: 
    push si ; preserve the string
    push ax ;preserving 0 as accululator
    push bx ; preserve state of the bx register, he did not modify in video


.loop:  
    lodsb ; load string byte from si into al. loads one char at a time.  
    or al,al ; sets 0 flag if al is 0.
    jz .done ;  

    mov ah, 0x0e ; accumulator high assigne TTY vid interrupt code. Used to write char in TTY on screen. 
    int 0x10 ; video based interrupt

    jmp .loop 



.done:
    pop ax
    pop si
    pop bx
    ret


main:
    mov ax, 0 ;assign to 0 to clear register, ax = 0, accululator register AH, AL, 16B, General purpose. 
    mov ds, ax
    mov es, ax

    mov ss, ax
    mov sp, 0x7E00

    mov si, msg_hello ;
    call dsputs


.halt:
    jmp .halt


msg_hello: db "Hello World", ENDL,0 

times 510-($-$$) db 0
dw 0xAA55

     
