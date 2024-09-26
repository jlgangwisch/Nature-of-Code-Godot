extends Node

class_name DNA_Example_09_02

var genes : PackedVector2Array = []

var max_force : float = 0.1

func _init(frames_alive: int) -> void:
	for i in frames_alive:
		var rand_vector = Vector2(randf_range(-1.0,1.0),randf_range(-1.0,1.0)).normalized() 
		rand_vector *= randf_range(0,max_force)
		genes.append(rand_vector)
		
