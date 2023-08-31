extends CharacterBody2D

#Constantes
const bulletPath= preload("res://Scenes/Players/Bullets/bullet.tscn")

#Variables
var knockBack_vector= 0
var knockBack_force= .070

var vida
var ataqueMaximo=30
var ataqueMinimo=10
var speed = 400

#Variables Booleans
var activateKnockBack= false
var posibleKnockBack= true


func _ready():
	vida = GLOBALMANAGER.playerMaxLife
	asignarHud()

#Detecta si se esta moviendo usando W/A/S/D como referencia
func _input(event):
	var input_direction = Input.get_vector("A","D","W","S")
	if event is InputEventMouseButton and event.is_action_pressed("ui_Mouse_Left"):
		get_tree().call_group("hudButtonsDetectNormalAttack","reflex")
		shootBullet()
	#Le paso la posicion del player
	GLOBALMANAGER.posicionGlobalPersonaje = global_position
	velocity = input_direction * speed

func _process(delta):
	rotarNavePuntero()
	$areaDeAtaqueRange.look_at(get_global_mouse_position())
	_input(input_event)
	if activateKnockBack== true and posibleKnockBack== true:
		aplicate_KnockBack()
	else:
		move_and_slide()


#Funciones basicas para animar al personaje segun donde este viendo
func rotarNavePuntero():
	$".".look_at(get_global_mouse_position())


#Asigna la escena que representa al HUD del personaje
func asignarHud():
	var hudPath= preload("res://Scenes/GUI_UI/PlayerGUI/playerUI.tscn")
	var hudInstance= hudPath.instantiate()
	get_parent().add_child(hudInstance)
	get_tree().call_group("gui_Info","actualizeHpBar",float(vida))


#Instancia y "dispara" una escena de bullet dandosela como hijo a su padre
func shootBullet():
	var bulletInstance= bulletPath.instantiate()
	#bulletInstance.aimPos = get_local_mouse_position()
	bulletInstance.position= $".".position
	get_parent().add_child(bulletInstance)

#Le doy al personaje un KCOKBACK del enemigo
func knockBackTake(enemyPosition):
	#Toma al vector y lo iguala a la direccion de mi position menos la del enemigo
	#por la fuerza definida en KnockBack_Force
	knockBack_vector= ($".".global_position - enemyPosition) * knockBack_force
	#activa el knock_Back para simular el emupje
	activateKnockBack= true
	#activo su invulnerabilidad y la duracion del knockBack
	$invincivilityTimer.start()
	$AnimationPlayer2.play("invisibilityAnimation")
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
	queue_free()
