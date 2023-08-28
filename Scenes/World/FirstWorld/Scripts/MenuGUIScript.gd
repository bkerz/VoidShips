extends Control


func _on_seguir_button_down():
	$".".visible= false
	$"..".escapeMenuVisible= false

func _on_salir_button_down():
	get_tree().change_scene_to_file("res://Scenes/GUI_UI/MainUI/mainMenu.tscn")
