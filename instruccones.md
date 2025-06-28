


### Prompt para Generar Archivos `.md` y `.asm`

Este prompt está diseñado para que una IA genere contenido consistente para los archivos `.md` (teoría) y `.asm` (ejemplos prácticos) en los submódulos de `00.01_Introduccion_al_ASM` a `00.05_MOV_entre_Registros`. El contenido será claro, educativo, y alineado con tu proyecto **Vault ASM (x86-64, NASM)**, con enlaces compatibles con Obsidian (`[[...]]`) y GitHub (`[texto](ruta)`). El prompt incluye instrucciones para respetar la estructura de tu vault, usar NASM en x86-64, y preparar ejemplos ejecutables en entornos seguros (Docker/QEMU).

```plaintext
**Prompt para Generar Archivos .md y .asm para Vault ASM (x86-64, NASM)**

**Contexto:**
Estoy desarrollando un proyecto educativo en ensamblador x86-64 (NASM) para Arch Linux 2025, organizado en un vault de Obsidian ubicado en `~/Documents/OBSIDIAN/Programacion/01_Estudio/03_ASM/`. El vault cubre desde fundamentos hasta hacking ofensivo, con una estructura de directorios que incluye `00_MOV_y_Registros_Basicos`, `05_Operaciones_Aritmeticas`, ..., hasta `105_Proyectos_Avanzados`. Mi repositorio está en `https://github.com/santanaoliva-u/asm-complete-notes`.

**Objetivo:**
Generar contenido para los submódulos de `00_MOV_y_Registros_Basicos` desde `00.01_Introduccion_al_ASM` hasta `00.05_MOV_entre_Registros`. Cada submódulo debe contener:
- Un archivo `.md` (en `Apuntes/`) con teoría, ejemplos, enlaces bidireccionales para Obsidian (`[[...]]`) y enlaces relativos para GitHub (`[texto](ruta)`).
- Un archivo `.asm` con código ejecutable en x86-64 NASM, comentado y probado en Docker/QEMU.

**Estructura del Directorio:**
```
/home/x/Documents/OBSIDIAN/Programacion/01_Estudio/03_ASM/00_MOV_y_Registros_Basicos/
├── 00.01_Introduccion_al_ASM
│   ├── 00.01_Introduccion_al_ASM.asm
│   └── Apuntes
│       └── 00.01_Introduccion_al_ASM.md
├── 00.02_Estructura_de_un_Archivo_ASM
│   ├── 00.02_Estructura_de_un_Archivo_ASM.asm
│   └── Apuntes
│       └── 00.02_Estructura_de_un_Archivo_ASM.md
├── 00.03_Registros_Generales
│   ├── 00.03_Registros_Generales.asm
│   └── Apuntes
│       └── 00.03_Registros_Generales.md
├── 00.04_Registros_Especificos
│   ├── 00.04_Registros_Especificos.asm
│   └── Apuntes
│       └── 00.04_Registros_Especificos.md
├── 00.05_MOV_entre_Registros
│   ├── 00.05_MOV_entre_Registros.asm
│   └── Apuntes
│       └── 00.05_MOV_entre_Registros.md
└── index.md
```

**Instrucciones para la IA:**

1. **General:**
   - Genera contenido educativo para principiantes en ensamblador x86-64 (NASM) en Arch Linux 2025.
   - Usa un tono claro, técnico y estructurado, con ejemplos prácticos y consejos para hacking ofensivo.
   - Incluye metadatos YAML en los `.md` con `title`, `tags` (por ejemplo, `[asm, x86-64, nasm, principiante]`), `difficulty`, `tools` (por ejemplo, `[nasm, gdb, docker, qemu]`), `created`, y `last_modified`.
   - Asegúrate de que los enlaces sean compatibles con Obsidian (`[[ruta]]`) y GitHub (`[texto](ruta)`).
   - Los ejemplos `.asm` deben ser compilables con `nasm -f elf64 file.asm && ld file.o -o file && ./file`.
   - Prueba los ejemplos en un contenedor Docker (`docker run -it -v $(pwd):/workspace ubuntu:24.04`) con ASLR desactivado (`echo 0 > /proc/sys/kernel/randomize_va_space`).

2. **Contenido por Submódulo:**
   - **00.01_Introduccion_al_ASM:**
     - `.md`: Explica qué es el ensamblador x86-64, su importancia, y herramientas (NASM, GDB, Docker, QEMU). Incluye un ejemplo simple de "Hello, World!" con syscall `write`. Enlaza a [[Tablas/x86-64_NASM_Ultimate_Cheatsheet]] y [[00.02_Estructura_de_un_Archivo_ASM]].
     - `.asm`: Código de "Hello, World!" usando `write` (syscall 1) y `exit` (syscall 60).
   - **00.02_Estructura_de_un_Archivo_ASM:**
     - `.md`: Describe la estructura de un archivo NASM (`section .text`, `.data`, `.bss`, `global _start`). Explica el punto de entrada `_start` y el ensamblado (`nasm`, `ld`). Enlaza a [[00.01_Introduccion_al_ASM]] y [[00.03_Registros_Generales]].
     - `.asm`: Ejemplo con secciones `.text`, `.data`, y `.bss`, mostrando un programa que inicializa una variable y sale.
   - **00.03_Registros_Generales:**
     - `.md`: Introduce los registros de propósito general (RAX, RBX, RCX, RDX, RSI, RDI, RSP, RBP) y su uso en System V ABI. Explica tamaños (64, 32, 16, 8 bits). Enlaza a [[00.04_Registros_Especificos]] y [[Tablas/x86-64_NASM_Ultimate_Cheatsheet]].
     - `.asm`: Ejemplo que mueve valores entre RAX, RBX, RCX usando `mov` y sale con `syscall`.
   - **00.04_Registros_Especificos:**
     - `.md`: Detalla registros específicos (RIP, RFLAGS, segment registers como CS, DS). Explica su rol en control de flujo y banderas (CF, ZF, SF). Enlaza a [[00.03_Registros_Generales]] y [[00.05_MOV_entre_Registros]].
     - `.asm`: Ejemplo que usa `mov` para cargar una dirección con RIP-relativo y muestra banderas con `cmp`.
   - **00.05_MOV_entre_Registros:**
     - `.md`: Explica la instrucción `mov` para transferencias entre registros, con sintaxis y ejemplos. Cubre restricciones (por ejemplo, no `mov [mem], [mem]`). Enlaza a [[00.03_Registros_Generales]] y [[25_Segmentos_de_Memoria/index]].
     - `.asm`: Ejemplo que transfiere datos entre RAX, RBX, RSI, RDI, y usa `xor` para limpiar registros.

3. **Formato de los Archivos:**
   - **`.md`:**
     - Metadatos YAML: `title`, `tags`, `difficulty: principiante`, `tools`, `created: 2025-06-27`, `last_modified`.
     - Estructura: Título, introducción, teoría, ejemplos (en bloques de código), enlaces a submódulos relacionados, y un consejo (`> [!TIP]`).
     - Ejemplo de enlace: `[[00.01_Introduccion_al_ASM]] ([../00_MOV_y_Registros_Basicos/00.01_Introduccion_al_ASM/Apuntes/00.01_Introduccion_al_ASM.md])`.
   - **`.asm`:**
     - Usa secciones `.text`, `.data`, `.bss` cuando sea necesario.
     - Incluye comentarios claros para cada instrucción.
     - Evita null bytes en ejemplos (por ejemplo, usa `xor rax, rax` en lugar de `mov rax, 0`).
     - Termina con `syscall` para `exit` (código 60).

4. **Restricciones:**
   - No generes contenido para submódulos más allá de `00.05_MOV_entre_Registros`.
   - Respeta la estructura existente: cada submódulo tiene un `.asm` y un `.md` en `Apuntes/`.
   - Usa solo instrucciones x86-64 (NASM) y evita sintaxis AT&T.
   - Enlaza solo a submódulos existentes en la estructura proporcionada o a `Tablas/x86-64_NASM_Ultimate_Cheatsheet.md`.

5. **Entorno de Pruebas:**
   - Incluye comandos para compilar y ejecutar en cada `.md`:
     ```bash
     nasm -f elf64 file.asm && ld file.o -o file && ./file
     ```
   - Recomienda pruebas en Docker/QEMU:
     ```bash
     docker run -it -v $(pwd):/workspace ubuntu:24.04
     echo 0 > /proc/sys/kernel/randomize_va_space
     ```

6. **Ejemplo de Salida Esperada (para 00.01_Introduccion_al_ASM):**
   - **00.01_Introduccion_al_ASM/Apuntes/00.01_Introduccion_al_ASM.md:**
     ```markdown
     ---
     title: "Introducción al Ensamblador x86-64"
     tags: [asm, x86-64, nasm, principiante]
     difficulty: principiante
     tools: [nasm, gdb, docker, qemu]
     created: 2025-06-27
     last_modified: 2025-06-27
     ---
     # Introducción al Ensamblador x86-64
     El ensamblador x86-64 es un lenguaje de bajo nivel para procesadores de 64 bits. NASM es el ensamblador usado en este vault.

     ## ¿Por qué aprender ASM?
     - Comprender el hardware.
     - Desarrollar exploits (ver [[100_Shellcode_Injection/index]]).
     - Depuración avanzada.

     ## Herramientas
     - **NASM**: Ensamblador.
     - **GDB**: Depurador.
     - **Docker/QEMU**: Entornos seguros.

     ## Ejemplo: Hello, World!
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

     **Compilar y ejecutar:**
     ```bash
     nasm -f elf64 00.01_Introduccion_al_ASM.asm && ld 00.01_Introduccion_al_ASM.o -o hello && ./hello
     ```

     > [!TIP]
     > Prueba en Docker para evitar riesgos: `docker run -it -v $(pwd):/workspace ubuntu:24.04`.

     **Enlaces:**
     - Siguiente: [[00.02_Estructura_de_un_Archivo_ASM]] ([../00.02_Estructura_de_un_Archivo_ASM/Apuntes/00.02_Estructura_de_un_Archivo_ASM.md])
     - Cheatsheet: [[Tablas/x86-64_NASM_Ultimate_Cheatsheet]] ([../../../Tablas/x86-64_NASM_Ultimate_Cheatsheet.md])
     ```
   - **00.01_Introduccion_al_ASM/00.01_Introduccion_al_ASM.asm:**
     ```asm
     ; 00.01_Introduccion_al_ASM.asm
     ; Ejemplo: Imprime "Hello, World!" usando syscall write
     section .data
         msg db "Hello, World!", 0xA ; Mensaje con salto de línea
         len equ $ - msg            ; Longitud del mensaje
     section .text
         global _start
     _start:
         mov rax, 1    ; syscall: write
         mov rdi, 1    ; fd: stdout
         mov rsi, msg  ; buffer
         mov rdx, len  ; length
         syscall       ; Llamada al sistema
         mov rax, 60   ; syscall: exit
         xor rdi, rdi  ; status: 0
         syscall       ; Salir
     ```

7. **Tarea:**
   - Genera los archivos `.md` y `.asm` para los submódulos `00.01_Introduccion_al_ASM`, `00.02_Estructura_de_un_Archivo_ASM`, `00.03_Registros_Generales`, `00.04_Registros_Especificos`, y `00.05_MOV_entre_Registros`.
   - Asegúrate de que el contenido sea progresivo, educativo, y prepare al usuario para temas avanzados como buffer overflows y shellcode.
   - Proporciona un script Bash para aplicar los cambios en el vault (crear archivos, eliminar duplicados).

**Fin del Prompt**
```

---

### Script Bash para Aplicar Cambios

Este script elimina los submódulos duplicados en `00_MOV_y_Registros_Basicos` y crea la estructura para los submódulos `00.01` a `00.05`.

```bash
#!/bin/bash
# corregir_vault.sh
VAULT_DIR=~/Documents/OBSIDIAN/Programacion/01_Estudio/03_ASM/00_MOV_y_Registros_Basicos
cd $VAULT_DIR

# Eliminar submódulos duplicados
rm -rf 00.04_Instruccion_MOV_Sintaxis 00.05_Instruccion_MOV_Sintaxis \
       00.06_MOV_con_Valores_Inmediatos 00.06_MOV_entre_Registros \
       00.07_MOV_con_Memoria_Directa 00.07_MOV_con_Valores_Inmediatos \
       00.08_MOV_con_Memoria_Directa 00.08_MOV_con_Punteros \
       00.09_MOV_con_Punteros 00.09_MOV_y_Segmentacion \
       00.10_Ejercicios_Practicos 00.10_MOV_y_Segmentacion \
       00.11_Ejercicios_Practicos

# Crear estructura...