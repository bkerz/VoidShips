extends Node2D


func _on_iniciar_button_down():
	get_tree().change_scene_to_file("res://Scenes/GUI_UI/SelectPlayerGUI/select_player.tscn")



func _on_cerrar_button_down():
	get_tree().quit()
