extends Node2D

func _process(delta):
	if Input.is_anything_pressed() and $Timer.time_left < $Timer.wait_time/2:
		get_tree().change_scene_to_file("res://intro.tscn")


func _on_timer_timeout():
	get_tree().change_scene_to_file("res://intro.tscn")
