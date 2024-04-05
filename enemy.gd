extends Area3D

@onready var player = get_parent().get_node("player")
var alert:bool = 0
var shootsound = preload("res://explosion.wav")
@onready var bull_path = $RayCast3D
@export var index:int
@onready var parent = get_parent()
func fire_gun():
	if bull_path.is_colliding():
		if bull_path.get_collider().collision_layer == 1:
			print("Hit",index)
		if !$AudioStreamPlayer3D.playing:
			$AudioStreamPlayer3D.stream = shootsound
			$AudioStreamPlayer3D.play()
	

func _process(delta):
	if Input.is_action_just_pressed("Shoot"):
		alert = 1
	if (alert):
		var target_vec = global_position.direction_to(player.position)
		var target_basis = Basis.looking_at(target_vec)
		basis = basis.slerp(target_basis,0.5)

			
		
		
		


func _on_timer_timeout():
	if parent.order == index and alert:
		fire_gun()
