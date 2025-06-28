# Vault ASM (x86-64, NASM)

Estructura para aprender ensamblador (x86-64, NASM) en Obsidian (2025).

## Niveles
- [[00_MOV_y_Registros_Basicos/index]]\n- [[05_Operaciones_Aritmeticas/index]]\n- [[100_Shellcode_Injection/index]]\n- [[10_Saltos_y_Control_de_Flujo/index]]\n- [[15_Logica_y_Manipulacion_de_Bits/index]]\n- [[20_Stack_y_Funciones/index]]\n- [[25_Segmentos_de_Memoria/index]]\n- [[30_Entrada_Salida/index]]\n- [[35_Strings_y_Estructuras/index]]\n- [[40_Debugging_GDB_Objdump/index]]\n- [[45_Formato_ELF/index]]\n- [[50_Buffer_Overflow/index]]\n- [[60_Proteccion_y_Evasion/index]]\n- [[70_ROP/index]]\n- [[80_Shellcode/index]]\n- [[90_Inyeccion_de_Codigo/index]]\n

## Instrucciones
- **Instalación de herramientas** (ejecutar manualmente si es necesario):
  ```bash
  sudo pacman -S nasm gdb python-pwntools docker
  yay -S obsidian
  ```
- **Compilar y ejecutar código ASM**:
  ```bash
  nasm -f elf64 archivo.asm && ld archivo.o -o archivo && ./archivo
  ```
- **Depurar con GDB**:
  ```bash
  gdb --tui archivo
  ```
- **Entorno seguro**:
  - Usar Docker: `docker run -it --rm -v $(pwd):/workspace ubuntu:24.04`
  - Usar QEMU para pruebas aisladas: `qemu-x86_64 ./archivo`
- **Obsidian**:
  - Instalar plugin Dataview para consultas dinámicas.
  - Usar enlaces bidireccionales para navegación.
- **Advertencia**: Ejecutar exploits y pruebas de hacking **solo** en entornos seguros (Docker, máquinas virtuales) para evitar daños al sistema.

## Estructura
- Cada nivel (00 a 100) contiene submódulos con archivos `.asm` y `.md`.
- Los archivos `.md` incluyen ejemplos, explicaciones y enlaces a código.

## Recursos Recomendados
- [The Art of Assembly Language](https://www.plantation-productions.com/Webster/www.artofasm.com/index.html)
- [Hacking: The Art of Exploitation](https://www.nostarch.com/hacking2.htm)
- [OpenSecurityTraining](https://opensecuritytraining.info/)
- [NASM Documentation](https://www.nasm.us/doc/)
