extends CharacterBody2D
const utilitiesPath= preload("res://Classes/basicUtilities.gd")

var pos
var direction= Vector2(0,-1)
var speed= 25
var dissapearBool= false
var idleTimer= true

func _ready():
	var utilitiesClass= utilitiesPath.new()
	position = pos
	scale= Vector2(0,0)
	rotate(utilitiesClass.randomizeRangeNumberFloat(0.2,-0.2))
	$appears.start()

func _process(delta):
	if dissapearBool == false:
		scale= scale + Vector2(0.08,0.08)
	if dissapearBool == true and idleTimer == false:
		scale= scale - Vector2(0.1,0.1)
	velocity = direction * speed
	move_and_slide()

func showDamage(amountDamage,maxDamage):
	if maxDamage== true:
		$turnTo.play("red")
	else:
		pass
	$Label.text = str(amountDamage)
	
func desaparecer():
	queue_free()
	
func _on_appears_timeout():
	$idle.start()
	dissapearBool= true
func _on_idle_timeout():
	$disappear.start()
	idleTimer= false
func _on_disappear_timeout():
	desaparecer()
