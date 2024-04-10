extends Area3D

@onready var player = get_parent().get_node("player")
var xray_mesh = preload("res://enemy_xray.tres")
var no_xray_mesh = preload("res://enemy_no_xray.tres")
var xray_mesh_red = preload("res://enemy_xray_red.tres")
var alert:bool = 0
@export var move_amnt:float
var shootsound = preload("res://556 Single Isolated WAV.wav") #Credit to Snake's gun sounds
@onready var bull_path = $RayCast3D
@onready var mesh = $HumanoidBase_Overlapping# Courtesy of Comp 3 interactive on itch.io
@export var index:int
@onready var parent = get_parent()
var turn_taken = false

func fire_gun():
	if bull_path.is_colliding():
		if bull_path.get_collider().collision_layer == 1:
			if player.moving:
				var num = randf()
				if num < 0.6 + player.stuck:
					player.health -= 1
			else:
				player.health -= 1
		else:
			var rand_num = randf()
			if rand_num > 0.85 - player.stuck*1.5:
				player.health -= 0.5
		if !$AudioStreamPlayer3D.playing:
			$AudioStreamPlayer3D.stream = shootsound
			$AudioStreamPlayer3D.play()
		
	

func _process(delta):
	if Input.is_action_just_pressed("Shoot"):
		alert = 1
	if get_parent().get_node("Timer").time_left> get_parent().get_node("Timer").wait_time/2:
		position.x += move_amnt
	else:
		position.x -= move_amnt
	if !alert:
		if parent.order == index:
			mesh.set_surface_override_material(0,xray_mesh) # To determine order
			$Body.set_surface_override_material(0,xray_mesh)
			$Body/Scope.set_surface_override_material(0,xray_mesh)
			$Body/Upper_Body.set_surface_override_material(0,xray_mesh)
		else:
			mesh.set_surface_override_material(0,no_xray_mesh)
			$Body.set_surface_override_material(0,no_xray_mesh)
			$Body/Scope.set_surface_override_material(0,no_xray_mesh)
			$Body/Upper_Body.set_surface_override_material(0,no_xray_mesh)
	if (alert):
		var target_vec = global_position.direction_to(player.position)
		var target_basis = Basis.looking_at(target_vec)
		basis = basis.slerp(target_basis,0.5)
		if parent.order == index and turn_taken == false:
			fire_gun()
			turn_taken = true
			mesh.set_surface_override_material(0,xray_mesh_red) #Actually shooting at you, dont forget to push
			$Body.set_surface_override_material(0,xray_mesh_red)
			$Body/Scope.set_surface_override_material(0,xray_mesh_red)
			$Body/Upper_Body.set_surface_override_material(0,xray_mesh_red)
		if parent.order != index:
			turn_taken = false
			mesh.set_surface_override_material(0,no_xray_mesh)
			$Body.set_surface_override_material(0,no_xray_mesh)
			$Body/Scope.set_surface_override_material(0,no_xray_mesh)
			$Body/Upper_Body.set_surface_override_material(0,no_xray_mesh)
