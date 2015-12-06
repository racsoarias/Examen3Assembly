#include <stdio.h>
#include <windows.h>

extern int singlePlayer(int);
extern int multiPlayer(int);

void sleep (unsigned milliseconds){
    Sleep (milliseconds);
}

int main(){
    int num;

    printf("Tipo de juego \n  1)Single Player \n  2)Multiplayer \n");
    scanf("%d", &num);
    //printf("Modo seleccionado: %d", num);

	if (num == 1){
        int a = singlePlayer(10);
        //printf("El singlePlayer de 10 es: %d\n", a);
    }else{
        int b = multiPlayer(10);
        //printf("La multiPlayer de 10 es: %d\n", b);
    }

	sleep(10000);
	return 0;
}
