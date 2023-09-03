extends Node
class_name basicUtilities

var experiencePath:= preload("res://Scenes/Enemies/experience/experienceBall.tscn")
var randomNumberRange= RandomNumberGenerator.new()

func randomizeRangeNumber(aux1,aux2):
	var aux3
	randomNumberRange.randomize()
	aux3= randomNumberRange.randi_range(aux1,aux2)
	return(aux3)

func randomizeRangeNumberFloat(aux1,aux2):
	var aux3
	randomNumberRange.randomize()
	aux3= randomNumberRange.randf_range(aux1,aux2)
	return(aux3)


func spawnExperienceBall(positionEnemy,amount):
	var experienceBallInstance= experiencePath.instantiate()
	experienceBallInstance.amount= amount
	experienceBallInstance.position= positionEnemy
	return(experienceBallInstance)
