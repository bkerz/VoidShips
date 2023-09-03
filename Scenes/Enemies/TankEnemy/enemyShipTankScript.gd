extends CharacterBody2D


#preloads
var showDamagePath= preload("res://Scenes/GUI_UI/UtilitiesUI/show_damage_taken.tscn")

#Variables
var playerPosition= Vector2(0,0)
var nivel
var givenExperience= 20
var vida= 100
var ataqueMaximo= 20
var ataqueMinimo= 15
var ataqueFinal
var velocidadFinal
var velocidadMaxima= 80
var velocidadMinima= 30
var velocidadRotacion= 6.0
var basicUtilitiesInstance= basicUtilities.new()


#Variable boleans
var playerDeath= false
var death= false

func _ready():
	definirDatosRandomizados()

func _process(delta):
	if death== false and playerDeath == false:
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
func voltearSprite():
	if GLOBALMANAGER.posicionGlobalPersonaje.x < position.x:
		$Sprite2D.flip_h= false
	if GLOBALMANAGER.posicionGlobalPersonaje.x > position.x:
		$Sprite2D.flip_h= true
		

func randomizarRangoAtaque():
	ataqueFinal= basicUtilitiesInstance.randomizeRangeNumber(ataqueMinimo,ataqueMaximo)

func definirDatosRandomizados():
	velocidadFinal= basicUtilitiesInstance.randomizeRangeNumber(velocidadMinima,velocidadMaxima)

func playerIsDeath():
	playerDeath= true


func deathStatus():
	death= true
	disabledAreas()
	$deathEnemySFX.play()
	$animationEnemy.play("deathAnimation")
	$deathTimer.start()
	dropExperience()
func disabledAreas():
	$hitArea.set_collision_layer_value(3,false)
	$atkArea.set_collision_layer_value(5,false)
func _on_death_timer_timeout():
	queue_free()
	
func endGameProcess():
	death= true
	disabledAreas()
	$animationEnemy.play("deathAnimation")
	$deathTimer.start()


func showDamage(damage,critic):
	var showDamageInstance= showDamagePath.instantiate()
	showDamageInstance.showDamage(damage,critic)
	showDamageInstance.pos = $Marker2D.global_position
	get_parent().add_child(showDamageInstance)

func targetPlayerGraphic(delta):
	var anguloA= $".".transform.x.angle_to(playerPosition)
	$".".rotate(sign(anguloA) * min(delta * velocidadRotacion, abs(anguloA)))

func dropExperience():
	get_parent().add_child(basicUtilitiesInstance.spawnExperienceBall($".".global_position,givenExperience))


func _on_atk_area_area_entered(area):
	if death== true:
		pass
	else:
		randomizarRangoAtaque()
		area.takeDamage(ataqueFinal,$".".position)


func _on_slow_movement_timeout():
	velocidadFinal = velocidadFinal + 1
