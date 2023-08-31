extends Sprite2D


func reflex():
	$"../AnimationPlayer".play("press")


func _on_animation_player_animation_finished(anim_name):
	if anim_name== "press":
		$"../ProgressBar".value= 0
