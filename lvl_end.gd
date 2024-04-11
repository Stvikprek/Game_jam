extends Node3D
var shootsound = preload("res://762x54r Single Isolated WAV.wav")
var end:bool = false
var env = preload("res://end_env.tres")

func _process(delta):
	env.fog_light_energy = move_toward(env.fog_light_energy,1,0.004)
	if end== true:
		$player.rotation.z = move_toward($player.rotation.z,deg_to_rad(90),0.07)
		$player.get_node("Body").visible = false


func _on_timer_timeout():
	if !end:
		$AudioStreamPlayer3D.stream = shootsound
		$AudioStreamPlayer3D.play()
		end = true
		$Timer.wait_time = 2
		$Timer.start()
	else:
		get_tree().change_scene_to_file("res://end_intro.tscn")
