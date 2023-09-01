extends Node
class_name basicUtilities

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
