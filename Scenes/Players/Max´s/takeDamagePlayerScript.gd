extends Area2D

var aux
var invincible= false

func takeDamage(damage,enemyPosition):
	aux= $"..".vida
	if aux <= damage:
		$"..".deadPlayer()
	if invincible== false:
		$"..".vida = $"..".vida - damage
		$"..".knockBackTake(enemyPosition)
	else:
		pass
