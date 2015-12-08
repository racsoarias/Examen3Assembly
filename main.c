#include <gtk/gtk.h>
#include <stdio.h>
#include <windows.h>
#include <stdlib.h>

extern int player(int);

void sleep (unsigned milliseconds){
    Sleep (milliseconds);
}

static void button_clicked(GtkWidget* widget, gpointer data){
    gtk_label_set_text(GTK_LABEL(data),"Funciona");
}

static void check_state(GtkWidget* widget, gpointer data){
    if (gtk_toggle_button_get_active(GTK_TOGGLE_BUTTON_CLASS(widget))){
        g_print("Act");
    }else{
        g_print("Unact");
    }
}

static void fin (int opt, int win){

    char c [4];
    itoa (win,c,10);
    printf ("%s\n",c);

    char *str = "   Fin del juego! Gano el jugador  ";
    char *str1;
    char str2[60] = "   Fin del juego! Pierdes, la computadora ha ganado!   ";
    char str3[60] = "   Empate, el juego finaliza sin ganadores :(   ";

    str1 = malloc(strlen(str)+1+4);
    strcpy(str1, str);
    strcat(str1, c);

    GtkWidget *window, *label;
    window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
    gtk_window_set_title (GTK_WINDOW (window),"Examen 3 - Gato");
    gtk_window_set_position(GTK_WINDOW (window),GTK_WIN_POS_CENTER);
    g_signal_connect(window, "delete-event", G_CALLBACK(gtk_main_quit),NULL);
    gtk_widget_set_size_request(window,100,100);
    label = gtk_label_new("Fin del juego");


    if (win == 1){
        label = gtk_label_new(str1);
    }else if(win == 2 && opt ==1){
        label = gtk_label_new(str1);
    }else if(win == 2 && opt ==2){
        label = gtk_label_new(str2);
    }else if(win ==3){
        label = gtk_label_new(str3);
    }

    gtk_container_add(GTK_CONTAINER(window),label);
    gtk_widget_show_all(window);
    gtk_main();
}

void jugar(){

    GtkWidget *window, *label,*button, *table, *toggle;
    window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
    gtk_window_set_title (GTK_WINDOW (window),"Examen 3 - Gato");
    gtk_window_set_position(GTK_WINDOW (window),GTK_WIN_POS_CENTER);
    g_signal_connect(window, "delete-event", G_CALLBACK(gtk_main_quit),NULL);
    gtk_widget_set_size_request(window,100,100);

    table = gtk_table_new (3,3,0);

    toggle = gtk_toggle_button_new_with_mnemonic(" 1 ");
    g_signal_connect(toggle,"toggled",G_CALLBACK(check_state),NULL);
    gtk_table_attach(GTK_TABLE(table),toggle,0,1,0,1,GTK_FILL, GTK_FILL,0,0);
    toggle = gtk_toggle_button_new_with_mnemonic(" 2 ");
    g_signal_connect(toggle,"toggled",G_CALLBACK(check_state),NULL);
    gtk_table_attach(GTK_TABLE(table),toggle,1,2,0,1,GTK_FILL, GTK_FILL,0,0);
    toggle = gtk_toggle_button_new_with_mnemonic(" 3");
    g_signal_connect(toggle,"toggled",G_CALLBACK(check_state),NULL);
    gtk_table_attach(GTK_TABLE(table),toggle,2,3,0,1,GTK_FILL, GTK_FILL,0,0);
    toggle = gtk_toggle_button_new_with_mnemonic(" 4 ");
    g_signal_connect(toggle,"toggled",G_CALLBACK(check_state),NULL);
    gtk_table_attach(GTK_TABLE(table),toggle,0,1,1,2,GTK_FILL, GTK_FILL,0,0);
    toggle = gtk_toggle_button_new_with_mnemonic(" 5 ");
    g_signal_connect(toggle,"toggled",G_CALLBACK(check_state),NULL);
    gtk_table_attach(GTK_TABLE(table),toggle,1,2,1,2,GTK_FILL, GTK_FILL,0,0);
    toggle = gtk_toggle_button_new_with_mnemonic(" 6 ");
    g_signal_connect(toggle,"toggled",G_CALLBACK(check_state),NULL);
    gtk_table_attach(GTK_TABLE(table),toggle,2,3,1,2,GTK_FILL, GTK_FILL,0,0);
    toggle = gtk_toggle_button_new_with_mnemonic(" 7 ");
    g_signal_connect(toggle,"toggled",G_CALLBACK(check_state),NULL);
    gtk_table_attach(GTK_TABLE(table),toggle,0,1,2,3,GTK_FILL, GTK_FILL,0,0);
    toggle = gtk_toggle_button_new_with_mnemonic(" 8 ");
    g_signal_connect(toggle,"toggled",G_CALLBACK(check_state),NULL);
    gtk_table_attach(GTK_TABLE(table),toggle,1,2,2,3,GTK_FILL, GTK_FILL,0,0);
    toggle = gtk_toggle_button_new_with_mnemonic(" 9 ");
    g_signal_connect(toggle,"toggled",G_CALLBACK(check_state),NULL);
    gtk_table_attach(GTK_TABLE(table),toggle,2,3,2,3,GTK_FILL, GTK_FILL,0,0);

    gtk_container_add(GTK_CONTAINER(window),table);
    gtk_widget_show_all(window);
    gtk_main();

}

static int Single_Player(){
    jugar();
    return 1;
}

static int Multi_Player(){
    jugar();
    return 2;
}

int main(int argc, const char* argv[]){
    int opt =0, win =0;

    gtk_init(&argc, &argv);
    GtkWidget *window, *label,*button, *table, *toggle;

    window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
    gtk_window_set_title (GTK_WINDOW (window),"Examen 3 - Gato");
    gtk_window_set_position(GTK_WINDOW (window),GTK_WIN_POS_CENTER);
    g_signal_connect(window, "delete-event", G_CALLBACK(gtk_main_quit),NULL);
    gtk_widget_set_size_request(window,300,0);
    table = gtk_table_new (2,2,0);

    label = gtk_label_new("Tipo de juego:");
    gtk_table_attach(GTK_TABLE(table),label,0,1,0,1,GTK_FILL, GTK_FILL,0,0);
    button = gtk_button_new_with_label("1) Single Player");
    g_signal_connect(button, "clicked", G_CALLBACK(opt = Single_Player),NULL);
    gtk_table_attach(GTK_TABLE(table),button,0,1,1,2,GTK_FILL, GTK_FILL,0,0);
    button = gtk_button_new_with_label("2) Multiplayer");
    g_signal_connect(button, "clicked", G_CALLBACK(opt = Multi_Player),NULL);
    gtk_table_attach(GTK_TABLE(table),button,1,2,1,2,GTK_FILL, GTK_FILL,0,0);

    gtk_container_add(GTK_CONTAINER(window),table);
    gtk_widget_show_all(window);
    gtk_main();

    win = player(opt);
    fin (opt, win);
    sleep(2000);
    return 0;
}
