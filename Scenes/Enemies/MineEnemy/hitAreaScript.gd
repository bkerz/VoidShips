extends Area2D



func takeDamageBullet(damage,critic):
	var aux= $"..".vida
	if aux <= damage:
		$"..".epicDeath()
		$"..".showDamage(damage,critic)
	else:
		$"..".vida = aux - damage
		$"..".showDamage(damage,critic)
