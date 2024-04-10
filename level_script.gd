extends Node3D

var order = 1
var count = 0
var max_enemies:int = 6
@onready var timer = $Timer

func _ready():
	var child_arr = get_children()
	for item in child_arr:
		if "ENEMY" in item.name:
			count += 1
	max_enemies = count
func _process(delta):
	if order > max_enemies + 1:
		order = order - max_enemies - 1
	if count == 0:
		get_tree().change_scene_to_file("res://lvl3.tscn")


func _on_timer_timeout():
	order += 1
