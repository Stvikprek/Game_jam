extends Control
@onready var health = $health
@onready var player = get_parent().get_node("player")
@onready var reload_time = $RELOAD
func _process(delta):
	health.value = player.health
	reload_time.value = (player.get_node("Timer").time_left)
