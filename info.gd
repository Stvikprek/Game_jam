extends Node2D

func _process(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().change_scene_to_file("res://main_menu.tscn")
