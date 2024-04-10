extends Node3D
var shootsound = preload("res://762x54r Single Isolated WAV.wav")

func _on_timer_timeout():
	$AudioStreamPlayer3D.stream = shootsound
	$AudioStreamPlayer3D.play()
