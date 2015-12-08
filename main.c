//#include <gtk/gtk.h>
#include <stdio.h>
#include <windows.h>

extern int player(int);

void sleep (unsigned milliseconds){
    Sleep (milliseconds);
}

int main(){
    int opt =0, win =0;
    /*
    gtk_init(&argc, &argv);
    GtkWidget *window;
    window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
    g_signal_connect(window, "delete-event", G_CALLBACK(gtk_main_quit),NULL);
    gtk_widget_show(window);
    gtk_main();
    */

    printf("Tipo de juego \n  1)Single Player \n  2)Multiplayer \n");
    scanf("%d", &opt);

    if (opt == 1 || opt == 2){
        win = player(opt);
    }else{
        printf("Seleccion invalida, salgo de juego");
    }

    if (win == 1){
        printf("Fin del juego! Gano el jugador %d\n", win);
    }else if(win == 2 && opt ==1){
        printf("Fin del juego! Pierdes, la computadora ha ganado!\n");
    }else if(win == 2 && opt ==2){
        printf("Fin del juego! Gano el jugador %d\n", win);
    }else if(win ==3){
        printf("Empate, el juego finaliza sin ganadores :(\n");
    }

    sleep(4000);
    return 0;
}
