extends CharacterBody2D


#Constantes
const bulletPath= preload("res://Scenes/Players/Bullets/bullet.tscn")
const buffingClassInstance= preload("res://Classes/buff_Debuff.gd")

#Variables
var knockBack_vector= 0
var knockBack_force= .070

var nivel= 0
var vida
var ataqueMaximo=15
var ataqueMinimo=5
var speed = 400

#Variables Booleans
var selfDeath= false
var holdLeftClick= false
var coolDownLeftClick= false
var activateKnockBack= false
var posibleKnockBack= true


func _ready():
	vida = GLOBALMANAGER.playerMaxLife
	asignarHud()

#Detecta si se esta moviendo usando W/A/S/D como referencia
func _input(event):
		var input_direction = Input.get_vector("A","D","W","S")
		
		#Detecta si se clickeo el boton izquierdo del mouse
		if event is InputEventMouseButton and event.is_action_pressed("ui_Mouse_Left"):
			#si es asi, activa la vandera de que se esta manteniendo
			holdLeftClick= true
		if event is InputEventMouseButton and event.is_action_released("ui_Mouse_Left"):
			#si se desclickea el boton izquierdo, baja esa bandera para indicar que 
			#dejo de mantenerse
			holdLeftClick= false
		#Le paso la posicion del player
		GLOBALMANAGER.posicionGlobalPersonaje = global_position
		velocity = input_direction * speed

func _process(delta):
	if selfDeath == false:
		rotarNavePuntero()
		$areaDeAtaqueRange.look_at(get_global_mouse_position())
		_input(input_event)
		#detecta si se mantiene el click izquierdo y si el cooldown de disparo se 
		#terminó
		if holdLeftClick == true and coolDownLeftClick == false:
			shootBullet()
			#se activa del cooldown indicando que se esta enfriando para el siguiente
			#disparo
			coolDownLeftClick= true
			$coolDownLeftClick.start()
		if activateKnockBack== true and posibleKnockBack== true:
			aplicate_KnockBack()
		else:
			move_and_slide()
	else:
		pass


#Funciones basicas para animar al personaje segun donde este viendo
func rotarNavePuntero():
	$".".look_at(get_global_mouse_position())


#Asigna la escena que representa al HUD del personaje
func asignarHud():
	var hudPath= preload("res://Scenes/GUI_UI/PlayerGUI/playerUI.tscn")
	var hudInstance= hudPath.instantiate()
	get_parent().add_child(hudInstance)
	get_tree().call_group("gui_Info","actualizeHpBar",float(vida))


func levelUpPlayer():
	nivel= nivel + 1
	get_tree().call_group("gui_Info","actualizeLevelPlayer",nivel)

#Instancia y "dispara" una escena de bullet dandosela como hijo a su padre
func shootBullet():
	var bulletInstance= bulletPath.instantiate()
	bulletInstance.maxDamage= ataqueMaximo
	bulletInstance.minDamage= ataqueMinimo
	bulletInstance.definirEnemigo(3)
	bulletInstance.position= $".".position
	get_parent().add_child(bulletInstance)
func _on_cool_down_left_click_timeout():
	#Termina el cooldown de el disparo
	coolDownLeftClick= false

#Le doy al personaje un KCOKBACK del enemigo
func knockBackTake(enemyPosition):
	#Toma al vector y lo iguala a la direccion de mi position menos la del enemigo
	#por la fuerza definida en KnockBack_Force
	knockBack_vector= ($".".global_position - enemyPosition) * knockBack_force
	#activa el knock_Back para simular el emupje
	activateKnockBack= true
	#activo su invulnerabilidad y la duracion del knockBack
	$invincivilityTimer.start()
	$animatorPlayer.play("invisibilityAnimation")
	$knockBackDuration.start()
	invincivility()
func invincivility():
	#Hago que en el area de rakeDamage no puedan hacerme daño
	$takeDamagePlayer.invincible= true
	#Desactivo el area para no recivir daño
	$takeDamagePlayer/CollisionShape2D.disabled= true
	
#desactiva el la simulacion de empuje
func _on_knock_back_duration_timeout():
	activateKnockBack= false
func _on_invincivility_timer_timeout():
	#vuelve a darme la posibilidad de que se simule el empuje
	posibleKnockBack= true
	#activa de forma directa el poder recivir daño
	$takeDamagePlayer.invincible= false
	#activa la zona para detectar otro golpe
	$takeDamagePlayer/CollisionShape2D.disabled= false
#"Simula" el empuje
func aplicate_KnockBack():
	velocity = knockBack_vector * 180
	move_and_slide()


#desaparece al personaje del arbol de escena
func deadPlayer():
	selfDeath= true
	$deathTime.start()
	$deathPlayerSFX.play()
	get_tree().call_group("deathMenuUi","aparecer")
	get_tree().call_group("onPlayerDeath","playerIsDeath")
func _on_death_time_timeout():
	queue_free()


func _on_stop_enemy_movement_area_entered(area):
	area.detenerMovimiento()
func _on_stop_enemy_movement_area_exited(area):
	area.reanudarMovimiento()


func _on_war_of_enemy_area_entered(area):
	area.dentroDistanciaCritica()
func _on_war_of_enemy_area_exited(area):
	area.fueraDistanciaCritica()

func _on_area_de_ataque_range_area_entered(area):
	area.takeExperience()

func endGameProcess():
	selfDeath = true


func buff():
	vida= buffingClassInstance.aumentoDeVidaDiezPuntos(vida)
