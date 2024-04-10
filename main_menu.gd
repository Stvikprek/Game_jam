extends Control

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED

func _on_link_button_button_up():
	get_tree().change_scene_to_file("res://lvl1.tscn")


func _on_quit_button_up():
	get_tree().quit()
