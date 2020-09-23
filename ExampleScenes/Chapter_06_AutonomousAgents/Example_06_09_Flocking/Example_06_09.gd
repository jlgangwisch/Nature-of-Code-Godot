extends Node2D

onready var viewport_size = get_viewport().get_visible_rect().size

var flock_size = 100

func _ready():
	for i in range(flock_size):
		var r_pos = Vector2(rand_range(0, viewport_size.x), rand_range(0,viewport_size.y))
		var b = Boid_06_09.new(r_pos, 10)
		$Flock.add_child(b)

