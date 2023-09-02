extends CharacterBody2D

var vida= 0
var playerPosition= Vector2(0,0)
var speed= 200

#Variables booleana


func _ready():
	pass

func _process(delta):
	
	playerPosition= GLOBALMANAGER.posicionGlobalPersonaje - self.position
	velocity = playerPosition.normalized() * speed
	move_and_slide()






func deathPlayer():
	escalarEnemigo()
func escalarEnemigo():
	scale= Vector2(3,3)




func takeDamage():
	pass

func hitPlayer():
	pass

func dead():
	pass
