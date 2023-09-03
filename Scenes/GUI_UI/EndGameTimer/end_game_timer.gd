extends Node2D
signal timeout

@export var minutes_time: int
var current_seconds: int
 
# Called when the node enters the scene tree for the first time.
func _ready():
	current_seconds = minutes_time * 60
	$Label.text = "0{minutes}:00".format({"minutes": minutes_time})

func _on_timer_timeout():
	if current_seconds > 0:
		current_seconds -= 1
		var minutes = current_seconds / 60
		var seconds = current_seconds % 60
		var seconds_template = "{seconds}"
		var minutes_template = "{minutes}"
		if seconds < 10:
			seconds_template = "0{seconds}"
		if minutes < 10:
			minutes_template = "0{minutes}"
		var label_template = minutes_template + ":" + seconds_template
		$Label.text = label_template.format({"minutes": minutes, "seconds": seconds})
		
	if current_seconds == 0:
		get_tree().call_group("onPlayerWin","endGameProcess")
		get_tree().call_group("winMenuUi","aparecer")

func aparecer():
	print("a")
	$Timer.autostart= false
	$Timer.one_shot= true
