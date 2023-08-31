extends CharacterBody2D

#preloads
var showDamagePath= preload("res://Scenes/GUI_UI/UtilitiesUI/show_damage_taken.tscn")

#Variables
var playerPosition= Vector2(0,0)
var nivel
var vida= 20
var ataqueMaximo= 5
var ataqueMinimo= 10
var ataqueFinal
var velocidadFinal
var velocidadMaxima= 200
var velocidadMinima= 150
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
		

func randomizarRangoAtaque():
	ataqueFinal= basicUtilitiesInstance.randomizeRangeNumber(ataqueMinimo,ataqueMaximo)

func definirDatosRandomizados():
	velocidadFinal= basicUtilitiesInstance.randomizeRangeNumber(velocidadMinima,velocidadMaxima)
	#randomizeRangeNumber.randomize()
	#velocidadFinal= randomizeRangeNumber.randi_range(velocidadMinima,velocidadMaxima)

func epicDeath():
	queue_free()

func showDamage(damage,critic):
	var showDamageInstance= showDamagePath.instantiate()
	showDamageInstance.showDamage(damage,critic)
	showDamageInstance.pos = $Marker2D.global_position
	get_parent().add_child(showDamageInstance)

func targetPlayerGraphic(delta):
	var anguloA= $".".transform.x.angle_to(playerPosition)
	$".".rotate(sign(anguloA) * min(delta * velocidadRotacion, abs(anguloA)))


func _on_atk_area_area_entered(area):
	randomizarRangoAtaque()
	area.takeDamage(ataqueFinal,$".".position)


func _on_slow_movement_timeout():
	velocidadFinal = velocidadFinal + 75
