extends Node2D

#CONSTANTES INTS
const lifeMaxPJ= GLOBALMANAGER.playerMaxLife
const experienceMaxValue= 1000

#Strings
const levelLabelText= "LVL: "
const liveLabelText= "HP: "


func _ready():
	$HudUI/LVL_Label/levelBar.max_value= experienceMaxValue
	print($HudUI/LVL_Label/levelBar.global_position)
	$HudUI/HP_Label/HP_Bar.max_value= GLOBALMANAGER.playerMaxLife
	global_position = Vector2(0,0)

func actualizeLevelPlayer(amount):
	$HudUI/LVL_Label.text = levelLabelText + str(amount)

func actualizeExperienceBar(amount):
	var aux= $HudUI/LVL_Label/levelBar.value
	if aux >= experienceMaxValue:
		$HudUI/LVL_Label/levelBar.set_value_no_signal(0)
		get_tree().call_group("playerGroup","levelUpPlayer")
	else:
		$HudUI/LVL_Label/levelBar.set_value_no_signal(float(aux + amount * 5))

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


func _on_take_experience_area_entered(area):
	area.takeExperience()
func takeExperience(amount):
	actualizeExperienceBar(amount)




func _on_draw():
	print("mas nivel")
