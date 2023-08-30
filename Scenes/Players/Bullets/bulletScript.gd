extends CharacterBody2D

var aimPos= Vector2(0,0)
var speed= 500
var damageBase= 10

func _ready():
	aimPos= get_local_mouse_position()


func _process(delta):
	velocity = aimPos.normalized() * speed
	move_and_slide()

func dissapearBullet():
	queue_free()

func _on_area_2d_area_entered(area):
	area.takeDamageBullet(damageBase)
	dissapearBullet()


func _on_wall_area_entered(area):
	dissapearBullet()
