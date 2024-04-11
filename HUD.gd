extends Control
@onready var health = $health
@onready var player = get_parent().get_node("player")
@onready var reload_time = $RELOAD
func _process(delta):
	if get_tree().current_scene.name != "lvl_end":
		health.value = player.health
		if player.get_node("Timer").time_left != 0 :
			reload_time.visible = true
			reload_time.value = player.get_node("Timer").time_left
		else:
			reload_time.visible = false 
