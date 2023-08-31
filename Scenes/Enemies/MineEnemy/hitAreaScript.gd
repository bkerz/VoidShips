extends Area2D

var showDamagePath= preload("res://Scenes/GUI_UI/UtilitiesUI/show_damage_taken.tscn")

func takeDamageBullet(damage):
	var aux= $"..".vida
	if aux <= damage:
		$"..".epicDeath()
	else:
		$"..".vida = aux - damage
		showDamage(damage)

func showDamage(damage):
	var showDamageInstance= showDamagePath.instantiate()
	showDamageInstance.showDamage(damage,false)
	showDamageInstance.position = $"../Marker2D".position
	get_parent().add_child(showDamageInstance)
