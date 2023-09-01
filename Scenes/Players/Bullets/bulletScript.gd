extends CharacterBody2D
var basicUtilitiesInstance= basicUtilities.new()

var aimPos= Vector2(0,0)
var speed= 500

var damageTo

var minDamage= 10
var maxDamage= 15
var finalDamage

var bulletOfEnemy= false

func _ready():
	if bulletOfEnemy == false:
		aimPos= get_local_mouse_position()
		$Area2D.set_collision_mask_value(3,true)
	else:
		$Area2D.set_collision_mask_value(3,false)
		speed= 100
		$Area2D.set_collision_mask_value(damageTo,true)

func _process(delta):
	velocity = aimPos.normalized() * speed
	move_and_slide()

func dissapearBullet():
	queue_free()

func definirEnemigo(enemy):
	damageTo= enemy
	if enemy != 3:
		bulletOfEnemy= true


func _on_area_2d_area_entered(area):
	var max= false
	var critic= false
	finalDamage= basicUtilitiesInstance.randomizeRangeNumber(minDamage,maxDamage)
	if finalDamage >= maxDamage:
		max= true
	else:
		pass
	if bulletOfEnemy == true:
		area.takeDamage(finalDamage,$".".global_position)
	else:
		area.takeDamageBullet(finalDamage,max)
	dissapearBullet()


func _on_wall_area_entered(area):
	dissapearBullet()
