extends Area2D



func takeDamageBullet(damage,critic):
	var aux= $"..".vida
	if aux <= damage:
		$"..".epicDeath()
		$"..".showDamage(damage,critic)
	else:
		$"..".vida = aux - damage
		$"..".showDamage(damage,critic)
		$"..".velocidadFinal = $"..".velocidadFinal - 75
		$"../animationEnemy".play("takeDamage")
		$"../slowMovement".start()
