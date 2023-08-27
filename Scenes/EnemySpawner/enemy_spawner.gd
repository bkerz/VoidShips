extends Node2D

@export var enemy_list: Array[PackedScene]

func _ready():
	if enemy_list.size() > 0:
		for n in range(10):
			var enemy_instance = enemy_list.pick_random().instantiate()
			add_child(enemy_instance)
