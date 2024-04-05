extends Node3D

var order = 1
var max_enemies:int = 2

func _process(delta):
	if order > max_enemies + 1:
		order = order - max_enemies - 1
	
	


func _on_timer_timeout():
	order += 1
