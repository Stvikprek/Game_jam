extends Area3D


@onready var camera = $Camera3D
@onready var scopetex= $scope_tex
@onready var bullet_path = $RayCast3D
var leaning = false
const lean_amount = 0.07
const lean_rot  = 40
var return_pos = Vector3(0,0,0)
var in_lean_dist = false
var in_lean_rot = false

func _ready():
	return_pos = position
	scopetex.visible = false
	
func zoom(value):
	if camera.fov > value:
		camera.fov -= 1
func unzoom():
	if camera.fov < 75:
		camera.fov += 1
	else:
		camera.fov = 75
		
func _input(event):
	if event is InputEventMouseMotion and leaning:
		rotate_y(deg_to_rad(-event.relative.x)*0.5)
		rotate_x(deg_to_rad(-event.relative.y) * 0.5)
		rotation.x = clamp(rotation.x,deg_to_rad(-30),deg_to_rad(30))
		rotation.y = clamp(rotation.y,deg_to_rad(-30),deg_to_rad(30))
		
		
func _process(delta):
	if leaning == false and (in_lean_dist == true or in_lean_rot == true):
		if position.x > return_pos.x + 0.1:
			position.x -= lean_amount
		elif position.x < return_pos.x - 0.1:
			position.x += lean_amount
		elif position.x < return_pos.x + 0.1 and position.x > return_pos.x - 0.1:
			position = return_pos
			return_pos = position
			in_lean_dist = false
		if rotation.z < deg_to_rad(-2):
			rotate_z(deg_to_rad(lean_rot/20))
		elif rotation.z > deg_to_rad(2):
			rotate_z(deg_to_rad(-lean_rot/20))
		elif rotation.z > deg_to_rad(-2) and rotation.z < deg_to_rad(2):
			rotation.z = deg_to_rad(0)
			in_lean_rot = false

		rotation.x = 0
		rotation.y = 0
		
		
	if Input.is_action_pressed("Lean Right"):
		if position.x < return_pos.x + 2.5:
			position.x += lean_amount
		if rotation.z > deg_to_rad(-lean_rot):
			rotate_z(deg_to_rad(-lean_rot/20))

		leaning = true

		in_lean_dist = true
		in_lean_rot = true
	elif Input.is_action_just_released("Lean Right"):
		leaning = false


	
	if Input.is_action_pressed("Lean Left"):
		if position.x > return_pos.x - 2.5:
			position.x -= lean_amount
		if rotation.z < deg_to_rad(lean_rot):
			rotate_z(deg_to_rad(lean_rot/20))


		in_lean_dist = true
		in_lean_rot = true
		leaning = true
	elif Input.is_action_just_released("Lean Left"):
		leaning = false

	if Input.is_action_pressed("Right") and in_lean_dist == false:
		position.x += 0.1
		return_pos = position
		
	if Input.is_action_pressed("Left") and in_lean_dist == false:
		position.x -= 0.1
		return_pos = position
		
	if Input.is_action_just_pressed("Shoot"):
		if bullet_path.is_colliding():
			var body = bullet_path.get_collider()
			if body.collision_layer == 2:
				body.queue_free()
	if Input.is_action_pressed("Aim"):
		scopetex.visible = true
		zoom(40)
		

	
