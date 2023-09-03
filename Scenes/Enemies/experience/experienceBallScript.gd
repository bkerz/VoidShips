extends CharacterBody2D

#VARIABLES
var barraDeExperiencia:= Vector2()

#VARIABLES INT
var amount= 0
var speed= 500

#VARIABLES BOOLEANS
var experienceTaken= false

func _process(delta):
	if experienceTaken == true:
		velocity= barraDeExperiencia.normalized() * speed
		move_and_slide()
	else:
		pass

func _on_area_experience_ball_area_entered(area):
	barraDeExperiencia= Vector2(570,26) - position
	experienceTaken= true

func takeExperience():
	get_tree().call_group("barTakenExperience","takeExperience",amount)
	queue_free()
