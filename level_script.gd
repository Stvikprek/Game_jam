extends Node3D

var order = 1
var max_enemies:int = 4
@onready var timer = $Timer
func _process(delta):
	if order > max_enemies + 1:
		order = order - max_enemies - 1
	if Input.is_action_just_pressed("Shoot") and timer.is_stopped():
		timer.start()


func _on_timer_timeout():
	order += 1
