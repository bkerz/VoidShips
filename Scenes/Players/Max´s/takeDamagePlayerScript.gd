extends Area2D

var aux
var invincible= false

func takeDamage(damage,enemyPosition):
	aux= $"..".vida
	if aux <= damage:
		$"..".deadPlayer()
		get_tree().call_group("gui_Info","actualizeHpBar",0)
	if invincible== false:
		$"..".vida = $"..".vida - damage
		get_tree().call_group("gui_Info","actualizeHpBar",float($"..".vida))
		$"..".knockBackTake(enemyPosition)
	else:
		pass
