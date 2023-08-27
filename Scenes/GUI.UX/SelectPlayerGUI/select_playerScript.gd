extends Node2D


#Desactiva el boton para iniciar el mundo, hasta que selecciones un personaje
func _ready():
	$EscenaGUI/iniciarElMundo.disabled= true

#Notifica al GLOBALMANAGER que se selecciono un personaje y habilita el boton 
#De iniciar el mundo
func _on_max_seleccion_button_down():
	GLOBALMANAGER.playerSeleccionado = 1
	$EscenaGUI/iniciarElMundo.disabled= false

#Inicia el mundo donde aparece el player y enemigos
func _on_button_2_button_down():
	get_tree().change_scene_to_file("res://Scenes/World/FirstWorld/first_world.tscn")

#Vuelve al main menu
func _on_volver_al_menu_inicial_button_down():
	get_tree().change_scene_to_file("res://Scenes/GUI.UX/MainGUI/mainMenu.tscn")
