extends Node2D

#Strings
const liveLabelText= "HP: "
const lifeMaxPJ= GLOBALMANAGER.playerMaxLife

func _ready():
	$HudUI/HP_Label/HP_Bar.max_value= GLOBALMANAGER.playerMaxLife
	global_position = Vector2(0,0)

func actualizeHpBar(amount):
	$HudUI/HP_Label/HP_Bar.set_value_no_signal(amount)
	$HudUI/HP_Label.text = liveLabelText + str(amount)
	$HudUI/HP_Label/shakeHpBar.play("shakeAnimation")
	changeColorTo()

func changeColorTo():
	var aux
	if $HudUI/HP_Label/HP_Bar.value >= (lifeMaxPJ/2):
		$HudUI/HP_Label/turnColor.play("green")
	if $HudUI/HP_Label/HP_Bar.value <= (lifeMaxPJ/2):
		$HudUI/HP_Label/turnColor.play("yellow")
	if $HudUI/HP_Label/HP_Bar.value <= (lifeMaxPJ/4):
		$HudUI/HP_Label/turnColor.play("red")
