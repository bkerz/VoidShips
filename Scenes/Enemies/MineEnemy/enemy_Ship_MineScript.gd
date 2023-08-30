extends CharacterBody2D


#Variables
var playerPosition= Vector2(0,0)
var vida= 20
var ataqueMaximo= 5
var ataqueMinimo= 10
var velocidadFinal
var velocidadMaxima= 250
var velocidadMinima= 200
var velocidadRotacion= 6.0
var basicUtilitiesInstance= basicUtilities.new()


func _ready():
	definirDatosRandomizados()

func _process(delta):
	#var angle= (playerPosition - self.global_position).angle()

	playerPosition= GLOBALMANAGER.posicionGlobalPersonaje - position
	targetPlayerGraphic(delta)
	velocity = playerPosition.normalized() * velocidadFinal
	move_and_slide()

func voltearSprite():
	if GLOBALMANAGER.posicionGlobalPersonaje.x < position.x:
		$Sprite2D.flip_h= false
	if GLOBALMANAGER.posicionGlobalPersonaje.x > position.x:
		$Sprite2D.flip_h= true
		

func definirDatosRandomizados():
	velocidadFinal= basicUtilitiesInstance.randomizeRangeNumber(velocidadMinima,velocidadMaxima)
	#randomizeRangeNumber.randomize()
	#velocidadFinal= randomizeRangeNumber.randi_range(velocidadMinima,velocidadMaxima)

func epicDeath():
	queue_free()

func targetPlayerGraphic(delta):
	var anguloA= $".".transform.x.angle_to(playerPosition)
	$".".rotate(sign(anguloA) * min(delta * velocidadRotacion, abs(anguloA)))
