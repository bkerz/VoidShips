extends Area2D

func takeDamageBullet(damage,critic):
	var aux= $"..".vida
	if aux <= damage:
		$"..".deathStatus()
		$"..".showDamage(damage,critic)
	else:
		$"..".vida = aux - damage
		$"..".showDamage(damage,critic)
		$"..".velocidadFinal = $"..".velocidadFinal - 45
		$"../animationEnemy".play("takeDamage")
		$"../slowMovement".start()
