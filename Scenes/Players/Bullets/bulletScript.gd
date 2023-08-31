extends CharacterBody2D
var basicUtilitiesInstance= basicUtilities.new()

var aimPos= Vector2(0,0)
var speed= 500

var minDamage= 10
var maxDamage= 15
var finalDamage

func _ready():
	aimPos= get_local_mouse_position()


func _process(delta):
	velocity = aimPos.normalized() * speed
	move_and_slide()

func dissapearBullet():
	queue_free()

func _on_area_2d_area_entered(area):
	var max= false
	var critic= false
	finalDamage= basicUtilitiesInstance.randomizeRangeNumber(minDamage,maxDamage)
	if finalDamage >= maxDamage:
		max= true
	else:
		pass
	area.takeDamageBullet(finalDamage,max)
	dissapearBullet()


func _on_wall_area_entered(area):
	dissapearBullet()
