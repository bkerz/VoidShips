extends CharacterBody2D

#Constantes


#Variables
var speed = 400

func _ready():
	print(str(position))

func _input(event):
	var input_direction = Input.get_vector("A","D","W","S")
	GLOBALMANAGER.posicionGlobalPersonaje = global_position
	velocity = input_direction * speed

func _process(delta):
	$areaDeAtaque.look_at(get_global_mouse_position())
	_input(input_event)
	move_and_slide()
