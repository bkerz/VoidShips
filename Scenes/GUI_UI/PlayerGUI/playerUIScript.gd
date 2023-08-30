extends Node2D

#Strings
const liveLabelText= "HP: "

func _ready():
	$HudUI/HP_Label/HP_Bar.max_value= GLOBALMANAGER.playerMaxLife
	global_position = Vector2(0,0)

func actualizeHpBar(amount):
	$HudUI/HP_Label/HP_Bar.set_value_no_signal(amount)
	$HudUI/HP_Label.text = liveLabelText + str(amount)
	$HudUI/HP_Label/shakeHpBar.play("shakeAnimation")
