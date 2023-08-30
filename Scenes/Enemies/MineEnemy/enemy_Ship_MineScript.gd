extends CharacterBody2D

#Variables
var playerPosition= Vector2(0,0)
var vida= 20
var ataqueMaximo= 5
var ataqueMinimo= 10
var velocidad= 150
var velocidadRotacion= 6.0


func _ready():
	pass

func _process(delta):
	#var angle= (playerPosition - self.global_position).angle()

	playerPosition= GLOBALMANAGER.posicionGlobalPersonaje - position
	targetPlayerGraphic(delta)
	velocity = playerPosition.normalized() * velocidad
	move_and_slide()

func voltearSprite():
	if GLOBALMANAGER.posicionGlobalPersonaje.x < position.x:
		$Sprite2D.flip_h= false
	if GLOBALMANAGER.posicionGlobalPersonaje.x > position.x:
		$Sprite2D.flip_h= true
		

func epicDeath():
	queue_free()

func targetPlayerGraphic(delta):
	var anguloA= $".".transform.x.angle_to(playerPosition)
	$".".rotate(sign(anguloA) * min(delta * velocidadRotacion, abs(anguloA)))
