extends Node2D

#Pre cargo el path de la escena de un personaje
const playerPath= preload("res://Scenes/Players/Max´s/max_player.tscn")

func _ready():
	instanciarPersonaje()

#Instancio a un personaje tomando como referencia la eleccion (O numero) en el
#GlobalManager con un match
func instanciarPersonaje():
	var playerSeleccionado= GLOBALMANAGER.playerSeleccionado
	
	match playerSeleccionado:
		1:
			var playerInstance= playerPath.instantiate()
			add_child(playerInstance)
		0:
			print("Error al instanciar personaje: Personaje no seleccionado")
