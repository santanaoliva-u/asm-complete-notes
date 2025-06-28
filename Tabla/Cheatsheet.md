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

# x86-64 NASM  Cheatsheet

> [!NOTE]  
> Referencia definitiva para aprender ensamblador x86-64 (NASM) en Arch Linux 2025. Diseñado para Obsidian con soporte para Dataview, Excalidraw, y Codeblock. Cubre desde fundamentos hasta hacking ofensivo. Usa Docker para pruebas seguras.

> **Arquitectura:** x86-64 (64 bits, sintaxis NASM)  
> **Entorno:** Arch Linux 2025, NASM, GDB, Radare2, Cutter, pwntools, Docker, QEMU, Ghidra, checksec  
> **Enlaces Clave:** [[README]] ([../README.md](../README.md)) | [[00_MOV_y_Registros_Basicos/index]] ([../00_MOV_y_Registros_Basicos/index.md](../00_MOV_y_Registros_Basicos/index.md)) | [[100_Shellcode_Injection/index]] ([../100_Shellcode_Injection/index.md](../100_Shellcode_Injection/index.md)) | [[105_Proyectos_Avanzados/index]] ([../105_Proyectos_Avanzados/index.md](../105_Proyectos_Avanzados/index.md))  
> **Repositorio:** [asm-complete-notes](https://github.com/santanaoliva-u/asm-complete-notes)

> [!WARNING]  
> Los niveles 50-100 (buffer overflow, shellcode, inyección) deben ejecutarse en entornos aislados (Docker/QEMU). Ver [[100.02_Inyeccion_en_Stack]] ([../100_Shellcode_Injection/100.02_Inyeccion_en_Stack/Apuntes/100.02_Inyeccion_en_Stack.md](../100_Shellcode_Injection/100.02_Inyeccion_en_Stack/Apuntes/100.02_Inyeccion_en_Stack.md)).

**Instalación (Host):**  
```bash
sudo pacman -Syu
sudo pacman -S nasm gdb radare2 cutter python-pwntools docker qemu-user qemu-system-x86 binutils
yay -S obsidian
sudo usermod -aG docker $USER
newgrp docker
```

**Laboratorio Docker:**  
```bash
cd ~/Documents/OBSIDIAN/Programacion/01_Estudio/03_ASM
docker build -t asm_lab .
docker run -it -v $(pwd):/workspace asm_lab
```

> [!TIP]  
> Usa QEMU para simular entornos físicos (`qemu-x86_64`). Desactiva ASLR en el contenedor para pruebas de exploits: `echo 0 > /proc/sys/kernel/randomize_va_space`.

---

## Índice de Categorías

- [Índice de Niveles](#índice-de-niveles)
- [Transferencia de Datos](#transferencia-de-datos)
- [Aritméticas](#aritméticas)
- [Lógicas y Bits](#lógicas-y-bits)
- [Control de Flujo](#control-de-flujo)
- [Stack y Funciones](#stack-y-funciones)
- [Segmentos de Memoria](#segmentos-de-memoria)
- [Syscalls](#syscalls)
- [Strings](#strings)
- [Hacking Avanzado](#hacking-avanzado)
- [Banderas Afectadas](#banderas-afectadas)
- [Mapa de Registros](#mapa-de-registros)
- [Dataview Queries](#dataview-queries)

---

## Índice de Niveles

> [!NOTE]  
> Todos los niveles están en `~/Documents/OBSIDIAN/Programacion/01_Estudio/03_ASM/`. Usa los enlaces para navegar.

- **Principiante:**
  - [[00_MOV_y_Registros_Basicos/index]] ([../00_MOV_y_Registros_Basicos/index.md](../00_MOV_y_Registros_Basicos/index.md)) - MOV y registros.
  - [[05_Operaciones_Aritmeticas/index]] ([../05_Operaciones_Aritmeticas/index.md](../05_Operaciones_Aritmeticas/index.md)) - Operaciones aritméticas.
  - [[10_Saltos_y_Control_de_Flujo/index]] ([../10_Saltos_y_Control_de_Flujo/index.md](../10_Saltos_y_Control_de_Flujo/index.md)) - Saltos y bucles.
  - [[15_Logica_y_Manipulacion_de_Bits/index]] ([../15_Logica_y_Manipulacion_de_Bits/index.md](../15_Logica_y_Manipulacion_de_Bits/index.md)) - Operaciones lógicas.
  - [[20_Stack_y_Funciones/index]] ([../20_Stack_y_Funciones/index.md](../20_Stack_y_Funciones/index.md)) - Pila y funciones.
  - [[25_Segmentos_de_Memoria/index]] ([../25_Segmentos_de_Memoria/index.md](../25_Segmentos_de_Memoria/index.md)) - Secciones de memoria.
  - [[30_Entrada_Salida/index]] ([../30_Entrada_Salida/index.md](../30_Entrada_Salida/index.md)) - Syscalls de E/S.
  - [[35_Strings_y_Estructuras/index]] ([../35_Strings_y_Estructuras/index.md](../35_Strings_y_Estructuras/index.md)) - Strings y estructuras.

- **Intermedio:**
  - [[40_Debugging_GDB_Objdump/index]] ([../40_Debugging_GDB_Objdump/index.md](../40_Debugging_GDB_Objdump/index.md)) - Debugging con GDB.
  - [[45_Formato_ELF/index]] ([../45_Formato_ELF/index.md](../45_Formato_ELF/index.md)) - Estructura ELF.
  - [[50_Buffer_Overflow/index]] ([../50_Buffer_Overflow/index.md](../50_Buffer_Overflow/index.md)) - Buffer overflows.
  - [[55_Análisis_de_Malware/index]] ([../55_Análisis_de_Malware/index.md](../55_Análisis_de_Malware/index.md)) - Análisis de malware.
  - [[60_Proteccion_y_Evasion/index]] ([../60_Proteccion_y_Evasion/index.md](../60_Proteccion_y_Evasion/index.md)) - Protecciones y evasión.
  - [[65_Avanzado_Syscalls/index]] ([../65_Avanzado_Syscalls/index.md](../65_Avanzado_Syscalls/index.md)) - Syscalls avanzadas.

- **Avanzado:**
  - [[70_ROP/index]] ([../70_ROP/index.md](../70_ROP/index.md)) - Return-Oriented Programming.
  - [[75_Optimizacion_y_Ofuscacion/index]] ([../75_Optimizacion_y_Ofuscacion/index.md](../75_Optimizacion_y_Ofuscacion/index.md)) - Optimización y ofuscación.
  - [[80_Shellcode/index]] ([../80_Shellcode/index.md](../80_Shellcode/index.md)) - Desarrollo de shellcode.
  - [[85_Exploit_Development/index]] ([../85_Exploit_Development/index.md](../85_Exploit_Development/index.md)) - Creación de exploits.
  - [[90_Inyeccion_de_Codigo/index]] ([../90_Inyeccion_de_Codigo/index.md](../90_Inyeccion_de_Codigo/index.md)) - Inyección de código.
  - [[95_Protecciones_Avanzadas/index]] ([../95_Protecciones_Avanzadas/index.md](../95_Protecciones_Avanzadas/index.md)) - RELRO, PIE, Fortify.
  - [[100_Shellcode_Injection/index]] ([../100_Shellcode_Injection/index.md](../100_Shellcode_Injection/index.md)) - Inyección de shellcode.
  - [[105_Proyectos_Avanzados/index]] ([../105_Proyectos_Avanzados/index.md](../105_Proyectos_Avanzados/index.md)) - Proyectos finales.

---

## Transferencia de Datos

| Mnemónico | Operandos   | Descripción                    | Ciclos (Aprox.) | Opcode (Ejemplo) | Banderas | Ejemplo                                         | Submódulo                                                           |
|-----------|-------------|--------------------------------|-----------------|------------------|----------|------------------------------------------------|---------------------------------------------------------------------|
| MOV       | dst, src    | Mueve datos a registro/memoria | 1-3             | `8B /r`, `C7 /0` | Ninguna  | ```asm<br>mov rax, 0x42<br>mov [buffer], rax``` | [[00.01_Introduccion_al_ASM]] ([../00_MOV_y_Registros_Basicos/00.01_Introduccion_al_ASM/Apuntes/00.01_Introduccion_al_ASM.md](../00_MOV_y_Registros_Basicos/00.01_Introduccion_al_ASM/Apuntes/00.01_Introduccion_al_ASM.md)) |
| XCHG      | reg1, reg2  | Intercambia valores            | 3               | `87 /r`          | Ninguna  | ```asm<br>xchg rax, rbx```                     | [[00.03_Registros_Generales]] ([../00_MOV_y_Registros_Basicos/00.03_Registros_Generales/Apuntes/00.03_Registros_Generales.md](../00_MOV_y_Registros_Basicos/00.03_Registros_Generales/Apuntes/00.03_Registros_Generales.md)) |
| LEA       | reg, [addr] | Carga dirección efectiva       | 1-2             | `8D /r`          | Ninguna  | ```asm<br>lea rsi, [buffer]```                 | [[00.03_Registros_Generales]] ([../00_MOV_y_Registros_Basicos/00.03_Registros_Generales/Apuntes/00.03_Registros_Generales.md](../00_MOV_y_Registros_Basicos/00.03_Registros_Generales/Apuntes/00.03_Registros_Generales.md)) |
| MOVZX     | dst, src    | Mueve con extensión de cero    | 1-3             | `0F B6 /r`       | Ninguna  | ```asm<br>movzx rax, byte [mem]```             | [[00.03_Registros_Generales]] ([../00_MOV_y_Registros_Basicos/00.03_Registros_Generales/Apuntes/00.03_Registros_Generales.md](../00_MOV_y_Registros_Basicos/00.03_Registros_Generales/Apuntes/00.03_Registros_Generales.md)) |
| MOVSX     | dst, src    | Mueve con extensión de signo   | 1-3             | `0F BE /r`       | Ninguna  | ```asm<br>movsx rax, byte [mem]```             | [[00.03_Registros_Generales]] ([../00_MOV_y_Registros_Basicos/00.03_Registros_Generales/Apuntes/00.03_Registros_Generales.md](../00_MOV_y_Registros_Basicos/00.03_Registros_Generales/Apuntes/00.03_Registros_Generales.md)) |

> [!TIP]  
> - **MOV:** Evita null bytes en shellcode (`xor rax, rax; mov al, 0x42`).  
> - **LEA:** Útil para calcular direcciones en exploits. Ver [[100.01_Generacion_Manual_de_Shellcode]] ([../100_Shellcode_Injection/100.01_Generacion_Manual_de_Shellcode/Apuntes/100.01_Generacion_Manual_de_Shellcode.md](../100_Shellcode_Injection/100.01_Generacion_Manual_de_Shellcode/Apuntes/100.01_Generacion_Manual_de_Shellcode.md)).

---

## Aritméticas

| Mnemónico | Operandos | Descripción               | Ciclos (Aprox.) | Opcode (Ejemplo) | Banderas         | Ejemplo                     | Submódulo                                                           |
|-----------|-----------|---------------------------|-----------------|------------------|------------------|-----------------------------|---------------------------------------------------------------------|
| ADD       | dst, src  | Suma src a dst            | 1-3             | `01 /r`          | C, O, S, Z, A, P | ```asm<br>add rax, rbx```   | [[05.01_Suma_Resta_INC_DEC]] ([../05_Operaciones_Aritmeticas/05.01_Suma_Resta_INC_DEC/Apuntes/05.01_Suma_Resta_INC_DEC.md](../05_Operaciones_Aritmeticas/05.01_Suma_Resta_INC_DEC/Apuntes/05.01_Suma_Resta_INC_DEC.md)) |
| SUB       | dst, src  | Resta src de dst          | 1-3             | `29 /r`          | C, O, S, Z, A, P | ```asm<br>sub rcx, 0x10```  | [[05.01_Suma_Resta_INC_DEC]] ([../05_Operaciones_Aritmeticas/05.01_Suma_Resta_INC_DEC/Apuntes/05.01_Suma_Resta_INC_DEC.md](../05_Operaciones_Aritmeticas/05.01_Suma_Resta_INC_DEC/Apuntes/05.01_Suma_Resta_INC_DEC.md)) |
| INC       | dst       | Incrementa dst            | 1-2             | `FF /0`          | O, S, Z, A, P    | ```asm<br>inc rcx```        | [[05.01_Suma_Resta_INC_DEC]] ([../05_Operaciones_Aritmeticas/05.01_Suma_Resta_INC_DEC/Apuntes/05.01_Suma_Resta_INC_DEC.md](../05_Operaciones_Aritmeticas/05.01_Suma_Resta_INC_DEC/Apuntes/05.01_Suma_Resta_INC_DEC.md)) |
| DEC       | dst       | Decrementa dst            | 1-2             | `FF /1`          | O, S, Z, A, P    | ```asm<br>dec rbx```        | [[05.01_Suma_Resta_INC_DEC]] ([../05_Operaciones_Aritmeticas/05.01_Suma_Resta_INC_DEC/Apuntes/05.01_Suma_Resta_INC_DEC.md](../05_Operaciones_Aritmeticas/05.01_Suma_Resta_INC_DEC/Apuntes/05.01_Suma_Resta_INC_DEC.md)) |
| MUL       | src       | Multiplica RAX por src    | 3-5             | `F7 /4`          | C, O             | ```asm<br>mul rbx```        | [[05.02_Multiplicacion_y_Division]] ([../05_Operaciones_Aritmeticas/05.02_Multiplicacion_y_Division/Apuntes/05.02_Multiplicacion_y_Division.md](../05_Operaciones_Aritmeticas/05.02_Multiplicacion_y_Division/Apuntes/05.02_Multiplicacion_y_Division.md)) |
| DIV       | src       | Divide RAX por src        | 10-20           | `F7 /6`          | C, O, S, Z, A, P | ```asm<br>div rcx```        | [[05.02_Multiplicacion_y_Division]] ([../05_Operaciones_Aritmeticas/05.02_Multiplicacion_y_Division/Apuntes/05.02_Multiplicacion_y_Division.md](../05_Operaciones_Aritmeticas/05.02_Multiplicacion_y_Division/Apuntes/05.02_Multiplicacion_y_Division.md)) |
| IMUL      | src       | Multiplica con signo      | 3-5             | `F7 /5`          | C, O             | ```asm<br>imul rbx```       | [[05.02_Multiplicacion_y_Division]] ([../05_Operaciones_Aritmeticas/05.02_Multiplicacion_y_Division/Apuntes/05.02_Multiplicacion_y_Division.md](../05_Operaciones_Aritmeticas/05.02_Multiplicacion_y_Division/Apuntes/05.02_Multiplicacion_y_Division.md)) |

> [!TIP]  
> - **MUL/DIV:** Usan RAX/RDX implícitamente. Cuidado con divisiones por cero.  
> - **Banderas:** Clave para saltos condicionales. Ver [[10.01_Comparaciones_CMP_TEST]] ([../10_Saltos_y_Control_de_Flujo/10.01_Comparaciones_CMP_TEST/Apuntes/10.01_Comparaciones_CMP_TEST.md](../10_Saltos_y_Control_de_Flujo/10.01_Comparaciones_CMP_TEST/Apuntes/10.01_Comparaciones_CMP_TEST.md)).

---

## Lógicas y Bits

| Mnemónico | Operandos   | Descripción            | Ciclos (Aprox.) | Opcode (Ejemplo) | Banderas | Ejemplo                     | Submódulo                                                           |
|-----------|-------------|------------------------|-----------------|------------------|----------|-----------------------------|---------------------------------------------------------------------|
| AND       | dst, src    | AND lógico             | 1-3             | `21 /r`          | S, Z, P  | ```asm<br>and rax, 0xFF```  | [[15.01_AND_OR_XOR_NOT]] ([../15_Logica_y_Manipulacion_de_Bits/15.01_AND_OR_XOR_NOT/Apuntes/15.01_AND_OR_XOR_NOT.md](../15_Logica_y_Manipulacion_de_Bits/15.01_AND_OR_XOR_NOT/Apuntes/15.01_AND_OR_XOR_NOT.md)) |
| OR        | dst, src    | OR lógico              | 1-3             | `09 /r`          | S, Z, P  | ```asm<br>or rbx, rcx```    | [[15.01_AND_OR_XOR_NOT]] ([../15_Logica_y_Manipulacion_de_Bits/15.01_AND_OR_XOR_NOT/Apuntes/15.01_AND_OR_XOR_NOT.md](../15_Logica_y_Manipulacion_de_Bits/15.01_AND_OR_XOR_NOT/Apuntes/15.01_AND_OR_XOR_NOT.md)) |
| XOR       | dst, src    | XOR lógico             | 1-3             | `31 /r`          | S, Z, P  | ```asm<br>xor rax, rax```   | [[15.01_AND_OR_XOR_NOT]] ([../15_Logica_y_Manipulacion_de_Bits/15.01_AND_OR_XOR_NOT/Apuntes/15.01_AND_OR_XOR_NOT.md](../15_Logica_y_Manipulacion_de_Bits/15.01_AND_OR_XOR_NOT/Apuntes/15.01_AND_OR_XOR_NOT.md)) |
| SHL       | dst, count  | Desplaza izquierda     | 1-3             | `D3 /4`          | C, S, Z, P | ```asm<br>shl rax, 2```   | [[15.02_Desplazamientos_SHL_SHR]] ([../15_Logica_y_Manipulacion_de_Bits/15.02_Desplazamientos_SHL_SHR/Apuntes/15.02_Desplazamientos_SHL_SHR.md](../15_Logica_y_Manipulacion_de_Bits/15.02_Desplazamientos_SHL_SHR/Apuntes/15.02_Desplazamientos_SHL_SHR.md)) |
| SHR       | dst, count  | Desplaza derecha       | 1-3             | `D3 /5`          | C, S, Z, P | ```asm<br>shr rbx, 1```   | [[15.02_Desplazamientos_SHL_SHR]] ([../15_Logica_y_Manipulacion_de_Bits/15.02_Desplazamientos_SHL_SHR/Apuntes/15.02_Desplazamientos_SHL_SHR.md](../15_Logica_y_Manipulacion_de_Bits/15.02_Desplazamientos_SHL_SHR/Apuntes/15.02_Desplazamientos_SHL_SHR.md)) |
| ROL       | dst, count  | Rota izquierda         | 1-3             | `D3 /0`          | C        | ```asm<br>rol rax, 4```     | [[15.03_Rotaciones_ROL_ROR]] ([../15_Logica_y_Manipulacion_de_Bits/15.03_Rotaciones_ROL_ROR/Apuntes/15.03_Rotaciones_ROL_ROR.md](../15_Logica_y_Manipulacion_de_Bits/15.03_Rotaciones_ROL_ROR/Apuntes/15.03_Rotaciones_ROL_ROR.md)) |
| ROR       | dst, count  | Rota derecha           | 1-3             | `D3 /1`          | C        | ```asm<br>ror rbx, 3```     | [[15.03_Rotaciones_ROL_ROR]] ([../15_Logica_y_Manipulacion_de_Bits/15.03_Rotaciones_ROL_ROR/Apuntes/15.03_Rotaciones_ROL_ROR.md](../15_Logica_y_Manipulacion_de_Bits/15.03_Rotaciones_ROL_ROR/Apuntes/15.03_Rotaciones_ROL_ROR.md)) |

> [!TIP]  
> - **XOR rax, rax:** Método eficiente para limpiar registros, ideal en shellcode.  
> - **SHL/SHR:** Útil en ofuscación. Ver [[75.02_Ofuscacion_Basica]] ([../75_Optimizacion_y_Ofuscacion/75.02_Ofuscacion_Basica/Apuntes/75.02_Ofuscacion_Basica.md](../75_Optimizacion_y_Ofuscacion/75.02_Ofuscacion_Basica/Apuntes/75.02_Ofuscacion_Basica.md)).

---

## Control de Flujo

| Mnemónico | Operandos | Descripción               | Ciclos (Aprox.) | Opcode (Ejemplo) | Banderas         | Ejemplo                   | Submódulo                                                           |
|-----------|-----------|---------------------------|-----------------|------------------|------------------|---------------------------|---------------------------------------------------------------------|
| CMP       | op1, op2  | Compara restando          | 1-2             | `39 /r`          | C, O, S, Z, A, P | ```asm<br>cmp rax, rbx``` | [[10.01_Comparaciones_CMP_TEST]] ([../10_Saltos_y_Control_de_Flujo/10.01_Comparaciones_CMP_TEST/Apuntes/10.01_Comparaciones_CMP_TEST.md](../10_Saltos_y_Control_de_Flujo/10.01_Comparaciones_CMP_TEST/Apuntes/10.01_Comparaciones_CMP_TEST.md)) |
| TEST      | op1, op2  | AND lógico sin guardar    | 1-2             | `85 /r`          | S, Z, P          | ```asm<br>test rax, rax``` | [[10.01_Comparaciones_CMP_TEST]] ([../10_Saltos_y_Control_de_Flujo/10.01_Comparaciones_CMP_TEST/Apuntes/10.01_Comparaciones_CMP_TEST.md](../10_Saltos_y_Control_de_Flujo/10.01_Comparaciones_CMP_TEST/Apuntes/10.01_Comparaciones_CMP_TEST.md)) |
| JMP       | target    | Salto incondicional       | 1-3             | `E9 cd`          | Ninguna          | ```asm<br>jmp label```    | [[10.02_Jump_Incondicional]] ([../10_Saltos_y_Control_de_Flujo/10.02_Jump_Incondicional/Apuntes/10.02_Jump_Incondicional.md](../10_Saltos_y_Control_de_Flujo/10.02_Jump_Incondicional/Apuntes/10.02_Jump_Incondicional.md)) |
| JE        | target    | Salto si igual            | 1-3             | `74 cb`          | Z                | ```asm<br>je label```     | [[10.03_Jumps_Condicionales]] ([../10_Saltos_y_Control_de_Flujo/10.03_Jumps_Condicionales/Apuntes/10.03_Jumps_Condicionales.md](../10_Saltos_y_Control_de_Flujo/10.03_Jumps_Condicionales/Apuntes/10.03_Jumps_Condicionales.md)) |
| JNE       | target    | Salto si no igual         | 1-3             | `75 cb`          | Z                | ```asm<br>jne label```    | [[10.03_Jumps_Condicionales]] ([../10_Saltos_y_Control_de_Flujo/10.03_Jumps_Condicionales/Apuntes/10.03_Jumps_Condicionales.md](../10_Saltos_y_Control_de_Flujo/10.03_Jumps_Condicionales/Apuntes/10.03_Jumps_Condicionales.md)) |
| JL        | target    | Salto si menor            | 1-3             | `7C cb`          | S, O             | ```asm<br>jl label```     | [[10.03_Jumps_Condicionales]] ([../10_Saltos_y_Control_de_Flujo/10.03_Jumps_Condicionales/Apuntes/10.03_Jumps_Condicionales.md](../10_Saltos_y_Control_de_Flujo/10.03_Jumps_Condicionales/Apuntes/10.03_Jumps_Condicionales.md)) |
| JG        | target    | Salto si mayor            | 1-3             | `7F cb`          | S, O, Z          | ```asm<br>jg label```     | [[10.03_Jumps_Condicionales]] ([../10_Saltos_y_Control_de_Flujo/10.03_Jumps_Condicionales/Apuntes/10.03_Jumps_Condicionales.md](../10_Saltos_y_Control_de_Flujo/10.03_Jumps_Condicionales/Apuntes/10.03_Jumps_Condicionales.md)) |
| LOOP      | target    | Bucle con ECX             | 5-6             | `E2 cb`          | Ninguna          | ```asm<br>loop start```   | [[10.04_Bucles_Simples]] ([../10_Saltos_y_Control_de_Flujo/10.04_Bucles_Simples/Apuntes/10.04_Bucles_Simples.md](../10_Saltos_y_Control_de_Flujo/10.04_Bucles_Simples/Apuntes/10.04_Bucles_Simples.md)) |

> [!TIP]  
> - **TEST:** Más eficiente que CMP para verificar cero.  
> - **LOOP:** Menos común en shellcode; usa JMP con contador manual. Ver [[10.05_Condiciones_Anidadas]] ([../10_Saltos_y_Control_de_Flujo/10.05_Condiciones_Anidadas/Apuntes/10.05_Condiciones_Anidadas.md](../10_Saltos_y_Control_de_Flujo/10.05_Condiciones_Anidadas/Apuntes/10.05_Condiciones_Anidadas.md)).

---

## Stack y Funciones

| Mnemónico | Operandos  | Descripción          | Ciclos (Aprox.) | Opcode (Ejemplo) | Banderas | Ejemplo                    | Submódulo                                                           |
|-----------|------------|----------------------|-----------------|------------------|----------|----------------------------|---------------------------------------------------------------------|
| PUSH      | src        | Empuja a stack       | 1-3             | `50 +r`          | Ninguna  | ```asm<br>push rax```      | [[20.01_PUSH_y_POP]] ([../20_Stack_y_Funciones/20.01_PUSH_y_POP/Apuntes/20.01_PUSH_y_POP.md](../20_Stack_y_Funciones/20.01_PUSH_y_POP/Apuntes/20.01_PUSH_y_POP.md)) |
| POP       | dst        | Saca del stack       | 1-3             | `58 +r`          | Ninguna  | ```asm<br>pop rbx```       | [[20.01_PUSH_y_POP]] ([../20_Stack_y_Funciones/20.01_PUSH_y_POP/Apuntes/20.01_PUSH_y_POP.md](../20_Stack_y_Funciones/20.01_PUSH_y_POP/Apuntes/20.01_PUSH_y_POP.md)) |
| CALL      | target     | Llama función        | 3-5             | `E8 cd`          | Ninguna  | ```asm<br>call func```     | [[20.02_CALL_y_RET]] ([../20_Stack_y_Funciones/20.02_CALL_y_RET/Apuntes/20.02_CALL_y_RET.md](../20_Stack_y_Funciones/20.02_CALL_y_RET/Apuntes/20.02_CALL_y_RET.md)) |
| RET       | —          | Retorno de función   | 3-5             | `C3`             | Ninguna  | ```asm<br>ret```           | [[20.02_CALL_y_RET]] ([../20_Stack_y_Funciones/20.02_CALL_y_RET/Apuntes/20.02_CALL_y_RET.md](../20_Stack_y_Funciones/20.02_CALL_y_RET/Apuntes/20.02_CALL_y_RET.md)) |
| ENTER     | imm, imm   | Crea marco de pila   | 10-12           | `C8 iw ib`       | Ninguna  | ```asm<br>enter 0x10, 0``` | [[20.04_Estructura_de_Funciones]] ([../20_Stack_y_Funciones/20.04_Estructura_de_Funciones/Apuntes/20.04_Estructura_de_Funciones.md](../20_Stack_y_Funciones/20.04_Estructura_de_Funciones/Apuntes/20.04_Estructura_de_Funciones.md)) |
| LEAVE     | —          | Libera marco de pila | 3               | `C9`             | Ninguna  | ```asm<br>leave```         | [[20.04_Estructura_de_Funciones]] ([../20_Stack_y_Funciones/20.04_Estructura_de_Funciones/Apuntes/20.04_Estructura_de_Funciones.md](../20_Stack_y_Funciones/20.04_Estructura_de_Funciones/Apuntes/20.04_Estructura_de_Funciones.md)) |

> [!EXAMPLE] Ejemplo de Función  
> ```asm
section .text
global my_func
my_func:
    push rbp
    mov rbp, rsp
    mov rax, [rdi] ; Primer argumento
    add rax, 0x1
    leave
    ret


> [!TIP]  
> - **System V ABI:** Argumentos en RDI, RSI, RDX, RCX, R8, R9. Ver [[20.06_Convenciones_de_Llamada]] ([../20_Stack_y_Funciones/20.06_Convenciones_de_Llamada/Apuntes/20.06_Convenciones_de_Llamada.md](../20_Stack_y_Funciones/20.06_Convenciones_de_Llamada/Apuntes/20.06_Convenciones_de_Llamada.md)).  
> - **PUSH/POP:** Clave en exploits de buffer overflow. Ver [[50.03_Control_de_Flujo]] ([../50_Buffer_Overflow/50.03_Control_de_Flujo/Apuntes/50.03_Control_de_Flujo.md](../50_Buffer_Overflow/50.03_Control_de_Flujo/Apuntes/50.03_Control_de_Flujo.md)).

---

## Segmentos de Memoria

| Mnemónico | Operandos | Descripción               | Ciclos (Aprox.) | Opcode (Ejemplo) | Banderas | Ejemplo                     | Submódulo                                                           |
|-----------|-----------|---------------------------|-----------------|------------------|----------|-----------------------------|---------------------------------------------------------------------|
| MOV       | [addr], src | Escribe en memoria       | 1-3             | `89 /r`          | Ninguna  | ```asm<br>mov [var], rax``` | [[25.04_Acceso_a_Variables]] ([../25_Segmentos_de_Memoria/25.04_Acceso_a_Variables/Apuntes/25.04_Acceso_a_Variables.md](../25_Segmentos_de_Memoria/25.04_Acceso_a_Variables/Apuntes/25.04_Acceso_a_Variables.md)) |
| MOV       | dst, [addr] | Lee de memoria           | 1-3             | `8B /r`          | Ninguna  | ```asm<br>mov rax, [var]``` | [[25.04_Acceso_a_Variables]] ([../25_Segmentos_de_Memoria/25.04_Acceso_a_Variables/Apuntes/25.04_Acceso_a_Variables.md](../25_Segmentos_de_Memoria/25.04_Acceso_a_Variables/Apuntes/25.04_Acceso_a_Variables.md)) |

> [!EXAMPLE] Declaración de Variables 

```asm
section .data
    var db 0x42 ; Byte
section .bss
    buffer resb 64 ; Reserva 64 bytes
section .text
    mov rax, [var]
    mov [buffer], rax 
```


> [!TIP]  
> - Usa `.data` para datos inicializados, `.bss` para no inicializados. Ver [[25.01_Secciones_data_y_bss]] ([../25_Segmentos_de_Memoria/25.01_Secciones_data_y_bss/Apuntes/25.01_Secciones_data_y_bss.md](../25_Segmentos_de_Memoria/25.01_Secciones_data_y_bss/Apuntes/25.01_Secciones_data_y_bss.md)).  
> - Cuidado con accesos a memoria en exploits. Ver [[50.05_Ejemplo_Vulnerable]] ([../50_Buffer_Overflow/50.05_Ejemplo_Vulnerable/Apuntes/50.05_Ejemplo_Vulnerable.md](../50_Buffer_Overflow/50.05_Ejemplo_Vulnerable/Apuntes/50.05_Ejemplo_Vulnerable.md)).

---

## Syscalls

| Mnemónico | Operandos | Descripción           | Ciclos (Aprox.) | Opcode | Banderas | Ejemplo                             | Submódulo                                                           |
|-----------|-----------|-----------------------|-----------------|--------|----------|-------------------------------------|---------------------------------------------------------------------|
| SYSCALL   | —         | Llamada al sistema    | Varía           | `0F 05` | Depende  | ```asm<br>mov rax, 1<br>syscall``` | [[30.01_Syscalls_Write_Read]] ([../30_Entrada_Salida/30.01_Syscalls_Write_Read/Apuntes/30.01_Syscalls_Write_Read.md](../30_Entrada_Salida/30.01_Syscalls_Write_Read/Apuntes/30.01_Syscalls_Write_Read.md)) |

> [!EXAMPLE] Syscall: write  


 ```asm
section .data
    msg db "Hello, World!", 0xA
    len equ $ - msg
section .text
global _start
_start:
    mov rax, 1    ; syscall: write
    mov rdi, 1    ; fd: stdout
    mov rsi, msg  ; buffer
    mov rdx, len  ; length
    syscall
    mov rax, 60   ; syscall: exit
    xor rdi, rdi  ; status: 0
    syscall
```


> [!TIP]  
> - **Syscalls Comunes:** write (1), read (0), exit (60), execve (59). Ver [[65.02_Execve_Avanzado]] ([../65_Avanzado_Syscalls/65.02_Execve_Avanzado/Apuntes/65.02_Execve_Avanzado.md](../65_Avanzado_Syscalls/65.02_Execve_Avanzado/Apuntes/65.02_Execve_Avanzado.md)).  
> - Prueba en Docker/QEMU para evitar daños. Ver [[100.02_Inyeccion_en_Stack]] ([../100_Shellcode_Injection/100.02_Inyeccion_en_Stack/Apuntes/100.02_Inyeccion_en_Stack.md](../100_Shellcode_Injection/100.02_Inyeccion_en_Stack/Apuntes/100.02_Inyeccion_en_Stack.md)).

---

## Strings

| Mnemónico | Operandos | Descripción               | Ciclos (Aprox.) | Opcode | Banderas         | Ejemplo                             | Submódulo                                                           |
|-----------|-----------|---------------------------|-----------------|--------|------------------|-------------------------------------|---------------------------------------------------------------------|
| MOVS      | —         | Mueve string (DS:SI a ES:DI) | 7-10           | `A4`   | Ninguna          | ```asm<br>movs byte ptr [rdi], [rsi]``` | [[35.03_Manipulacion_de_Strings]] ([../35_Strings_y_Estructuras/35.03_Manipulacion_de_Strings/Apuntes/35.03_Manipulacion_de_Strings.md](../35_Strings_y_Estructuras/35.03_Manipulacion_de_Strings/Apuntes/35.03_Manipulacion_de_Strings.md)) |
| CMPS      | —         | Compara string            | 10-12           | `A6`   | C, O, S, Z, A, P | ```asm<br>cmps byte ptr [rsi], [rdi]``` | [[35.02_Comparacion_y_Busqueda]] ([../35_Strings_y_Estructuras/35.02_Comparacion_y_Busqueda/Apuntes/35.02_Comparacion_y_Busqueda.md](../35_Strings_y_Estructuras/35.02_Comparacion_y_Busqueda/Apuntes/35.02_Comparacion_y_Busqueda.md)) |
| STOS      | —         | Almacena string en ES:DI  | 4-5             | `AA`   | Ninguna          | ```asm<br>stos byte ptr [rdi]``` | [[35.03_Manipulacion_de_Strings]] ([../35_Strings_y_Estructuras/35.03_Manipulacion_de_Strings/Apuntes/35.03_Manipulacion_de_Strings.md](../35_Strings_y_Estructuras/35.03_Manipulacion_de_Strings/Apuntes/35.03_Manipulacion_de_Strings.md)) |
| SCAS      | —         | Escanea string en ES:DI   | 4-5             | `AE`   | C, O, S, Z, A, P | ```asm<br>scas byte ptr [rdi]``` | [[35.02_Comparacion_y_Busqueda]] ([../35_Strings_y_Estructuras/35.02_Comparacion_y_Busqueda/Apuntes/35.02_Comparacion_y_Busqueda.md](../35_Strings_y_Estructuras/35.02_Comparacion_y_Busqueda/Apuntes/35.02_Comparacion_y_Busqueda.md)) |

> [!TIP]  
> - Usa REP con MOVS/STOS para operaciones masivas. Ver [[35.03_Manipulacion_de_Strings]] ([../35_Strings_y_Estructuras/35.03_Manipulacion_de_Strings/Apuntes/35.03_Manipulacion_de_Strings.md](../35_Strings_y_Estructuras/35.03_Manipulacion_de_Strings/Apuntes/35.03_Manipulacion_de_Strings.md)).  
> - Ideal para shellcode que manipula strings. Ver [[80.04_Shellcode_sin_Null_Bytes]] ([../80_Shellcode/80.04_Shellcode_sin_Null_Bytes/Apuntes/80.04_Shellcode_sin_Null_Bytes.md](../80_Shellcode/80.04_Shellcode_sin_Null_Bytes/Apuntes/80.04_Shellcode_sin_Null_Bytes.md)).

---

## Hacking Avanzado

| Mnemónico | Operandos | Descripción               | Ciclos (Aprox.) | Opcode | Banderas         | Ejemplo                             | Submódulo                                                           |
|-----------|-----------|---------------------------|-----------------|--------|------------------|-------------------------------------|---------------------------------------------------------------------|
| INT       | imm       | Interrupción software (legacy) | Varía          | `CD ib` | Depende          | ```asm<br>int 0x80```              | [[30.01_Syscalls_Write_Read]] ([../30_Entrada_Salida/30.01_Syscalls_Write_Read/Apuntes/30.01_Syscalls_Write_Read.md](../30_Entrada_Salida/30.01_Syscalls_Write_Read/Apuntes/30.01_Syscalls_Write_Read.md)) |
| NOP       | —         | No operación              | 1               | `90`    | Ninguna          | ```asm<br>nop```                   | [[75.02_Ofuscacion_Basica]] ([../75_Optimizacion_y_Ofuscacion/75.02_Ofuscacion_Basica/Apuntes/75.02_Ofuscacion_Basica.md](../75_Optimizacion_y_Ofuscacion/75.02_Ofuscacion_Basica/Apuntes/75.02_Ofuscacion_Basica.md)) |
| SYSCALL   | —         | Llamada al sistema (moderno) | Varía         | `0F 05` | Depende          | ```asm<br>mov rax, 59<br>syscall``` | [[65.01_Syscalls_Complejas]] ([../65_Avanzado_Syscalls/65.01_Syscalls_Complejas/Apuntes/65.01_Syscalls_Complejas.md](../65_Avanzado_Syscalls/65.01_Syscalls_Complejas/Apuntes/65.01_Syscalls_Complejas.md)) |

> [!EXAMPLE] Shellcode: execve /bin/sh  
> 

```asm
section .text
global _start
_start:
    xor rax, rax
    mov al, 59        ; syscall: execve
    lea rdi, [rel bin_sh]
    xor rsi, rsi      ; argv: NULL
    xor rdx, rdx      ; envp: NULL
    syscall
bin_sh:
    db "/bin/sh", 0
```

> [!TIP]  
> - **NOP:** Útil para alinear código o crear code caves. Ver [[90.04_Code_Caves]] ([../90_Inyeccion_de_Codigo/90.04_Code_Caves/Apuntes/90.04_Code_Caves.md](../90_Inyeccion_de_Codigo/90.04_Code_Caves/Apuntes/90.04_Code_Caves.md)).  
> - **Shellcode:** Evita null bytes con XOR/LEA. Ver [[80.04_Shellcode_sin_Null_Bytes]] ([../80_Shellcode/80.04_Shellcode_sin_Null_Bytes/Apuntes/80.04_Shellcode_sin_Null_Bytes.md](../80_Shellcode/80.04_Shellcode_sin_Null_Bytes/Apuntes/80.04_Shellcode_sin_Null_Bytes.md)).  
> - Usa QEMU para pruebas (`qemu-x86_64 binary`). Ver [[100.02_Inyeccion_en_Stack]] ([../100_Shellcode_Injection/100.02_Inyeccion_en_Stack/Apuntes/100.02_Inyeccion_en_Stack.md](../100_Shellcode_Injection/100.02_Inyeccion_en_Stack/Apuntes/100.02_Inyeccion_en_Stack.md)).

---

## Banderas Afectadas

| Bandera | Descripción              | Instrucciones Principales         | Submódulo                                                           |
|---------|--------------------------|----------------------------------|---------------------------------------------------------------------|
| C (Carry) | Acarreo o préstamo      | ADD, SUB, CMP, SHL, SHR, CMPS, SCAS | [[05.04_Flags_Aritmeticos]] ([../05_Operaciones_Aritmeticas/05.04_Flags_Aritmeticos/Apuntes/05.04_Flags_Aritmeticos.md](../05_Operaciones_Aritmeticas/05.04_Flags_Aritmeticos/Apuntes/05.04_Flags_Aritmeticos.md)) |
| O (Overflow) | Desbordamiento aritmético | ADD, SUB, MUL, DIV, CMPS, SCAS | [[05.04_Flags_Aritmeticos]] ([../05_Operaciones_Aritmeticas/05.04_Flags_Aritmeticos/Apuntes/05.04_Flags_Aritmeticos.md](../05_Operaciones_Aritmeticas/05.04_Flags_Aritmeticos/Apuntes/05.04_Flags_Aritmeticos.md)) |
| S (Sign) | Signo del resultado      | ADD, SUB, AND, OR, XOR, CMPS, SCAS | [[05.04_Flags_Aritmeticos]] ([../05_Operaciones_Aritmeticas/05.04_Flags_Aritmeticos/Apuntes/05.04_Flags_Aritmeticos.md](../05_Operaciones_Aritmeticas/05.04_Flags_Aritmeticos/Apuntes/05.04_Flags_Aritmeticos.md)) |
| Z (Zero) | Resultado es cero        | ADD, SUB, AND, OR, XOR, CMP, TEST, CMPS, SCAS | [[05.04_Flags_Aritmeticos]] ([../05_Operaciones_Aritmeticas/05.04_Flags_Aritmeticos/Apuntes/05.04_Flags_Aritmeticos.md](../05_Operaciones_Aritmeticas/05.04_Flags_Aritmeticos/Apuntes/05.04_Flags_Aritmeticos.md)) |
| A (Aux. Carry) | Acarreo en nibble bajo | ADD, SUB, CMPS, SCAS            | [[05.04_Flags_Aritmeticos]] ([../05_Operaciones_Aritmeticas/05.04_Flags_Aritmeticos/Apuntes/05.04_Flags_Aritmeticos.md](../05_Operaciones_Aritmeticas/05.04_Flags_Aritmeticos/Apuntes/05.04_Flags_Aritmeticos.md)) |
| P (Parity) | Paridad del resultado   | ADD, SUB, AND, OR, XOR, CMPS, SCAS | [[05.04_Flags_Aritmeticos]] ([../05_Operaciones_Aritmeticas/05.04_Flags_Aritmeticos/Apuntes/05.04_Flags_Aritmeticos.md](../05_Operaciones_Aritmeticas/05.04_Flags_Aritmeticos/Apuntes/05.04_Flags_Aritmeticos.md)) |

> [!TIP]  
> - Visualiza banderas en GDB: `info registers`. Ver [[40.03_Visualizar_Registros_y_Stack]] ([../40_Debugging_GDB_Objdump/40.03_Visualizar_Registros_y_Stack/Apuntes/40.03_Visualizar_Registros_y_Stack.md](../40_Debugging_GDB_Objdump/40.03_Visualizar_Registros_y_Stack/Apuntes/40.03_Visualizar_Registros_y_Stack.md)).  
> - Usa en saltos condicionales: `je` (Z=1), `jl` (S≠O). Ver [[10.03_Jumps_Condicionales]] ([../10_Saltos_y_Control_de_Flujo/10.03_Jumps_Condicionales/Apuntes/10.03_Jumps_Condicionales.md](../10_Saltos_y_Control_de_Flujo/10.03_Jumps_Condicionales/Apuntes/10.03_Jumps_Condicionales.md)).

> [!EXCALIDRAW] Diagrama de Banderas  
> Crea un Excalidraw en Obsidian para visualizar el registro RFLAGS (CF, OF, SF, ZF, AF, PF). Ver [[05.04_Flags_Aritmeticos]] ([../05_Operaciones_Aritmeticas/05.04_Flags_Aritmeticos/Apuntes/05.04_Flags_Aritmeticos.md](../05_Operaciones_Aritmeticas/05.04_Flags_Aritmeticos/Apuntes/05.04_Flags_Aritmeticos.md)).

---

## Mapa de Registros

| Registro | Uso Principal              | Convención System V ABI | Submódulo                                                           |
|----------|----------------------------|-------------------------|---------------------------------------------------------------------|
| RAX      | Acumulador, retorno        | Retorno de funciones    | [[00.03_Registros_Generales]] ([../00_MOV_y_Registros_Basicos/00.03_Registros_Generales/Apuntes/00.03_Registros_Generales.md](../00_MOV_y_Registros_Basicos/00.03_Registros_Generales/Apuntes/00.03_Registros_Generales.md)) |
| RDI      | Argumento 1                | Primer argumento        | [[20.06_Convenciones_de_Llamada]] ([../20_Stack_y_Funciones/20.06_Convenciones_de_Llamada/Apuntes/20.06_Convenciones_de_Llamada.md](../20_Stack_y_Funciones/20.06_Convenciones_de_Llamada/Apuntes/20.06_Convenciones_de_Llamada.md)) |
| RSI      | Argumento 2                | Segundo argumento       | [[20.06_Convenciones_de_Llamada]] ([../20_Stack_y_Funciones/20.06_Convenciones_de_Llamada/Apuntes/20.06_Convenciones_de_Llamada.md](../20_Stack_y_Funciones/20.06_Convenciones_de_Llamada/Apuntes/20.06_Convenciones_de_Llamada.md)) |
| RDX      | Argumento 3                | Tercer argumento        | [[20.06_Convenciones_de_Llamada]] ([../20_Stack_y_Funciones/20.06_Convenciones_de_Llamada/Apuntes/20.06_Convenciones_de_Llamada.md](../20_Stack_y_Funciones/20.06_Convenciones_de_Llamada/Apuntes/20.06_Convenciones_de_Llamada.md)) |
| RCX      | Argumento 4                | Cuarto argumento        | [[20.06_Convenciones_de_Llamada]] ([../20_Stack_y_Funciones/20.06_Convenciones_de_Llamada/Apuntes/20.06_Convenciones_de_Llamada.md](../20_Stack_y_Funciones/20.06_Convenciones_de_Llamada/Apuntes/20.06_Convenciones_de_Llamada.md)) |
| R8       | Argumento 5                | Quinto argumento        | [[20.06_Convenciones_de_Llamada]] ([../20_Stack_y_Funciones/20.06_Convenciones_de_Llamada/Apuntes/20.06_Convenciones_de_Llamada.md](../20_Stack_y_Funciones/20.06_Convenciones_de_Llamada/Apuntes/20.06_Convenciones_de_Llamada.md)) |
| R9       | Argumento 6                | Sexto argumento         | [[20.06_Convenciones_de_Llamada]] ([../20_Stack_y_Funciones/20.06_Convenciones_de_Llamada/Apuntes/20.06_Convenciones_de_Llamada.md](../20_Stack_y_Funciones/20.06_Convenciones_de_Llamada/Apuntes/20.06_Convenciones_de_Llamada.md)) |
| RSP      | Puntero de pila            | Stack pointer           | [[20.03_RBP_y_RSP]] ([../20_Stack_y_Funciones/20.03_RBP_y_RSP/Apuntes/20.03_RBP_y_RSP.md](../20_Stack_y_Funciones/20.03_RBP_y_RSP/Apuntes/20.03_RBP_y_RSP.md)) |
| RBP      | Puntero de marco           | Base pointer            | [[20.03_RBP_y_RSP]] ([../20_Stack_y_Funciones/20.03_RBP_y_RSP/Apuntes/20.03_RBP_y_RSP.md](../20_Stack_y_Funciones/20.03_RBP_y_RSP/Apuntes/20.03_RBP_y_RSP.md)) |
| RIP      | Puntero de instrucción     | Siguiente instrucción   | [[50.03_Control_de_Flujo]] ([../50_Buffer_Overflow/50.03_Control_de_Flujo/Apuntes/50.03_Control_de_Flujo.md](../50_Buffer_Overflow/50.03_Control_de_Flujo/Apuntes/50.03_Control_de_Flujo.md)) |

> [!TIP]  
> - **System V ABI:** Argumentos adicionales en stack. Ver [[20.06_Convenciones_de_Llamada]] ([../20_Stack_y_Funciones/20.06_Convenciones_de_Llamada/Apuntes/20.06_Convenciones_de_Llamada.md](../20_Stack_y_Funciones/20.06_Convenciones_de_Llamada/Apuntes/20.06_Convenciones_de_Llamada.md)).  
> - **RIP:** Clave en exploits para controlar el flujo. Ver [[50.03_Control_de_Flujo]] ([../50_Buffer_Overflow/50.03_Control_de_Flujo/Apuntes/50.03_Control_de_Flujo.md](../50_Buffer_Overflow/50.03_Control_de_Flujo/Apuntes/50.03_Control_de_Flujo.md)).

> [!EXCALIDRAW] Diagrama de Stack  
> Crea un Excalidraw para mostrar RSP, RBP, argumentos, retorno, y variables locales. Ver [[20.04_Estructura_de_Funciones]] ([../20_Stack_y_Funciones/20.04_Estructura_de_Funciones/Apuntes/20.04_Estructura_de_Funciones.md](../20_Stack_y_Funciones/20.04_Estructura_de_Funciones/Apuntes/20.04_Estructura_de_Funciones.md)).

---

## Dataview Queries

> [!NOTE]  
> Usa el plugin Dataview en Obsidian para filtrar instrucciones, niveles, o submódulos. En GitHub, usa los enlaces relativos.

```dataview
TABLE title, difficulty, tags, tools
FROM "03_ASM"
WHERE contains(tags, "nasm")
SORT level ASC
```

```dataview
TABLE file.link AS "Submódulo", difficulty
FROM "03_ASM"
WHERE contains(difficulty, "avanzado")
```

> [!TIP]  
> Lista submódulos de un nivel:  
> ```dataview
> TABLE file.link AS "Submódulo"
> FROM "03_ASM/00_MOV_y_Registros_Basicos"
> ```

---