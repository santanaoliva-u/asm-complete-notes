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

-----------------
![Estado: Estable](https://img.shields.io/badge/Estado-Estable-green)
![Versión: 1.0.0](https://img.shields.io/badge/Versión-1.0.0-blue)
![Lenguaje: ASM x86-64](https://img.shields.io/badge/Lenguaje-ASM%20x86--64-lightgrey)
![Herramientas: NASM, GDB, Radare2](https://img.shields.io/badge/Herramientas-NASM%2C%20GDB%2C%20Radare2-blue)
![Obsidian: Compatible](https://img.shields.io/badge/Obsidian-Compatible-purple)
![Entorno: Arch Linux 2025](https://img.shields.io/badge/Entorno-Arch%20Linux%202025-1793d1)
![Licencia: MIT](https://img.shields.io/badge/Licencia-MIT-yellow)
![Hacking: Pwnable](https://img.shields.io/badge/Hacking-Pwnable-orange)
![Comunidad: CTFtime](https://img.shields.io/badge/Comunidad-CTFtime-red)
![Última Actualización: Junio 2025](https://img.shields.io/badge/Última%20Actualización-Junio%202025-informational)
_____



Mi **Ruta:** `~/Documents/OBSIDIAN/Programacion/01_Estudio/03_ASM/`

> [!NOTE]  
> Guía definitiva para aprender ensamblador x86-64 (NASM) en Arch Linux 2025, desde fundamentos hasta hacking ofensivo. Optimizada para Obsidian con soporte para Dataview, Excalidraw, Canvas, y Codeblock. En GitHub, usa los enlaces relativos para navegar.

> **Arquitectura:** x86-64 (64 bits, sintaxis NASM)  
> **Entorno:** Arch Linux 2025, NASM, GDB, Radare2, Cutter, pwntools, Docker, QEMU, Ghidra, checksec  
> **Enlaces Clave:** [[Tablas/x86-64_NASM_Ultimate_Cheatsheet]] ([Tablas/x86-64_NASM_Ultimate_Cheatsheet.md](Tablas/x86-64_NASM_Ultimate_Cheatsheet.md)) | [[Tablas/Changelog]] ([Tablas/Changelog.md](Tablas/Changelog.md))  
> **Objetivo:** Dominar ASM para desarrollo, reversing, y hacking ético.

> **Advertencia:**  
> Los niveles 50-100 (buffer overflow, shellcode, inyección) deben ejecutarse **solo** en entornos aislados (Docker, QEMU). Ver [[100.02_Inyeccion_en_Stack]] ([100_Shellcode_Injection/100.02_Inyeccion_en_Stack/Apuntes/100.02_Inyeccion_en_Stack.md](100_Shellcode_Injection/100.02_Inyeccion_en_Stack/Apuntes/100.02_Inyeccion_en_Stack.md)).

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
- [Estado del Proyecto](#estado-del-proyecto)  

---

## Descripción

Este vault es una guía estructurada para aprender ensamblador x86-64 (NASM) en Arch Linux, cubriendo desde conceptos básicos hasta técnicas avanzadas de hacking ofensivo. Cada nivel incluye:  
- **Archivos `.asm`:** Código fuente comentado.  
- **Archivos `.md`:** Apuntes teóricos, ejemplos, y enlaces bidireccionales (Obsidian) o relativos (GitHub).  
- **Índices (`index.md`):** Resumen de submódulos por nivel.  
- **Cheatsheet:** [[Tablas/x86-64_NASM_Ultimate_Cheatsheet]] ([Tablas/x86-64_NASM_Ultimate_Cheatsheet.md](Tablas/x86-64_NASM_Ultimate_Cheatsheet.md)).  

> [!TIP]  
> Usa Canvas en Obsidian para mapear niveles o crea un Excalidraw para visualizar el stack. En GitHub, navega con los enlaces relativos.

---

## Niveles de Aprendizaje

### Principiante

<details>
<summary>Ver Niveles</summary>

- [[00_MOV_y_Registros_Basicos/index]] ([00_MOV_y_Registros_Basicos/index.md](00_MOV_y_Registros_Basicos/index.md)) - Introducción a MOV y registros.  
- [[05_Operaciones_Aritmeticas/index]] ([05_Operaciones_Aritmeticas/index.md](05_Operaciones_Aritmeticas/index.md)) - Sumas, restas, multiplicaciones, y banderas.  
- [[10_Saltos_y_Control_de_Flujo/index]] ([10_Saltos_y_Control_de_Flujo/index.md](10_Saltos_y_Control_de_Flujo/index.md)) - Saltos, comparaciones, y bucles.  
- [[15_Logica_y_Manipulacion_de_Bits/index]] ([15_Logica_y_Manipulacion_de_Bits/index.md](15_Logica_y_Manipulacion_de_Bits/index.md)) - Operaciones lógicas y desplazamientos.  
- [[20_Stack_y_Funciones/index]] ([20_Stack_y_Funciones/index.md](20_Stack_y_Funciones/index.md)) - Gestión de pila y funciones.  
- [[25_Segmentos_de_Memoria/index]] ([25_Segmentos_de_Memoria/index.md](25_Segmentos_de_Memoria/index.md)) - Secciones `.data`, `.bss`, y variables.  
- [[30_Entrada_Salida/index]] ([30_Entrada_Salida/index.md](30_Entrada_Salida/index.md)) - Syscalls para entrada/salida.  
- [[35_Strings_y_Estructuras/index]] ([35_Strings_y_Estructuras/index.md](35_Strings_y_Estructuras/index.md)) - Manipulación de strings y estructuras.  

</details>

### Intermedio

<details>
<summary>Ver Niveles</summary>

- [[40_Debugging_GDB_Objdump/index]] ([40_Debugging_GDB_Objdump/index.md](40_Debugging_GDB_Objdump/index.md)) - Debugging con GDB, Objdump, y Ghidra.  
- [[45_Formato_ELF/index]] ([45_Formato_ELF/index.md](45_Formato_ELF/index.md)) - Estructura de binarios ELF.  
- [[50_Buffer_Overflow/index]] ([50_Buffer_Overflow/index.md](50_Buffer_Overflow/index.md)) - Desbordamientos de búfer básicos.  
- [[55_Análisis_de_Malware/index]] ([55_Análisis_de_Malware/index.md](55_Análisis_de_Malware/index.md)) - Análisis estático y dinámico de malware.  
- [[60_Proteccion_y_Evasion/index]] ([60_Proteccion_y_Evasion/index.md](60_Proteccion_y_Evasion/index.md)) - Mitigaciones (ASLR, NX, Canaries) y evasión.  
- [[65_Avanzado_Syscalls/index]] ([65_Avanzado_Syscalls/index.md](65_Avanzado_Syscalls/index.md)) - Syscalls complejas (execve, mmap).  

</details>

### Avanzado

<details>
<summary>Ver Niveles</summary>

- [[70_ROP/index]] ([70_ROP/index.md](70_ROP/index.md)) - Return-Oriented Programming (ROP).  
- [[75_Optimizacion_y_Ofuscacion/index]] ([75_Optimizacion_y_Ofuscacion/index.md](75_Optimizacion_y_Ofuscacion/index.md)) - Optimización y ofuscación de código.  
- [[80_Shellcode/index]] ([80_Shellcode/index.md](80_Shellcode/index.md)) - Desarrollo de shellcode sin null bytes.  
- [[85_Exploit_Development/index]] ([85_Exploit_Development/index.md](85_Exploit_Development/index.md)) - Creación de exploits con pwntools.  
- [[90_Inyeccion_de_Codigo/index]] ([90_Inyeccion_de_Codigo/index.md](90_Inyeccion_de_Codigo/index.md)) - Inyección en memoria, ELF, y procesos.  
- [[95_Protecciones_Avanzadas/index]] ([95_Protecciones_Avanzadas/index.md](95_Protecciones_Avanzadas/index.md)) - RELRO, PIE, Fortify Source.  
- [[100_Shellcode_Injection/index]] ([100_Shellcode_Injection/index.md](100_Shellcode_Injection/index.md)) - Inyección avanzada de shellcode.  
- [[105_Proyectos_Avanzados/index]] ([105_Proyectos_Avanzados/index.md](105_Proyectos_Avanzados/index.md)) - Proyectos finales y exploits completos.  

</details>

---

## Instrucciones de Uso

### Instalación de Herramientas

```bash
sudo pacman -Syu
sudo pacman -S nasm gdb radare2 cutter python-pwntools docker qemu-system-x86 ghidra binutils checksec
yay -S obsidian
sudo usermod -aG docker $USER
newgrp docker
````