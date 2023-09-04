extends Node2D

var scaler = Vector2(0.01,0.01)
var type = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$InGame.visible=false
	$InMenu.visible=true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position=get_global_mouse_position()
	if type ==1:
		$InGame.visible=false
		$InMenu.visible=true
	if type==2:
		$InGame.visible=true
		$InMenu.visible=false
		$InGame/Hexagon1.rotation_degrees +=1
		$InGame/Hexagon2.rotation_degrees -=1
		$InGame/Center.scale -= scaler
		if $InGame/Center.scale.x <= 0.75 or $InGame/Center.scale.x >= 1:
			scaler = scaler * -1

func ShowActive():
	$InMenu/Active.visible=true
	$InMenu/Inactive.visible=false
	
func ShowInactive():
	$InMenu/Active.visible=false
	$InMenu/Inactive.visible=true
