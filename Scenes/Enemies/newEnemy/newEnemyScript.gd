extends CharacterBody2D

var vida= 0
var playerPosition= Vector2(0,0)
var speed= 200

#Variables booleana
var playerDeath= false

func _ready():
	pass

func _process(delta):
	
	if playerDeath == true:
		escalarEnemigo()
	else:
		pass
	
	playerPosition= GLOBALMANAGER.posicionGlobalPersonaje - self.position
	velocity = playerPosition.normalized() * speed
	move_and_slide()


func escalarEnemigo():
	scale= Vector2(3,3)

func deathPlayer():
	playerDeath= true

func takeDamage():
	pass

func hitPlayer():
	pass

func dead():
	pass
