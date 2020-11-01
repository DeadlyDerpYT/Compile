nasm src/bootloader.asm -f bin -i src -o bootloader.bin

nasm src/ExtendedProgram.asm -f elf64 -i src -o ExtendedProgram.o

wsl g++ -ffreestanding -mno-red-zone -m64 -c "./src/Kernel.cpp" -o "Kernel.o"

ld -Ttext 0x8000 ExtendedProgram.o Kernel.o -o kernel.tmp
objcopy -O binary kernel.tmp kernel.bin

copy /b bootloader.bin+kernel.bin bootloader.bin
"C:\Program Files\qemu\qemu-system-x86_64" -fda bootloader.bin
pause
