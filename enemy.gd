extends Area3D

@onready var player = get_parent().get_node("player")
var alert:bool = 0
var shootsound = preload("res://explosion.wav")
@onready var bull_path = $RayCast3D
@onready var mesh = $HumanoidBase_NotOverlapping # Courtesy of Comp 3 interactive on itch.io
@export var index:int
@onready var parent = get_parent()
var turn_taken = false
func _ready():
	mesh.get_active_material(0).next_pass.albedo_color.a = 0.0

func fire_gun():
	if bull_path.is_colliding():
		if bull_path.get_collider().collision_layer == 1:
			if player.moving:
				var num = randf()
				if num < 0.7 + player.stuck:
					player.health -= 1
			else:
				player.health -= 1
		else:
			var rand_num = randf()
			if rand_num > 0.9 - player.stuck*2:
				player.health -= 0.5
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
		if parent.order == index and turn_taken == false:
			fire_gun()
			turn_taken = true
			mesh.get_active_material(0).next_pass.albedo_color.a = 0.5
		if parent.order != index:
			turn_taken = false
			mesh.get_active_material(0).next_pass.albedo_color.a = 0.0 #Mesh changin all at once, need fix

