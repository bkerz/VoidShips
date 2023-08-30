extends Node2D


#variables
var escapeMenuVisible= false

func _process(delta):
	vigilarMenuEscape()


func vigilarMenuEscape():
	if Input.is_action_just_pressed("ui_Escape"):
		if escapeMenuVisible == false:
			$MenuGUI.visible= true
			escapeMenuVisible= true
		else:
			$MenuGUI.visible= false
			escapeMenuVisible= false


func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Scenes/GUI_UI/MainUI/mainMenu.tscn")
