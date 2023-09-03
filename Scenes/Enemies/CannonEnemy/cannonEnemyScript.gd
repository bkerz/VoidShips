extends CharacterBody2D

var showDamagePath= preload("res://Scenes/GUI_UI/UtilitiesUI/show_damage_taken.tscn")
var bulletPath= preload("res://Scenes/Players/Bullets/bullet.tscn")

#Variables Bo0leans
var distanciaMinima= false
var distanciaCritica= false
var distanciaAsegurada= true
var tomandoDistancia= false
var playerDeath= false
var death= false

#Variables
var playerPosition= Vector2(0,0)
var nivel
var vida= 15
var ataqueMaximo= 5
var ataqueMinimo= 10
var ataqueFinal
var velocidadFinal
var velocidadMaxima= 270
var velocidadMinima= 200
var velocidadRotacion= 6.0
var basicUtilitiesInstance= basicUtilities.new()


func _ready():
	definirDatosRandomizados()

func _process(delta):
	if death== true:
		pass
	elif playerDeath== true:
		alejarseAlPlayer(delta)
	else:
		playerPosition= GLOBALMANAGER.posicionGlobalPersonaje - position
		targetPlayerGraphic(delta)
		if distanciaMinima == false and distanciaCritica == false and distanciaAsegurada == true and tomandoDistancia == false:
			moverseAlPlayer(delta)
		if distanciaMinima == true and distanciaCritica == true and distanciaAsegurada == false:
			alejarseAlPlayer(delta)


func moverseAlPlayer(delta):
	velocity = playerPosition.normalized() * velocidadFinal
	move_and_slide()

func alejarseAlPlayer(delta):
	playerPosition= position - GLOBALMANAGER.posicionGlobalPersonaje
	velocity = playerPosition.normalized() * velocidadFinal
	move_and_slide()

func quedarseQuieto(delta):
	pass


func randomizarRangoAtaque():
	ataqueFinal= basicUtilitiesInstance.randomizeRangeNumber(ataqueMinimo,ataqueMaximo)

func definirDatosRandomizados():
	velocidadFinal= basicUtilitiesInstance.randomizeRangeNumber(velocidadMinima,velocidadMaxima)
	#randomizeRangeNumber.randomize()
	#velocidadFinal= randomizeRangeNumber.randi_range(velocidadMinima,velocidadMaxima)


#ENTRA en la zona
func dentroDistanciaCritica():
	distanciaAsegurada= false
	distanciaCritica= true
func detenerMovimiento():
	$shootCoolDown.start()
	distanciaMinima= true
	
#SALE de la zona
func fueraDistanciaCritica():
	distanciaAsegurada= true
	distanciaCritica= false
func reanudarMovimiento():
	distanciaMinima= false



#TOMANDO distancia
func _on_tomar_distancia_timeout():
	distanciaAsegurada= true


func playerIsDeath():
	$shootCoolDown.stop()
	playerDeath= true

func deathStatus():
	death= true
	$shootCoolDown.stop()
	disabledAreas()
	$deathEnemySFX.play()
	$animationEnemy.play("deathAnimation")
	$deathTimer.start()
func disabledAreas():
	$hitArea.set_collision_layer_value(3,false)
	$detectLimitAreaPlayer.set_collision_layer_value(7,false)
func _on_death_timer_timeout():
	queue_free()

func endGameProcess():
	death= true
	$shootCoolDown.stop()
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


func shootBullet():
	var bulletInstance= bulletPath.instantiate()
	bulletInstance.maxDamage= ataqueMaximo
	bulletInstance.minDamage= ataqueMinimo
	bulletInstance.definirEnemigo(5)
	var aux= GLOBALMANAGER.posicionGlobalPersonaje - position
	bulletInstance.aimPos= aux
	bulletInstance.position= $Front.global_position
	get_parent().add_child(bulletInstance)
func _on_shoot_cool_down_timeout():
	shootBullet()

func _on_atk_area_area_entered(area):
	randomizarRangoAtaque()
	area.takeDamage(ataqueFinal,$".".position)



func _on_slow_movement_timeout():
	velocidadFinal = velocidadFinal + 75



