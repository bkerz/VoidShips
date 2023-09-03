extends Node2D

const extremoIzquiero= 0
const extremoDerecho= 1150
const extremoSuperior= -50

@export var enemy_list: Array[PackedScene]
var enemiPosRandom= Vector2(0,0)
var randomizePos = RandomNumberGenerator.new()
var playerDeath= false
var endedGame = false

func _on_timer_timeout():
	if not playerDeath and not endedGame:
		randomizePos.randomize()
		enemiPosRandom.x = randomizePos.randi_range(extremoIzquiero,extremoDerecho)
		enemiPosRandom.y = extremoSuperior
		var enemy_instance = enemy_list.pick_random().instantiate()
		enemy_instance.position = enemiPosRandom
		add_child(enemy_instance)
	else:
		pass


func playerIsDeath():
	playerDeath= true

func endGameProcess():
	endedGame= true
