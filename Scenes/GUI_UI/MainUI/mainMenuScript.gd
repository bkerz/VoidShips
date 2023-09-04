extends Node2D


func _ready():
	$CustomPointer.type = 1
	
func _process(delta):
	if $Control/Iniciar.is_hovered() or $Control/Cerrar.is_hovered():
		get_tree().call_group("PointerGroup","ShowActive")
	else:
		get_tree().call_group("PointerGroup","ShowInactive")

func _on_iniciar_button_down():
	get_tree().change_scene_to_file("res://Scenes/GUI_UI/SelectPlayerGUI/select_player.tscn")


func _on_cerrar_button_down():
	get_tree().quit()
