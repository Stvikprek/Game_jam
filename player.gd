extends Area3D


@onready var camera = $Camera3D
@onready var bullet_path = $RayCast3D
var leaning = false
var health = 10
const lean_rot  = 40
var in_lean_rot = false
var stuck = 0
var moving:bool = false

func _ready():
	Input.mouse_mode = (Input.MOUSE_MODE_CAPTURED)
func zoom(value):
	if camera.fov > value:
		camera.fov -= 1
func unzoom():
	if camera.fov < 75:
		camera.fov += 1
	else:
		camera.fov = 75
func stuck_drop():
	if stuck > 0:
		stuck -= 0.001
func _input(event):
	if  event is InputEventMouseMotion:
		rotation += (Vector3(-event.relative.y*0.005,-event.relative.x*0.005,0))
		rotation.x = clamp(rotation.x,deg_to_rad(-30),deg_to_rad(30))
		rotation.y = clamp(rotation.y,deg_to_rad(-30),deg_to_rad(30))
		
func _process(delta):
	if leaning == false and (in_lean_rot == true):
		if rotation.z < deg_to_rad(-2):
			rotate_z(deg_to_rad(lean_rot/20))
		elif rotation.z > deg_to_rad(2):
			rotate_z(deg_to_rad(-lean_rot/20))
		elif rotation.z > deg_to_rad(-2) and rotation.z < deg_to_rad(2):
			rotation.z = deg_to_rad(0)
			in_lean_rot = false
		
	if Input.is_action_pressed("Lean Right"):
		if rotation.z > deg_to_rad(-lean_rot):
			rotate_z(deg_to_rad(-lean_rot/20))
		leaning = true
		in_lean_rot = true
		

	elif Input.is_action_just_released("Lean Right"):
		leaning = false

	if Input.is_action_pressed("Lean Left"):
		if rotation.z < deg_to_rad(lean_rot):
			rotate_z(deg_to_rad(lean_rot/20))
		in_lean_rot = true
		leaning = true

	elif Input.is_action_just_released("Lean Left"):
		leaning = false

	if Input.is_action_pressed("Right"):
		position.x += 0.1 - stuck
		moving = true
		stuck_drop()

	if Input.is_action_pressed("Left"):
		position.x -= 0.1 - stuck
		moving = true
		stuck_drop()
	if Input.is_action_just_released("Left") or Input.is_action_just_released("Right"):
		moving = false
	if moving == false:
		if stuck <0.1:
			stuck += 0.002
		print(stuck)
	if Input.is_action_just_pressed("Shoot"):
		if bullet_path.is_colliding():
			var body = bullet_path.get_collider()
			if body.collision_layer == 2:
				body.queue_free()
		

	
