extends CharacterBody2D

#Constantes


#Variables
var speed = 400

#Variables Booleans
var dashUse= false


func _input(event):
	var input_direction = Input.get_vector("A","D","W","S")
	if dashUse == true:
		$AnimationPlayer2.play("dash")
	else:
		pass
	GLOBALMANAGER.posicionGlobalPersonaje = global_position
	velocity = input_direction * speed
	pass

func _process(delta):
	#print("Area ATK x Position: "+ str($areaDeAtaque/colisionDeAtaque.global_position.x))
	#print("mi X Vector: "+str(global_position.x))
	animarLadoCaminarPlayerX()
	$areaDeAtaque.look_at(get_global_mouse_position())
	_input(input_event)
	move_and_slide()

func animarLadoCaminarPlayerX():
	var areaDeAtaquePositionX= $areaDeAtaque/colisionDeAtaque.global_position.x
	var personajePositionX= global_position.x

	if Input.is_action_just_pressed("dash"):
		dashUse= true

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
		
#	if Input.is_action_pressed("WD"):
#		$AnimationPlayer.play("ArribaDerecha")
#	elif Input.is_action_just_released("WD"):
#		$AnimationPlayer.play("RESET")
#	elif Input.is_action_pressed("SA"):
#		$AnimationPlayer.play("AbajoIzquierda")
#	elif Input.is_action_just_released("SA"):
#		$AnimationPlayer.play("RESET")
#	elif Input.is_action_pressed("SD"):
#		$AnimationPlayer.play("AbajoDerecha")
#	elif Input.is_action_just_released("SD"):
#		$AnimationPlayer.play("RESET")
#	elif Input.is_action_pressed("AW"):
#		$AnimationPlayer.play("ArribaIzquierda")
#	elif Input.is_action_just_released("AW"):
#		$AnimationPlayer.play("RESET")


func _on_animation_player_2_animation_finished(anim_name):
	
	if anim_name == "dash":
		dashUse= false
