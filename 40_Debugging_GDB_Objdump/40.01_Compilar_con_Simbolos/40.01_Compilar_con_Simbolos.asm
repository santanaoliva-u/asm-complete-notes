; 40.01 Compilar con Simbolos
; Creado: 2025-06-27
section .data
    ; [Datos inicializados]
section .bss
    ; [Variables no inicializadas]
section .text
    global _start
_start:
    
    ; Salida limpia
    mov rax, 60         ; syscall: exit
    mov rdi, 0          ; código de salida 0
    syscall
