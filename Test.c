#include <gtk/gtk.h>
#include <stdio.h>
#include <windows.h>

void sleep (unsigned milliseconds){
    Sleep (milliseconds);
}

int main(int argc, char ** argv){
    int num;
    printf("Tipo de juego \n  1)Single Player \n  2)Multiplayer \n");
    scanf("%d", &num);
	if (num == 1){
        //int a = singlePlayer(10);
    }else if (num == 2){
        //int b = multiPlayer(10);
    }else{
        printf("Seleccion invalida, salgo de juego");
    }

    gtk_init(&argc, &argv);
    GtkWidget *window;
    window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
    g_signal_connect(window, "delete-event", G_CALLBACK(gtk_main_quit),NULL);
    gtk_widget_show(window);
    gtk_main();

	sleep(5000);
	return 0;
}
