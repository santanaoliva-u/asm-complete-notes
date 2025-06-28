#!/bin/bash

# Script para generar un vault de Obsidian para aprender ASM (x86-64, NASM) en Arch Linux (2025)

# Ruta raíz del vault
RAIZ="$HOME/Documents/OBSIDIAN/Programacion/01_Estudio/03_ASM"
LENGUAJE="ASM" # Extensión por defecto: .asm (configurable)

# Definir la estructura directamente en el script
# Función para crear archivo .md de submódulo
#
#
#
declare -A ESTRUCTURA=(
  ["00_MOV_y_Registros_Basicos"]="principiante|Introducción a registros y MOV|\
00.01_Introduccion_al_ASM:principiante:Conceptos básicos de ASM y NASM:mov:; MOV básico\nmov rax, 42|\
00.02_Estructura_de_un_Archivo_ASM:principiante:Secciones .data, .bss, .text::; Secciones\nsection .data\n    msg db 'Hola', 0\nsection .text\n    global _start\n_start:|\
00.03_Registros_Generales:principiante:Registros de propósito general (RAX, RBX, RCX, etc.)::; Uso de RAX\nmov rax, 0|\
00.04_Registros_Especificos:principiante:Registros de propósito específico (RDI, RSI, RIP)::; Uso de RDI\nmov rdi, 1|\
00.05_Instruccion_MOV_Sintaxis:principiante:Sintaxis y formatos de MOV:mov:; MOV sintaxis\nmov eax, ebx|\
00.06_MOV_entre_Registros:principiante:Transferencia entre registros:mov:; Transferencia\nmov rcx, rax|\
00.07_MOV_con_Valores_Inmediatos:principiante:Valores inmediatos en MOV:mov:; Valor inmediato\nmov rax, 0x10|\
00.08_MOV_con_Memoria_Directa:principiante:Acceso directo a memoria:mov:; Memoria directa\nmov rax, [0x1000]|\
00.09_MOV_con_Punteros:principiante:Dirección indirecta con punteros:mov:; Puntero\nmov rax, [rbx]|\
00.10_MOV_y_Segmentacion:principiante:Segmentos de memoria (DS, CS):mov:; Segmento\nmov rax, [ds:0x1000]|\
00.11_Ejercicios_Practicos:principiante:Ejercicios combinados de MOV:mov:; Ejercicio\nmov rax, 42\nmov rbx, rax\nmov [rcx], rax"

  ["05_Operaciones_Aritmeticas"]="intermedio|Operaciones aritméticas en ASM|\
05.01_Suma_Resta_INC_DEC:principiante:Suma, resta, incremento, decremento:add,sub,inc,dec:; Suma\nadd rax, 5\n; Decremento\ndec rbx|\
05.02_Multiplicacion_y_Division:intermedio:MUL, IMUL, DIV, IDIV:mul,imul,div,idiv:; Multiplicación\nmov rax, 10\nmul rbx|\
05.03_Negacion_y_Cambio_de_Signo:intermedio:NOT y NEG para operaciones lógicas:not,neg:; Negación\nneg rax|\
05.04_Flags_Aritmeticos:intermedio:Flags afectados por operaciones (ZF, CF, OF)::; Flags\nadd rax, rbx\n; Verifica ZF con je|\
05.05_Registros_Distintos_Tamanos:intermedio:Manejo de registros de diferentes tamaños:mov:; Tamaños\nmov ax, bx|\
05.06_Ejercicios_Aritmeticos:intermedio:Ejercicios combinados de operaciones:add,sub,mul:; Ejercicio\nmov rax, 10\nadd rax, 5\nmul rbx"

  ["10_Saltos_y_Control_de_Flujo"]="intermedio|Control de flujo en ASM|\
10.01_Comparaciones_CMP_TEST:intermedio:Instrucciones CMP y TEST:cmp,test:; Comparación\ncmp rax, rbx\n; TEST\ntest rax, 1|\
10.02_Jump_Incondicional:intermedio:Uso de JMP para saltos incondicionales:jmp:; Salto\njmp etiqueta\netiqueta:|\
10.03_Jumps_Condicionales:intermedio:Saltos condicionales JE, JNE, JL, JG:je,jne,jl,jg:; Salto condicional\ncmp rax, rbx\nje etiqueta|\
10.04_Bucles_Simples:intermedio:Bucles con LOOP y ECX:loop:; Bucle\nmov ecx, 5\nloop etiqueta\netiqueta:|\
10.05_Condiciones_Anidadas:intermedio:Condiciones anidadas con saltos:cmp,je,jne:; Condición anidada\ncmp rax, 0\nje fin\ncmp rbx, 0\njne ciclo\nfin:|\
10.06_Ejercicios_de_Control:intermedio:Ejercicios prácticos de control de flujo:cmp,jmp,loop:; Ejercicio\nmov rax, 0\ncmp rax, 0\nje fin\nloop ciclo\nfin:"

  ["15_Logica_y_Manipulacion_de_Bits"]="intermedio|Manipulación de bits en ASM|\
15.01_AND_OR_XOR_NOT:intermedio:Operaciones lógicas AND, OR, XOR, NOT:and,or,xor,not:; AND\nand rax, rbx|\
15.02_Desplazamientos_SHL_SHR:intermedio:Desplazamientos SHL, SHR, SAR, SAL:shl,shr,sar,sal:; Desplazamiento\nshl rax, 2|\
15.03_Rotaciones_ROL_ROR:intermedio:Rotaciones ROL, ROR:rol,ror:; Rotación\nrol rax, 1|\
15.04_Mascaras:intermedio:Máscaras binarias para filtrar bits:and:; Máscara\nand rax, 0xFF|\
15.05_Aplicaciones_Practicas:intermedio:Paridad, flags y aplicaciones:test:; Paridad\ntest rax, 1\njz par|\
15.06_Ejercicios_de_Bits:intermedio:Ejercicios combinados de operaciones de bits:and,xor,shl:; Ejercicio\nand rax, 0xFF\nshl rbx, 2"

  ["20_Stack_y_Funciones"]="intermedio|Uso del stack y funciones en ASM|\
20.01_PUSH_y_POP:intermedio:Uso del stack con PUSH y POP:push,pop:; Stack\npush rax\npop rbx|\
20.02_CALL_y_RET:intermedio:Llamadas a funciones con CALL y RET:call,ret:; Llamada\ncall funcion\nfuncion:\nret|\
20.03_RBP_y_RSP:intermedio:Base y stack pointer (RBP, RSP)::; Stack pointer\nmov rsp, rbp|\
20.04_Estructura_de_Funciones:intermedio:Estructura estándar de funciones:push,pop,call,ret:; Función\npush rbp\nmov rbp, rsp\npop rbp\nret|\
20.05_Funciones_con_Argumentos:intermedio:Pasar argumentos a funciones:mov:; Argumentos\nmov rdi, 42\ncall funcion|\
20.06_Convenciones_de_Llamada:intermedio:Convenciones de llamada (System V ABI):mov:; System V ABI\nmov rdi, rax\nmov rsi, rbx|\
20.07_Ejercicios_de_Funciones:intermedio:Ejercicios prácticos de stack y funciones:push,pop,call:; Ejercicio\npush rbp\nmov rbp, rsp\nmov rdi, 10\ncall suma\npop rbp"

  ["25_Segmentos_de_Memoria"]="intermedio|Manejo de memoria y datos en ASM|\
25.01_Secciones_data_y_bss:intermedio:Secciones .data y .bss::; Data\nsection .data\n    var db 0|\
25.02_Declaracion_de_Variables:intermedio:Declaraciones db, dw, dd, dq::; Variable\nsection .data\n    num dq 0x1234|\
25.03_Reserva_de_Memoria:intermedio:Reserva con resb, resw, resd::; Reserva\nsection .bss\n    buffer resb 64|\
25.04_Acceso_a_Variables:intermedio:Lectura y escritura de variables:mov:; Acceso\nmov rax, [var]|\
25.05_Arreglos_y_Estructuras:intermedio:Definición de arreglos y estructuras:mov:; Arreglo\nsection .data\n    arr db 1,2,3\nmov rax, [arr]|\
25.06_Ejercicios_de_Memoria:intermedio:Ejercicios prácticos de memoria:mov:; Ejercicio\nsection .data\n    var dq 42\nmov rax, [var]\nmov [var], rbx"

  ["30_Entrada_Salida"]="intermedio|Entrada y salida en ASM|\
30.01_Syscalls_Write_Read:intermedio:Syscalls para escritura y lectura:syscall:; Write\nmov rax, 1\nmov rdi, 1\nsyscall|\
30.02_Leer_de_Teclado:intermedio:Lectura desde stdin:syscall:; Read\nmov rax, 0\nmov rdi, 0\nsyscall|\
30.03_Escribir_en_Pantalla:intermedio:Escritura a stdout:syscall:; Print\nsection .data\n    msg db 'Hola', 0\nmov rax, 1\nmov rdi, 1\nmov rsi, msg\nmov rdx, 4\nsyscall|\
30.04_IO_con_Archivos:intermedio:Manejo de archivos con syscalls:syscall:; Open\nmov rax, 2\nmov rdi, fname\nsyscall|\
30.05_Buffer_Overflow_Basico:avanzado:Introducción a desbordamientos de buffer:mov:; Overflow\nmov [rsp], rax|\
30.06_Ejercicios_de_IO:intermedio:Ejercicios prácticos de entrada/salida:syscall:; Ejercicio\nsection .data\n    msg db 'Hola', 0\nmov rax, 1\nmov rdi, 1\nmov rsi, msg\nsyscall"

  ["35_Strings_y_Estructuras"]="intermedio|Manejo de strings y estructuras en ASM|\
35.01_Definicion_de_Strings:intermedio:Definición de strings en .data::; String\nsection .data\n    str db 'Hola', 0|\
35.02_Comparacion_y_Busqueda:intermedio:Comparación y búsqueda en strings:cmp:; Comparar\ncmp byte [rdi], 0|\
35.03_Manipulacion_de_Strings:intermedio:Copiar e invertir strings:mov:; Copiar\nmov al, [rsi]\nmov [rdi], al|\
35.04_Strings_Null_Terminated:intermedio:Strings terminados en null::; Null-terminated\nsection .data\n    str db 'Test', 0|\
35.05_Estructuras_Simples:intermedio:Definición de estructuras en memoria:mov:; Estructura\nsection .data\n    struct dq 0\nmov rax, [struct]|\
35.06_Longitud_de_Strings:intermedio:Cálculo de longitud de strings:cmp:; Longitud\nmov rsi, str\nxor rcx, rcx\nciclo:\ncmp byte [rsi+rcx], 0\nje fin\ninc rcx\njmp ciclo\nfin:|\
35.07_Ejercicios_de_Strings:intermedio:Ejercicios prácticos de strings:mov,cmp:; Ejercicio\nsection .data\n    str db 'Hola', 0\nmov rsi, str\ncmp byte [rsi], 0"

  ["40_Debugging_GDB_Objdump"]="intermedio|Depuración de programas ASM|\
40.01_Compilar_con_Simbolos:intermedio:Compilación con símbolos de depuración::; Compilar\n; nasm -f elf64 -g programa.asm|\
40.02_Uso_de_GDB:intermedio:Breakpoints y comandos básicos de GDB::; GDB\n; break _start\nrun|\
40.03_Visualizar_Registros_y_Stack:intermedio:Visualización de registros y stack::; GDB\n; info registers\nx/8xg $rsp|\
40.04_Desensamblar_con_Objdump:intermedio:Desensamblado con objdump::; Objdump\n; objdump -d programa.o|\
40.05_Ghidra_y_Codigo_Fuente:intermedio:Análisis con Ghidra::; Ghidra\n; Importar binario en Ghidra|\
40.06_Ejercicios_de_Debugging:intermedio:Ejercicios prácticos de depuración::; GDB\n; break main\nstep\ninfo locals"

  ["45_Formato_ELF"]="avanzado|Formato ELF y ejecución de binarios|\
45.01_Secciones_ELF:avanzado:Estructura de binarios ELF::; ELF\nsection .text\nglobal _start|\
45.02_Cabecera_y_Secciones:avanzado:Análisis de cabecera y secciones .text, .data::; Cabecera\nsection .data\n    var db 0|\
45.03_Linking_Estatico_Dinamico:avanzado:Linking estático y dinámico::; Link\n; ld -static programa.o|\
45.04_ELF_con_Syscalls:avanzado:Syscalls en binarios ELF:syscall:; Syscall\nmov rax, 1\nsyscall|\
45.05_Inyeccion_Basica:avanzado:Inyección básica en binarios ELF::; Inyección\nmov [rip], rax|\
45.06_Análisis_con_readelf:avanzado:Análisis de binarios con readelf::; readelf\n; readelf -h programa|\
45.07_Ejercicios_ELF:avanzado:Ejercicios prácticos con binarios ELF::; Ejercicio\n; readelf -S programa.o"

  ["50_Buffer_Overflow"]="avanzado|Técnicas de buffer overflow|\
50.01_Que_es_Buffer_Overflow:avanzado:Conceptos básicos de desbordamiento::; Overflow\nmov [rsp], rax|\
50.02_Condiciones_para_Desbordar:avanzado:Condiciones para un overflow::; Condición\nmov [rsp-8], rax|\
50.03_Control_de_Flujo:avanzado:Controlar EIP/RIP para exploits::; Control\nmov rip, rax|\
50.04_Exploits_sin_Mitigaciones:avanzado:Exploits sin ASLR ni NX::; Exploit\njmp rsp|\
50.05_Ejemplo_Vulnerable:avanzado:Programa vulnerable a overflow::; Vulnerable\nmov [rsp], rax|\
50.06_Ejercicios_de_Overflow:avanzado:Ejercicios prácticos de buffer overflow::; Ejercicio\nsection .data\n    buf resb 16\nmov [buf], rax"

  ["55_Análisis_de_Malware"]="avanzado|Análisis de malware en ASM|\
55.01_Conceptos_de_Malware:avanzado:Introducción al análisis de malware::; Malware\n; Identificar patrones en binario|\
55.02_Desensamblado_Estático:avanzado:Análisis estático con herramientas::; Desensamblado\n; objdump -d malware.o|\
55.03_Análisis_Dinámico:avanzado:Análisis dinámico con GDB::; GDB\n; break _start\nrun|\
55.04_Detección_de_Ofuscación:avanzado:Técnicas de ofuscación en malware::; Ofuscación\n; xor rax, 0xFF|\
55.05_Ejercicios_de_Análisis:avanzado:Ejercicios prácticos de análisis::; Ejercicio\n; Analizar binario con Ghidra"

  ["60_Proteccion_y_Evasion"]="avanzado|Protecciones modernas y técnicas de evasión|\
60.01_Stack_Canaries:avanzado:Protección con stack canaries::; Canary\nmov rax, [fs:0x28]|\
60.02_NX_Bit:avanzado:No eXecute bit y su impacto::; NX\n; Evitar ejecución en stack|\
60.03_ASLR:avanzado:Address Space Layout Randomization::; ASLR\n; Evitar direcciones fijas|\
60.04_Deteccion_de_Protecciones:avanzado:Identificar mitigaciones en binarios::; Detectar\n; readelf -l programa|\
60.05_Evasion_de_Protecciones:avanzado:Técnicas para evadir mitigaciones::; Evasión\njmp gadget|\
60.06_Ejercicios_de_Evasion:avanzado:Ejercicios prácticos de evasión::; Ejercicio\n; Bypassear canary con leak"

  ["65_Avanzado_Syscalls"]="avanzado|Uso avanzado de syscalls en Linux|\
65.01_Syscalls_Complejas:avanzado:Syscalls para sockets y procesos:syscall:; Socket\nmov rax, 41\nsyscall|\
65.02_Execve_Avanzado:avanzado:Ejecutar programas con execve:syscall:; Execve\nmov rax, 59\nmov rdi, bin_sh\nsyscall|\
65.03_Mmap_y_Memoria:avanzado:Mapeo de memoria con mmap:syscall:; Mmap\nmov rax, 9\nsyscall|\
65.04_Signals_y_Handlers:avanzado:Manejo de señales en ASM:syscall:; Signal\nmov rax, 13\nsyscall|\
65.05_Ejercicios_de_Syscalls:avanzado:Ejercicios prácticos de syscalls:syscall:; Ejercicio\nmov rax, 1\nmov rdi, 1\nsyscall"

  ["70_ROP"]="avanzado|Técnicas de Return Oriented Programming|\
70.01_Que_es_ROP:avanzado:Conceptos de Return Oriented Programming::; ROP\nret|\
70.02_Gadgets:avanzado:Encontrar gadgets en binarios::; Gadget\npop rax\nret|\
70.03_Cadena_ROP:avanzado:Crear cadenas ROP para exploits::; Cadena\npop rdi\nret|\
70.04_ROP_con_execve:avanzado:ROP para ejecutar /bin/sh:syscall:; Execve\nmov rax, 59\nsyscall|\
70.05_Uso_con_Pwntools:avanzado:Automatización con pwntools::; Pwntools\n; from pwn import *|\
70.06_Ejercicios_de_ROP:avanzado:Ejercicios prácticos de ROP::; Ejercicio\n; Construir cadena ROP para execve"

  ["75_Optimizacion_y_Ofuscacion"]="avanzado|Optimización y ofuscación de código ASM|\
75.01_Optimizacion_de_Codigo:avanzado:Optimización para rendimiento::; Optimización\nxor rax, rax\n; Más rápido que mov rax, 0|\
75.02_Ofuscacion_Basica:avanzado:Ofuscación para evitar detección::; Ofuscación\nxor rax, 0xFF\nxor rax, 0xFF|\
75.03_Ofuscacion_Avanzada:avanzado:Técnicas avanzadas de ofuscación::; Ofuscación\n; Usar instrucciones redundantes|\
75.04_Polimorfismo:avanzado:Shellcode polimórfico::; Polimorfismo\n; Cambiar instrucciones dinámicamente|\
75.05_Ejercicios_de_Ofuscacion:avanzado:Ejercicios prácticos de ofuscación::; Ejercicio\n; Ofuscar shellcode execve"

  ["80_Shellcode"]="avanzado|Creación y uso de shellcode|\
80.01_Que_es_Shellcode:avanzado:Conceptos de shellcode::; Shellcode\nxor rax, rax|\
80.02_Generacion_con_Msfvenom:avanzado:Generar shellcode con msfvenom::; Msfvenom\n; msfvenom -p linux/x64/shell_reverse_tcp|\
80.03_Encoding_para_Evasion:avanzado:Encoders para evitar detección::; Encoding\nxor rax, rax|\
80.04_Shellcode_sin_Null_Bytes:avanzado:Shellcode sin bytes nulos::; Sin null\nxor rax, rax|\
80.05_Shellcode_x64_Linux:avanzado:Shellcode para Linux x64:syscall:; Shellcode\nxor rax, rax\nmov rax, 59\nsyscall|\
80.06_Shellcode_Polimorfico:avanzado:Shellcode que cambia dinámicamente::; Polimorfismo\n; Modificar shellcode en runtime|\
80.07_Ejercicios_de_Shellcode:avanzado:Ejercicios prácticos de shellcode:syscall:; Ejercicio\n; Crear shellcode para /bin/sh"

  ["85_Exploit_Development"]="avanzado|Desarrollo de exploits completos|\
85.01_Estructura_de_un_Exploit:avanzado:Componentes de un exploit::; Exploit\n; Payload + dirección de retorno|\
85.02_Exploits_con_Pwntools:avanzado:Automatización con pwntools::; Pwntools\n; from pwn import *|\
85.03_Exploits_con_ASLR:avanzado:Exploits bajo ASLR::; ASLR\n; Leak de direcciones|\
85.04_Exploits_con_NX:avanzado:Exploits con NX activado::; NX\n; Usar ROP para bypass|\
85.05_Ejercicios_de_Exploits:avanzado:Ejercicios prácticos de exploits::; Ejercicio\n; Crear exploit para programa vulnerable"

  ["90_Inyeccion_de_Codigo"]="avanzado|Técnicas de inyección de código|\
90.01_Inyeccion_en_Memoria:avanzado:Inyección directa en memoria::; Inyección\nmov [rdi], rax|\
90.02_Inyeccion_en_ELF:avanzado:Modificación de binarios ELF::; ELF\nmov [rip], rax|\
90.03_Hooking_de_Funciones:avanzado:Hooking de funciones en ASM::; Hook\njmp nuevo_codigo|\
90.04_Code_Caves:avanzado:Uso de code caves para inyección::; Code cave\nnop\n; Insertar código aquí|\
90.05_Inyeccion_Remota:avanzado:Inyección en procesos remotos::; Remota\nmov [pid], rax|\
90.06_Inyeccion_con_Ptrace:avanzado:Inyección usando ptrace:syscall:; Ptrace\nmov rax, 101\nsyscall|\
90.07_Ejercicios_de_Inyeccion:avanzado:Ejercicios prácticos de inyección::; Ejercicio\n; Inyectar shellcode en proceso"

  ["95_Protecciones_Avanzadas"]="avanzado|Protecciones modernas y análisis|\
95.01_RELRO:avanzado:Relocation Read-Only (RELRO)::; RELRO\n; readelf -l programa|\
95.02_PIE:avanzado:Position Independent Executable::; PIE\n; Compilar con -fPIE|\
95.03_Fortify_Source:avanzado:Protección contra desbordamientos::; Fortify\n; Evitar funciones inseguras|\
95.04_Analisis_de_Protecciones:avanzado:Herramientas para detectar protecciones::; Checksec\n; checksec programa|\
95.05_Evasion_Avanzada:avanzado:Técnicas avanzadas de evasión::; Evasión\n; Bypassear ASLR con leaks|\
95.06_Ejercicios_de_Protecciones:avanzado:Ejercicios prácticos de análisis::; Ejercicio\n; Analizar binario con checksec"

  ["100_Shellcode_Injection"]="avanzado|Inyección avanzada de shellcode|\
100.01_Generacion_Manual_de_Shellcode:avanzado:Shellcode manual en ASM:syscall:; Shellcode\nxor rax, rax\nmov rax, 59\nsyscall|\
100.02_Inyeccion_en_Stack:avanzado:Inyección en el stack::; Stack\nmov [rsp], rax|\
100.03_Shellcode_Persistente:avanzado:Persistencia en memoria::; Persistencia\nmov [mem], rax|\
100.04_Automatizacion_con_Python:avanzado:Automatización con Python y pwntools::; Pwntools\n; from pwn import *|\
100.05_Demo_de_Exploit:avanzado:Exploit completo con shellcode::; Exploit\njmp shellcode|\
100.06_Ejercicios_de_Inyeccion:avanzado:Ejercicios prácticos de inyección:syscall:; Ejercicio\n; Inyectar shellcode /bin/sh"

  ["105_Aplicaciones_Practicas"]="avanzado|Proyectos prácticos en ASM|\
105.01_Programa_Simple:avanzado:Programa completo en ASM:syscall:; Programa\nsection .data\n    msg db 'Hola', 0\nmov rax, 1\nsyscall|\
105.02_Exploit_Completo:avanzado:Exploit funcional con shellcode:syscall:; Exploit\nmov rax, 59\nsyscall|\
105.03_Mini_Shell:avanzado:Implementar un shell básico:syscall:; Shell\nmov rax, 59\nmov rdi, bin_sh\nsyscall|\
105.04_Análisis_de_Binario:avanzado:Análisis completo de un binario::; Análisis\n; Usar Ghidra y GDB|\
105.05_Proyecto_Final:avanzado:Proyecto integrador de ASM y hacking::; Proyecto\n; Combinar ROP, shellcode y evasión"
)

crear_md_submodulo() {
  local ruta="$1"
  local nivel="$2"
  local modulo="$3"
  local submodulo="$4"
  local dificultad="$5"
  local descripcion="$6"
  local instrucciones="$7"
  local ejemplo="$8"
  local prev_sub="$9"
  local next_sub="${10}"
  local nivel_num="${nivel%%_*}"
  local modulo_nombre="${modulo//_/ }"
  local submodulo_nombre="${submodulo//_/ }"
  local submodulo_tag="${submodulo#*_}"

  # Verificar si el archivo ya existe
  if [[ -f "$ruta" ]]; then
    echo "Advertencia: $ruta ya existe, no se sobrescribe."
    return
  fi

  # Crear contenido del archivo .md
  cat <<EOF >"$ruta"
---
title: "$submodulo_nombre"
level: $nivel_num
module: "$modulo_nombre"
difficulty: "$dificultad"
tags: [asm, x86-64, nivel_$nivel_num, submodulo_$submodulo_tag, hacking]
related_code: "$submodulo.asm"
prev: "${prev_sub:-}"
next: "${next_sub:-}"
created: "$(date +%Y-%m-%d)"
status: pending
---

# $submodulo_nombre

- Código: [[$submodulo.asm]]  
- Anterior: [[${prev_sub:-Ninguno}]]  
- Siguiente: [[${next_sub:-Ninguno}]]  
- Nivel: [[$nivel/index]]  

## Conceptos Clave
- $descripcion

## Instrucciones Usadas
- ${instrucciones:-Ninguna por ahora}

## Ejemplo Explicado
\`\`\`asm
$ejemplo
\`\`\`

## Observaciones
- Notas específicas sobre el submódulo.
- Agrega aquí tus observaciones tras practicar.

## Dudas y Referencias
- Busca en [OpenSecurityTraining](https://opensecuritytraining.info/) para más recursos.
- Consulta la documentación de NASM: https://www.nasm.us/doc/

## Tips
- Practica en un entorno seguro (Docker/QEMU).
- Usa GDB para depurar: \`gdb --tui programa\`.
- Compila con: \`nasm -f elf64 $submodulo.asm && ld $submodulo.o -o $submodulo\`.

## Recursos Visuales
- ![[$submodulo.gif]]  
- [YouTube](https://youtube.com/placeholder)
EOF
}

# Función para crear archivo .asm
crear_asm() {
  local ruta="$1"
  local submodulo="$2"
  local ejemplo="$3"
  local submodulo_nombre="${submodulo//_/ }"

  # Verificar si el archivo ya existe
  if [[ -f "$ruta" ]]; then
    echo "Advertencia: $ruta ya existe, no se sobrescribe."
    return
  fi

  # Crear contenido del archivo .asm
  cat <<EOF >"$ruta"
; $submodulo_nombre
; Creado: $(date +%Y-%m-%d)
section .data
    ; [Datos inicializados]
section .bss
    ; [Variables no inicializadas]
section .text
    global _start
_start:
    $ejemplo
    ; Salida limpia
    mov rax, 60         ; syscall: exit
    mov rdi, 0          ; código de salida 0
    syscall
EOF
}

# Función para crear index.md por nivel
crear_index_nivel() {
  local ruta="$1"
  local nivel="$2"
  local descripcion="$3"
  shift 3
  local submodulos=("$@")
  local nivel_nombre="${nivel//_/ }"
  local nivel_num="${nivel%%_*}"
  local requisitos="Ninguno"
  if [[ "$nivel_num" != "00" ]]; then
    requisitos="Nivel $((10#$nivel_num - 5))"
  fi

  # Verificar si el archivo ya existe
  if [[ -f "$ruta" ]]; then
    echo "Advertencia: $ruta ya existe, no se sobrescribe."
    return
  fi

  # Crear lista de submódulos
  local lista_submodulos=""
  for sub in "${submodulos[@]}"; do
    lista_submodulos+="- [[$sub]]\n"
  done

  # Crear contenido del index.md
  cat <<EOF >"$ruta"
# $nivel_nombre

## Descripción
- $descripcion

## Submódulos
$lista_submodulos

## Requisitos Previos
- Conocimientos previos: $requisitos
EOF
}

# Función para crear README.md
crear_readme() {
  local ruta="$1"
  local niveles=("${!ESTRUCTURA[@]}")
  IFS=$'\n' niveles=($(sort <<<"${niveles[*]}"))

  # Crear lista de niveles
  local lista_niveles=""
  for nivel in "${niveles[@]}"; do
    lista_niveles+="- [[$nivel/index]]\n"
  done

  # Verificar si el archivo ya existe
  if [[ -f "$ruta" ]]; then
    echo "Advertencia: $ruta ya existe, no se sobrescribe."
    return
  fi

  # Crear contenido del README.md
  cat <<EOF >"$ruta"
# Vault ASM (x86-64, NASM)

Estructura para aprender ensamblador (x86-64, NASM) en Obsidian (2025).

## Niveles
$lista_niveles

## Instrucciones
- **Instalación de herramientas** (ejecutar manualmente si es necesario):
  \`\`\`bash
  sudo pacman -S nasm gdb python-pwntools docker
  yay -S obsidian
  \`\`\`
- **Compilar y ejecutar código ASM**:
  \`\`\`bash
  nasm -f elf64 archivo.asm && ld archivo.o -o archivo && ./archivo
  \`\`\`
- **Depurar con GDB**:
  \`\`\`bash
  gdb --tui archivo
  \`\`\`
- **Entorno seguro**:
  - Usar Docker: \`docker run -it --rm -v \$(pwd):/workspace ubuntu:24.04\`
  - Usar QEMU para pruebas aisladas: \`qemu-x86_64 ./archivo\`
- **Obsidian**:
  - Instalar plugin Dataview para consultas dinámicas.
  - Usar enlaces bidireccionales para navegación.
- **Advertencia**: Ejecutar exploits y pruebas de hacking **solo** en entornos seguros (Docker, máquinas virtuales) para evitar daños al sistema.

## Estructura
- Cada nivel (00 a 100) contiene submódulos con archivos \`.asm\` y \`.md\`.
- Los archivos \`.md\` incluyen ejemplos, explicaciones y enlaces a código.

## Recursos Recomendados
- [The Art of Assembly Language](https://www.plantation-productions.com/Webster/www.artofasm.com/index.html)
- [Hacking: The Art of Exploitation](https://www.nostarch.com/hacking2.htm)
- [OpenSecurityTraining](https://opensecuritytraining.info/)
- [NASM Documentation](https://www.nasm.us/doc/)
EOF
}

# Función para crear Dockerfile
crear_dockerfile() {
  local ruta="$1"

  # Verificar si el archivo ya existe
  if [[ -f "$ruta" ]]; then
    echo "Advertencia: $ruta ya existe, no se sobrescribe."
    return
  fi

  # Crear contenido del Dockerfile
  cat <<EOF >"$ruta"
FROM ubuntu:24.04
RUN apt-get update && apt-get install -y nasm gdb python3 python3-pip
RUN pip3 install pwntools
WORKDIR /workspace
VOLUME /workspace
CMD ["bash"]
EOF
}

# Función principal para generar la estructura
generar_estructura() {
  # Verificar permisos y espacio en disco
  if [[ ! -w "$RAIZ" ]]; then
    echo "Error: No hay permisos de escritura en $RAIZ"
    exit 1
  fi
  if ! df -h "$RAIZ" >/dev/null 2>&1; then
    echo "Error: No hay suficiente espacio en disco en $RAIZ"
    exit 1
  fi

  # Crear directorio raíz
  mkdir -p "$RAIZ" || {
    echo "Error: No se pudo crear $RAIZ"
    exit 1
  }
  echo "Creando vault en: $RAIZ"

  # Crear README.md
  crear_readme "$RAIZ/README.md"

  # Crear Dockerfile
  crear_dockerfile "$RAIZ/Dockerfile"

  # Iterar sobre niveles
  for nivel in "${!ESTRUCTURA[@]}"; do
    nivel_dir="$RAIZ/$nivel"
    echo "Creando nivel: $nivel"
    mkdir -p "$nivel_dir" || {
      echo "Error: No se pudo crear $nivel_dir"
      continue
    }

    # Obtener datos del nivel
    IFS='|' read -r dificultad descripcion submodulos <<<"${ESTRUCTURA[$nivel]}"
    submodulos_array=()
    while IFS=':' read -r submodulo sub_dificultad sub_descripcion sub_instrucciones sub_ejemplo; do
      [[ -n "$submodulo" ]] && submodulos_array+=("$submodulo")
    done <<<"$(echo "$submodulos" | tr '|' '\n')"

    # Crear index.md del nivel
    crear_index_nivel "$nivel_dir/index.md" "$nivel" "$descripcion" "${submodulos_array[@]}"

    # Iterar sobre submódulos
    for i in "${!submodulos_array[@]}"; do
      submodulo="${submodulos_array[$i]}"
      submodulo_dir="$nivel_dir/$submodulo"
      echo "  Creando submódulo: $submodulo"
      mkdir -p "$submodulo_dir" || {
        echo "Error: No se pudo crear $submodulo_dir"
        continue
      }

      # Obtener datos del submódulo
      IFS='|' read -r _ sub_dificultad sub_descripcion sub_instrucciones sub_ejemplo <<<"$(echo "$submodulos" | tr '|' '\n' | grep "^$submodulo:")"

      # Crear archivo .asm (o extensión según lenguaje)
      ext=".asm"
      if [[ "$LENGUAJE" != "ASM" ]]; then
        ext=".${LENGUAJE,,}"
      fi
      archivo_path="$submodulo_dir/$submodulo$ext"
      if [[ ! -f "$archivo_path" ]]; then
        if [[ "$LENGUAJE" == "ASM" ]]; then
          crear_asm "$archivo_path" "$submodulo" "$sub_ejemplo"
        else
          echo "# Archivo $submodulo para $LENGUAJE" >"$archivo_path"
        fi
      else
        echo "Advertencia: $archivo_path ya existe, no se sobrescribe."
      fi

      # Crear carpeta Apuntes y archivo .md
      apuntes_dir="$submodulo_dir/Apuntes"
      mkdir -p "$apuntes_dir" || {
        echo "Error: No se pudo crear $apuntes_dir"
        continue
      }
      md_path="$apuntes_dir/$submodulo.md"
      if [[ ! -f "$md_path" ]]; then
        prev_sub=""
        next_sub=""
        [[ $i -gt 0 ]] && prev_sub="${submodulos_array[$((i - 1))]}"
        [[ $i -lt $((${#submodulos_array[@]} - 1)) ]] && next_sub="${submodulos_array[$((i + 1))]}"
        crear_md_submodulo "$md_path" "$nivel" "$nivel" "$submodulo" "$sub_dificultad" "$sub_descripcion" "$sub_instrucciones" "$sub_ejemplo" "$prev_sub" "$next_sub"
      else
        echo "Advertencia: $md_path ya existe, no se sobrescribe."
      fi
    done
  done

  echo "Estructura de vault para ASM generada exitosamente."
}

# Ejecutar la función principal
generar_estructura
