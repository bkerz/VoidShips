extends Node2D

#CONSTANTES INTS
const lifeMaxPJ= GLOBALMANAGER.playerMaxLife


#Strings
const levelLabelText= "LVL: "
const liveLabelText= "HP: "

#VARIABLES
var experienceMaxValue= 200


func _ready():
	$HudUI/LVL_Label/levelBar.max_value= experienceMaxValue
	$HudUI/HP_Label/HP_Bar.max_value= GLOBALMANAGER.playerMaxLife
	global_position = Vector2(0,0)
	$CustomPointer.type = 2

func actualizeLevelPlayer(amount):
	$HudUI/LVL_Label.text = levelLabelText + str(amount)

func actualizeExperienceBar(amount):
	var aux= $HudUI/LVL_Label/levelBar.value
	
	print(aux)
	if aux >= experienceMaxValue:
		$HudUI/LVL_Label/levelBar.set_value_no_signal(0)
		get_tree().call_group("playerGroup","levelUpPlayer")
		exponential()
	else:
		$HudUI/LVL_Label/levelBar.set_value_no_signal(float(aux + amount))

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


func exponential():
	experienceMaxValue= experienceMaxValue + (experienceMaxValue / 2)
	$HudUI/LVL_Label/levelBar.max_value= experienceMaxValue
	print(experienceMaxValue)
