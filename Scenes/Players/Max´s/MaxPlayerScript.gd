extends CharacterBody2D

#Constantes
const bulletPath= preload("res://Scenes/Players/Bullets/bullet.tscn")

#Variables
var vida= 100
var ataqueMaximo=30
var ataqueMinimo=10
var speed = 400

#Variables Booleans

func _ready():
	asignarHud()

#Detecta si se esta moviendo usando W/A/S/D como referencia
func _input(event):
	var input_direction = Input.get_vector("A","D","W","S")
	if event is InputEventMouseButton and event.is_action_pressed("ui_Mouse_Left"):
		shootBullet()
	#Le paso la posicion del player
	GLOBALMANAGER.posicionGlobalPersonaje = global_position
	velocity = input_direction * speed

func _process(delta):
	animarLadoCaminarPlayerX()
	#$Aim.look_at(get_global_mouse_position())
	$areaDeAtaqueRange.look_at(get_global_mouse_position())
	_input(input_event)
	move_and_slide()

#Funciones basicas para animar al personaje segun donde este viendo
func animarLadoCaminarPlayerX():
	var areaDeAtaquePositionX= $areaDeAtaqueRange/colisionDeAtaque.global_position.x
	var personajePositionX= global_position.x

	if Input.is_action_pressed("W"):
		$AnimationPlayer.play("Arriba")
	elif Input.is_action_just_released("W"):
		$AnimationPlayer.play("RESET")
	elif Input.is_action_pressed("S"):
		$AnimationPlayer.play("Abajo")
	elif Input.is_action_just_released("S"):
		$AnimationPlayer.play("RESET")
	elif Input.is_action_pressed("A"):
		$AnimationPlayer.play("Izquierda")
	elif Input.is_action_just_released("A"):
		$AnimationPlayer.play("RESET")
	elif Input.is_action_pressed("D"):
		$AnimationPlayer.play("Derecha")
	elif Input.is_action_just_released("D"):
		$AnimationPlayer.play("RESET")

#Asigna la escena que representa al HUD del personaje
func asignarHud():
	var hudPath= preload("res://Scenes/GUI_UI/PlayerGUI/playerUI.tscn")
	var hudInstance= hudPath.instantiate()
	get_parent().add_child(hudInstance)

func shootBullet():
	var bulletInstance= bulletPath.instantiate()
	bulletInstance.aimPos = get_local_mouse_position()
	bulletInstance.position= $".".position
	get_parent().add_child(bulletInstance)

