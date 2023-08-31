extends CharacterBody2D

#func showDamagen(amountDamage,maxDamage):
#	$Label.text = $Label.text + str(amountDamage)
#	$animators.play("appears")
#	$dissapearTimer.start()
#	print(amountDamage)
#	if maxDamage == true:
#		$animator.play("turnRed")
#	else:
#		pass
#
#
#func _on_dissapear_timer_timeout():
#	$animators.play("disappear")
#	print("memori")
#	queue_free()
#

var direction= Vector2(0,-1)
var speed= 25
var dissapearBool= false
var idleTimer= true

func _ready():
	scale= Vector2(0,0)
	$appears.start()

func _process(delta):
	if dissapearBool == false:
		scale= scale + Vector2(0.05,0.05)
	if dissapearBool == true and idleTimer == false:
		scale= scale - Vector2(0.1,0.1)
	velocity = direction * speed
	move_and_slide()

func showDamage(amountDamage,maxDamage):
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
