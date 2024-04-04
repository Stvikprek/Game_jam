extends Area3D

@onready var player = get_parent().get_node("player")
var alert:bool = 0

func _process(delta):
	if Input.is_action_just_pressed("Shoot"):
		alert = 1
	if (alert):
		var target_vec = global_position.direction_to(player.position)
		var target_basis = Basis.looking_at(target_vec)
		basis = basis.slerp(target_basis,0.5)
		
		
