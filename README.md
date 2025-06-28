---
title: Vault ASM (x86-64, NASM)
tags:
  - asm
  - x86-64
  - nasm
  - hacking
  - obsidian
  - dataview
  - excalidraw
  - canvas
level: 
difficulty: principiante,intermedio,avanzado
tools:
  - nasm
  - gdb
  - radare2
  - cutter
  - python-pwntools
  - docker
  - qemu
  - ghidra
  - obsidian
created: 2025-06-27
last_modified: 
version: 1.0.0
status: stable
updated_by: TuNombre
---

# Vault ASM (x86-64, NASM)

> [!NOTE]  
> Guía definitiva para aprender ensamblador x86-64 (NASM) en Arch Linux 2025, desde fundamentos hasta hacking ofensivo. Optimizada para Obsidian con soporte para Dataview, Excalidraw, Canvas, y Codeblock.

> **Arquitectura:** x86-64 (64 bits, sintaxis NASM)  
> **Entorno:** Arch Linux 2025, NASM, GDB, Radare2, Cutter, pwntools, Docker, QEMU, Ghidra  
> **Enlaces Clave:** [[Tablas/x86-64_NASM_Ultimate_Cheatsheet]] | [[Tablas/Changelog]]  
> **Objetivo:** Dominar ASM para desarrollo, reversing, y hacking ético.

> [!WARNING]  
> Los niveles 50-100 (buffer overflow, shellcode, inyección) deben ejecutarse **solo** en entornos aislados (Docker, QEMU) para evitar daños al sistema. Ver [[100.02_Inyeccion_en_Stack]].

---

## Índice

- [Descripción](#descripción)  
- [Niveles de Aprendizaje](#niveles-de-aprendizaje)  
  - [Principiante](#principiante)  
  - [Intermedio](#intermedio)  
  - [Avanzado](#avanzado)  
- [Instrucciones de Uso](#instrucciones-de-uso)  
- [Estructura del Vault](#estructura-del-vault)  
- [Recursos Recomendados](#recursos-recomendados)  
- [Dataview Queries](#dataview-queries)  
- [Git y Versionado](#git-y-versionado)  

---

## Descripción

Este vault es una guía estructurada para aprender ensamblador x86-64 (NASM) en Arch Linux, cubriendo desde conceptos básicos hasta técnicas avanzadas de hacking ofensivo. Cada nivel incluye:  
- **Archivos `.asm`:** Código fuente comentado.  
- **Archivos `.md`:** Apuntes teóricos, ejemplos, y enlaces bidireccionales.  
- **Índices (`index.md`):** Resumen de submódulos por nivel.  
- **Cheatsheet:** [[Tablas/x86-64_NASM_Ultimate_Cheatsheet]] con instrucciones clave.  

> [!TIP]  
> Usa Canvas en Obsidian para mapear niveles y [[Tablas/x86-64_NASM_Ultimate_Cheatsheet]] para referencias rápidas.

> [!EXCALIDRAW] Mapa de Aprendizaje  
> Crea un canvas con nodos para cada nivel, conectando al cheatsheet y al changelog. Ver [[20.04_Estructura_de_Funciones]] para diagramas de stack.

---

## Niveles de Aprendizaje

### Principiante

- [[00_MOV_y_Registros_Basicos/index]] - Introducción a MOV y registros.  
- [[05_Operaciones_Aritmeticas/index]] - Sumas, restas, multiplicaciones, y banderas.  
- [[10_Saltos_y_Control_de_Flujo/index]] - Saltos, comparaciones, y bucles.  
- [[15_Logica_y_Manipulacion_de_Bits/index]] - Operaciones lógicas y desplazamientos.  
- [[20_Stack_y_Funciones/index]] - Gestión de pila y funciones.  
- [[25_Segmentos_de_Memoria/index]] - Secciones `.data`, `.bss`, y variables.  
- [[30_Entrada_Salida/index]] - Syscalls para entrada/salida.  
- [[35_Strings_y_Estructuras/index]] - Manipulación de strings y estructuras.  

### Intermedio


- [[40_Debugging_GDB_Objdump/index]] - Debugging con GDB, Objdump, y Ghidra.  
- [[45_Formato_ELF/index]] - Estructura de binarios ELF.  
- [[50_Buffer_Overflow/index]] - Desbordamientos de búfer básicos.  
- [[55_Análisis_de_Malware/index]] - Análisis estático y dinámico de malware.  
- [[60_Proteccion_y_Evasion/index]] - Mitigaciones (ASLR, NX, Canaries) y evasión.  
- [[65_Avanzado_Syscalls/index]] - Syscalls complejas (execve, mmap).  


### Avanzado

- [[70_ROP/index]] - Return-Oriented Programming (ROP).  
- [[75_Optimizacion_y_Ofuscacion/index]] - Optimización y ofuscación de código.  
- [[80_Shellcode/index]] - Desarrollo de shellcode sin null bytes.  
- [[85_Exploit_Development/index]] - Creación de exploits con pwntools.  
- [[90_Inyeccion_de_Codigo/index]] - Inyección en memoria, ELF, y procesos.  
- [[95_Protecciones_Avanzadas/index]] - RELRO, PIE, Fortify Source.  
- [[100_Shellcode_Injection/index]] - Inyección avanzada de shellcode.  
- [[105_Proyectos_Avanzados/index]] - Proyectos finales y exploits completos.  



---

## Instrucciones de Uso

### Instalación de Herramientas

```bash
sudo pacman -Syu
sudo pacman -S nasm gdb radare2 cutter python-pwntools docker qemu ghidra
yay -S obsidian
sudo usermod -aG docker $USER
````