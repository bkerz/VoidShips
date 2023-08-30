extends Area2D


func takeDamageBullet(damage):
	var aux= $"..".vida
	if aux <= damage:
		$"..".epicDeath()
	else:
		$"..".vida = aux - damage
