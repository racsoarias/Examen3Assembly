cd C:\Users\OscAr\Desktop

del *.obj
del *.o

nasm -fwin32 singlePlayer.asm
nasm -fwin32 multiPlayer.asm
gcc -c main.c -m32
gcc -m32 singlePlayer.obj multiPlayer.obj main.o -o Gato.exe