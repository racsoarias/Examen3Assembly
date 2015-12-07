//#include <gtk/gtk.h>
#include <stdio.h>
#include <windows.h>

extern void singlePlayer();
extern void multiPlayer();

void sleep (unsigned milliseconds){
    Sleep (milliseconds);
}

int main(){
    int num;

    printf("Tipo de juego \n  1)Single Player \n  2)Multiplayer \n");
    scanf("%d", &num);

    if (num == 1){
        singlePlayer();
    }else if (num == 2){
        multiPlayer();
    }else{
        printf("Selecciom invalida, salgo de juego");
    }

    sleep(2500);
    return 0;
}
