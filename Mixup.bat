del Player.obj
del main.o
del Gato.exe

nasm -fwin32 Player.asm
gcc -c main.c -m32
gcc -m32 Player.obj main.o -o Gato.exe