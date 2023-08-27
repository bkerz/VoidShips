extends CharacterBody2D

#Variables
var playerPosition= Vector2(0,0)
var velocidad= 150


func _ready():
	$AnimationPlayer.play("Walk")

func _process(delta):
	playerPosition= GLOBALMANAGER.posicionGlobalPersonaje - position
	voltearSprite()
	velocity = playerPosition.normalized() * velocidad
	move_and_slide()

func voltearSprite():
	if GLOBALMANAGER.posicionGlobalPersonaje.x < position.x:
		$Sprite2D.flip_h= false
	if GLOBALMANAGER.posicionGlobalPersonaje.x > position.x:
		$Sprite2D.flip_h= true

