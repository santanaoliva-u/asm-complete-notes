---
title: x86-64 NASM Ultimate Cheatsheet
tags:
  - asm
  - x86-64
  - nasm
  - hacking
  - referencia
  - dataview
  - obsidian
level: 
difficulty: principiante,intermedio,avanzado
tools:
  - nasm
  - gdb
  - radare2
  - cutter
  - pwntools
  - docker
  - qemu
  - ghidra
created: 2025-06-27
last_modified: 
version: 1.0.0
status: stable
updated_by: santanaoliva_u
---

# x86-64 NASM Cheatsheet



> [!NOTE]  
> Referencia definitiva para aprender ASM (x86-64, NASM) en Arch Linux 2025. Diseñado para Obsidian con soporte para Dataview, Excalidraw, y Codeblock. Cubre desde fundamentos hasta hacking ofensivo.




> **Arquitectura:** x86-64 (64 bits, sintaxis NASM)  
> **Entorno:** Arch Linux 2025, NASM, GDB, Radare2, Cutter, pwntools, Docker, QEMU  
> **Enlaces:** [[README]] | [[00_MOV_y_Registros_Basicos/index]] | [[100_Shellcode_Injection/index]] | [[105_Proyectos_Avanzados/index]]  

> **Instalación:**  
```bash  
> sudo pacman -Syu  
> sudo pacman -S nasm gdb radare2 cutter python-pwntools docker qemu  
> yay -S obsidian  
> sudo usermod -aG docker $USER  
> ```
>  **Seguridad:** Ejecutar exploits en Docker (`docker run -it -v $(pwd):/workspace ubuntu:24.04`) o QEMU (`qemu-x86_64`).  


> [!WARNING]  
> Los niveles 50-100 (buffer overflow, shellcode, inyección) deben ejecutarse en entornos aislados para evitar daños al sistema. Ver [[100.02_Inyeccion_en_Stack]].

---



## Índice de Categorías

- [Transferencia de Datos](#transferencia-de-datos)  
- [Aritméticas](#aritméticas)  
- [Lógicas y Bits](#lógicas-y-bits)  
- [Control de Flujo](#control-de-flujo)  
- [Stack y Funciones](#stack-y-funciones)  
- [Syscalls](#syscalls)  
- [Avanzadas (Hacking)](#avanzadas-hacking)  
- [Banderas Afectadas](#banderas-afectadas)  
- [Mapa de Registros](#mapa-de-registros)  
- [Dataview Queries](#dataview-queries)  



---


## Transferencia de Datos
Ver Instrucciones

| Mnemónico | Operandos   | Descripción                    | Ciclos (Aprox.) | Opcode (Ejemplo)          | Banderas | Ejemplo                                         | Submódulo                                                           |
| --------- | ----------- | ------------------------------ | --------------- | ------------------------- | -------- | ----------------------------------------------- | ------------------------------------------------------------------- |
| MOV       | dst, src    | Mueve datos a registro/memoria | 1-3             | `8B /r`, `C7 /0`          | Ninguna  | ```asm<br>mov rax, 0x42<br>mov [buffer], rax``` | [[00.05_MOV_entre_Registros]], [[00.06_MOV_con_Valores_Inmediatos]] |
| XCHG      | reg1, reg2  | Intercambia valores            | 3               | `87 /r`                   | Ninguna  | ```asm<br>xchg rax, rbx```                      | [[00.05_MOV_entre_Registros]]                                       |
| LEA       | reg, [addr] | Carga dirección efectiva       | 1-2             | `8D /r`                   | Ninguna  | ```asm<br>lea rsi, [buffer]```                  | [[00.08_MOV_con_Punteros]]                                          |
| MOVZX     | dst, src    | Mueve con extensión de cero    | 1-3             | ` intensivamente0F B6 /r` | Ninguna  | ```asm<br>movzx rax, byte [mem]```              | [[00.07_MOV_con_Memoria_Directa]]                                   |
| MOVSX     | dst, src    | Mueve con extensión de signo   | 1-3             | `0F BE /r`                | Ninguna  | ```asm<br>movsx rax, byte [mem]```              | [[00.07_MOV_con_Memoria_Directa]]                                   |

> [!TIP]  
> - **MOV:** Ideal para inicializar registros o memoria. Evita null bytes en shellcode (`xor rax, rax; mov al, 0x42`).  
> - **LEA:** Útil para punteros en exploits. Ver [[100.01_Generacion_Manual_de_Shellcode]].


---

## Aritméticas
Instrucciones

| Mnemónico | Operandos | Descripción | Ciclos (Aprox.) | Opcode (Ejemplo) | Banderas | Ejemplo | Submódulo |
|-----------|-----------|-------------|-----------------|------------------|----------|---------|-----------|
| ADD       | dst, src  | Suma src a dst | 1-3 | `01 /r` | C, O, S, Z, A, P | ```asm<br>add rax, rbx``` | [[05.01_Suma_Resta_INC_DEC]] |
| SUB       | dst, src  | Resta src de dst | 1-3 | `29 /r` | C, O, S, Z, A, P | ```asm<br>sub rcx, 0x10``` | [[05.01_Suma_Resta_INC_DEC]] |
| INC       | dst       | Incrementa dst | 1-2 | `FF /0` | O, S, Z, A, P | ```asm<br>inc rcx``` | [[05.01_Suma_Resta_INC_DEC]] |
| DEC       | dst       | Decrementa dst | 1-2 | `FF /1` | O, S, Z, A, P | ```asm<br>dec rbx``` | [[05.01_Suma_Resta_INC_DEC]] |
| MUL       | src       | Multiplica RAX por src | 3-5 | `F7 /4` | C, O | ```asm<br>mul rbx``` | [[05.02_Multiplicacion_y_Division]] |
| DIV       | src       | Divide RAX por src | 10-20 | `F7 /6` | C, O, S, Z, A, P | ```asm<br>div rcx``` | [[05.02_Multiplicacion_y_Division]] |
| IMUL      | src       | Multiplica con signo | 3-5 | `F7 /5` | C, O | ```asm<br>imul rbx``` | [[05.02_Multiplicacion_y_Division]] |

> [!TIP]  
> - **MUL/DIV:** Usan RAX/RDX implícitamente. Cuidado con divisiones por cero.  
> - **Banderas:** Clave para saltos condicionales. Ver [[10.01_Comparaciones_CMP_TEST]].


---

## Lógicas y Bits
Instrucciones

| Mnemónico | Operandos | Descripción | Ciclos (Aprox.) | Opcode (Ejemplo) | Banderas | Ejemplo | Submódulo |
|-----------|-----------|-------------|-----------------|------------------|----------|---------|-----------|
| AND       | dst, src  | AND lógico | 1-3 | `21 /r` | S, Z, P | ```asm<br>and rax, 0xFF``` | [[15.01_AND_OR_XOR_NOT]] |
| OR        | dst, src  | OR lógico | 1-3 | `09 /r` | S, Z, P | ```asm<br>or rbx, rcx``` | [[15.01_AND_OR_XOR_NOT]] |
| XOR       | dst, src  | XOR lógico | 1-3 | `31 /r` | S, Z, P | ```asm<br>xor rax, rax``` | [[15.01_AND_OR_XOR_NOT]] |
| SHL       | dst, count | Desplaza izquierda | 1-3 | `D3 /4` | C, S, Z, P | ```asm<br>shl rax, 2``` | [[15.02_Desplazamientos_SHL_SHR]] |
| SHR       | dst, count | Desplaza derecha | 1-3 | `D3 /5` | C, S, Z, P | ```asm<br>shr rbx, 1``` | [[15.02_Desplazamientos_SHL_SHR]] |
| ROL       | dst, count | Rota izquierda | 1-3 | `D3 /0` | C | ```asm<br>rol rax, 4``` | [[15.03_Rotaciones_ROL_ROR]] |
| ROR       | dst, count | Rota derecha | 1-3 | `D3 /1` | C | ```asm<br>ror rbx, 3``` | [[15.03_Rotaciones_ROL_ROR]] |

> [!TIP]  
> - **XOR rax, rax:** Método eficiente para limpiar registros (evita null bytes).  
> - **SHL/SHR:** Útil en ofuscación y optimización. Ver [[75.02_Ofuscacion_Basica]].

---

## Control de Flujo
Instrucciones

| Mnemónico | Operandos | Descripción | Ciclos (Aprox.) | Opcode (Ejemplo) | Banderas | Ejemplo | Submódulo |
|-----------|-----------|-------------|-----------------|------------------|----------|---------|-----------|
| CMP       | op1, op2  | Compara restando | 1-2 | `39 /r` | C, O, S, Z, A, P | ```asm<br>cmp rax, rbx``` | [[10.01_Comparaciones_CMP_TEST]] |
| TEST      | op1, op2  | AND lógico sin guardar | 1-2 | `85 /r` | S, Z, P | ```asm<br>test rax, rax``` | [[10.01_Comparaciones_CMP_TEST]] |
| JMP       | target    | Salto incondicional | 1-3 | `E9 cd` | Ninguna | ```asm<br>jmp label``` | [[10.02_Jump_Incondicional]] |
| JE        | target    | Salto si igual | 1-3 | `74 cb` | Z | ```asm<br>je label``` | [[10.03_Jumps_Condicionales]] |
| JNE       | target    | Salto si no igual | 1-3 | `75 cb` | Z | ```asm<br>jne label``` | [[10.03_Jumps_Condicionales]] |
| JL        | target    | Salto si menor | 1-3 | `7C cb` | S, O | ```asm<br>jl label``` | [[10.03_Jumps_Condicionales]] |
| JG        | target    | Salto si mayor | 1-3 | `7F cb` | S, O, Z | ```asm<br>jg label``` | [[10.03_Jumps_Condicionales]] |
| LOOP      | target    | Bucle con ECX | 5-6 | `E2 cb` | Ninguna | ```asm<br>loop loop_start``` | [[10.04_Bucles_Simples]] |

> [!TIP]  
> - **CMP/TEST:** Base para saltos condicionales. TEST es más eficiente para verificar cero.  
> - **LOOP:** Menos común en shellcode; prefiera JMP con contador manual. Ver [[10.05_Condiciones_Anidadas]].


---

## Stack y Funciones

Instrucciones

| Mnemónico | Operandos | Descripción          | Ciclos (Aprox.) | Opcode (Ejemplo) | Banderas | Ejemplo                    | Submódulo                         |
| --------- | --------- | -------------------- | --------------- | ---------------- | -------- | -------------------------- | --------------------------------- |
| PUSH      | src       | Empuja a stack       | 1-3             | `50 +r`          | Ninguna  | ```asm<br>push rax```      | [[20.01_PUSH_y_POP]]              |
| POP       | dst       | Saca del stack       | 1-3             | `58 +r`          | Ninguna  | ```asm<br>pop rbx```       | [[20.01_PUSH_y_POP]]              |
| CALL      | target    | Llama función        | 3-5             | `E8 cd`          | Ninguna  | ```asm<br>call func```     | [[20.02_CALL_y_RET]]              |
| RET       | —         | Retorno de función   | 3-5             | `C3`             | Ninguna  | ```asm<br>ret```           | [[20.02_CALL_y_RET]]              |
| ENTER     | imm, imm  | Crea marco de pila   | 10-12           | `C8 iw ib`       | Ninguna  | ```asm<br>enter 0x10, 0``` | [[20.04_Estructura_de_Funciones]] |
| LEAVE     | —         | Libera marco de pila | 3               | `C9`             | Ninguna  | ```asm<br>leave```         | [[20.04_Estructura_de_Funciones]] |

> [!TIP]  
> - **System V ABI:** Argumentos en RDI, RSI, RDX, RCX, R8, R9. Ver [[20.06_Convenciones_de_Llamada]].  
> - **PUSH/POP:** Clave en exploits de buffer overflow. Ver [[50.03_Control_de_Flujo]].



> [!EXAMPLE] Ejemplo de Función  
> ```asm  
> section .text  
> global my_func  
> my_func:  
>     push rbp  
>     mov rbp, rsp  
>     mov rax, [rdi] ; Primer argumento  
>     add rax, 0x1  
>     leave  
>     ret  
> ```


---

## Syscalls

 Instrucciones

| Mnemónico | Operandos | Descripción | Ciclos (Aprox.) | Opcode (Ejemplo) | Banderas | Ejemplo | Submódulo |
|-----------|-----------|-------------|-----------------|------------------|----------|---------|-----------|
| SYSCALL   | —         | Llamada al sistema | Varía | `0F 05` | Depende | ```asm<br>mov rax, 1<br>syscall``` | [[30.01_Syscalls_Write_Read]], [[65.01_Syscalls_Complejas]] |


> [!EXAMPLE] Syscall: write  
> ```asm  
> section .data  
>     msg db "Hello, World!", 0xA  
>     len equ $ - msg  
> section .text  
>     global _start  
> _start:  
>     mov rax, 1    ; syscall: write  
>     mov rdi, 1    ; fd: stdout  
>     mov rsi, msg  ; buffer  
>     mov rdx, len  ; length  
>     syscall  
>     mov rax, 60   ; syscall: exit  
>     xor rdi, rdi  ; status: 0  
>     syscall  
> ```


> [!TIP]  
> - **Syscalls Comunes:** write (1), read (0), exit (60), execve (59). Ver [[65.02_Execve_Avanzado]].  
> - **Seguridad:** Probar en Docker para evitar daños. Ver [[100.02_Inyeccion_en_Stack]].


---

## Avanzadas (Hacking)
Instrucciones

| Mnemónico | Operandos | Descripción | Ciclos (Aprox.) | Opcode (Ejemplo) | Banderas | Ejemplo | Submódulo |
|-----------|-----------|-------------|-----------------|------------------|----------|---------|-----------|
| INT       | imm       | Interrupción software (legacy) | Varía | `CD ib` | Depende | ```asm<br>int 0x80``` | [[30.01_Syscalls_Write_Read]] |
| MOVS      | —         | Mueve string (DS:SI a ES:DI) | 7-10 | `A4` | Ninguna | ```asm<br>movs byte ptr [rdi], [rsi]``` | [[35.03_Manipulacion_de_Strings]] |
| CMPS      | —         | Compara string | 10-12 | `A6` | C, O, S, Z, A, P | ```asm<br>cmps byte ptr [rsi], [rdi]``` | [[35.02_Comparacion_y_Busqueda]] |
| STOS      | —         | Almacena string en ES:DI | 4-5 | `AA` | Ninguna | ```asm<br>stos byte ptr [rdi]``` | [[35.03_Manipulacion_de_Strings]] |
| SCAS      | —         | Escanea string en ES:DI | 4-5 | `AE` | C, O, S, Z, A, P | ```asm<br>scas byte ptr [rdi]``` | [[35.02_Comparacion_y_Busqueda]] |

> [!EXAMPLE] Shellcode: execve /bin/sh  
> ```asm  
> section .text  
>     global _start  
> _start:  
>     xor rax, rax  
>     mov al, 59        ; syscall: execve  
>     lea rdi, [rel bin_sh]  
>     xor rsi, rsi      ; argv: NULL  
>     xor rdx, rdx      ; envp: NULL  
>     syscall  
> bin_sh:  
>     db "/bin/sh", 0  
> ```

> [!TIP]  
> - **MOVS/CMPS/STOS/SCAS:** Ideales para manipulación de strings en shellcode. Ver [[35.04_Strings_Null_Terminated]].  
> - **Shellcode:** Evitar null bytes usando XOR. Ver [[80.04_Shellcode_sin_Null_Bytes]].


---

## Banderas Afectadas

| Bandera | Descripción | Instrucciones Principales | Submódulo |
|---------|-------------|--------------------------|-----------|
| C (Carry) | Acarreo o préstamo | ADD, SUB, CMP, SHL, SHR, CMPS, SCAS | [[05.04_Flags_Aritmeticos]] |
| O (Overflow) | Desbordamiento aritmético | ADD, SUB, MUL, DIV, CMPS, SCAS | [[05.04_Flags_Aritmeticos]] |
| S (Sign) | Signo del resultado | ADD, SUB, AND, OR, XOR, CMPS, SCAS | [[05.04_Flags_Aritmeticos]] |
| Z (Zero) | Resultado es cero | ADD, SUB, AND, OR, XOR, CMP, TEST, CMPS, SCAS | [[05.04_Flags_Aritmeticos]] |
| A (Aux. Carry) | Acarreo en nibble bajo | ADD, SUB, CMPS, SCAS | [[05.04_Flags_Aritmeticos]] |
| P (Parity) | Paridad del resultado | ADD, SUB, AND, OR, XOR, CMPS, SCAS | [[05.04_Flags_Aritmeticos]] |

> [!TIP]  
> - Visualizar banderas en GDB: `info registers`. Ver [[40.03_Visualizar_Registros_y_Stack]].  
> - Usar en saltos condicionales: `je` (Z=1), `jl` (S≠O). Ver [[10.03_Jumps_Condicionales]].

> [!EXCALIDRAW] Diagrama de Banderas  
> - Crear un Excalidraw en Obsidian para visualizar el registro de banderas (EFLAGS/RFLAGS).  
> - Incluir bits: CF, OF, SF, ZF, AF, PF.

---

## Mapa de Registros

| Registro | Uso Principal | Convención System V ABI | Submódulo |
|----------|---------------|-------------------------|-----------|
| RAX      | Acumulador, retorno | Retorno de funciones | [[00.03_Registros_Generales]] |
| RDI      | Argumento 1 | Primer argumento | [[20.06_Convenciones_de_Llamada]] |
| RSI      | Argumento 2 | Segundo argumento | [[20.06_Convenciones_de_Llamada]] |
| RDX      | Argumento 3 | Tercer argumento | [[20.06_Convenciones_de_Llamada]] |
| RCX      | Argumento 4 | Cuarto argumento | [[20.06_Convenciones_de_Llamada]] |
| R8       | Argumento 5 | Quinto argumento | [[20.06_Convenciones_de_Llamada]] |
| R9       | Argumento 6 | Sexto argumento | [[20.06_Convenciones_de_Llamada]] |
| RSP      | Puntero de pila | Stack pointer | [[20.03_RBP_y_RSP]] |
| RBP      | Puntero de marco | Base pointer | [[20.03_RBP_y_RSP]] |
| RIP      | Puntero de instrucción | Siguiente instrucción | [[50.03_Control_de_Flujo]] |

> [!TIP]  
> - **System V ABI:** Estándar en Linux x86-64. Argumentos adicionales en stack. Ver [[20.06_Convenciones_de_Llamada]].  
> - **RIP:** Clave en exploits para controlar el flujo. Ver [[50.03_Control_de_Flujo]].

> [!EXCALIDRAW] Diagrama de Stack  
> - Crear un Excalidraw para mostrar RSP, RBP, y el layout del stack (argumentos, retorno, variables locales).  
> - Ver [[20.04_Estructura_de_Funciones]].

---

## Dataview Queries

> [!NOTE] Consultas Dinámicas  
> Usa el plugin Dataview para filtrar y organizar instrucciones por nivel, dificultad, o categoría.

```dataview
TABLE title, difficulty, tags, tools
FROM "03_ASM/Tablas"
WHERE contains(tags, "nasm")
SORT level ASC
````





