extends CharacterBody2D

#preloads
var showDamagePath= preload("res://Scenes/GUI_UI/UtilitiesUI/show_damage_taken.tscn")
#instancias
var basicUtilitiesInstance= basicUtilities.new()


#Variables ints
var nivel
var vida= 20
var ataqueMaximo= 5
var ataqueMinimo= 10
var ataqueFinal
var velocidadFinal
var velocidadMaxima= 200
var velocidadMinima= 150

#Variables flotantes
var playerPosition= Vector2(0,0)
var velocidadRotacion= 6.0

#Variable bolleans
var death= false
var playerDeath= false


func _ready():
	definirDatosRandomizados()

func _process(delta):
	if death == false and playerDeath == false:
		seguirAlPlayer(delta)
	if playerDeath == true:
		alejarseDelPlayer()

func alejarseDelPlayer():
	playerPosition= position - GLOBALMANAGER.posicionGlobalPersonaje
	velocity = playerPosition.normalized() * velocidadFinal
	move_and_slide()

func seguirAlPlayer(delta):
	playerPosition= GLOBALMANAGER.posicionGlobalPersonaje - position
	targetPlayerGraphic(delta)
	velocity = playerPosition.normalized() * velocidadFinal
	move_and_slide()
func targetPlayerGraphic(delta):
	var anguloA= $".".transform.x.angle_to(playerPosition)
	$".".rotate(sign(anguloA) * min(delta * velocidadRotacion, abs(anguloA)))


func randomizarRangoAtaque():
	ataqueFinal= basicUtilitiesInstance.randomizeRangeNumber(ataqueMinimo,ataqueMaximo)

func definirDatosRandomizados():
	velocidadFinal= basicUtilitiesInstance.randomizeRangeNumber(velocidadMinima,velocidadMaxima)




func showDamage(damage,critic):
	var showDamageInstance= showDamagePath.instantiate()
	showDamageInstance.showDamage(damage,critic)
	showDamageInstance.pos = $Marker2D.global_position
	get_parent().add_child(showDamageInstance)
func _on_slow_movement_timeout():
	velocidadFinal = velocidadFinal + 75



func _on_atk_area_area_entered(area):
	if death== true:
		pass
	else:
		randomizarRangoAtaque()
		area.takeDamage(ataqueFinal,$".".position)


func playerIsDeath():
	playerDeath= true

func deathStatus():
	death= true
	disabledAreas()
	$animationEnemy.play("deathAnimation")
	$deathTimer.start()
func disabledAreas():
	$hitArea.set_collision_layer_value(3,false)
	$atkArea.set_collision_layer_value(5,false)
func _on_death_timer_timeout():
	queue_free()
