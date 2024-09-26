extends Node2D
class_name Rocket_Example_09_02

var length : float = 15
var color := Color(1.0,1.0,1.0,1.0)

var velocity : Vector2
var acceleration : Vector2

var fitness : float = 0
var target : Vector2

var frames_alive : int

var dna : DNA_Example_09_02

var frame : int = 0

func _ready() -> void:
	position = Vector2.ZERO
	velocity = Vector2.ZERO
	
	
func _process(delta: float) -> void:
	if frame < frames_alive:
		apply_force(dna.genes[frame])
		frame += 1
	else:
		velocity = Vector2.ZERO
	
	
	
	velocity += acceleration
	position += velocity
	acceleration *= 0
	rotation = atan2(velocity.y, velocity.x) + PI/2

func apply_force(_force: Vector2)->void:
	acceleration += _force
	
func calculate_fitness()->float:
	# mouse target: 
	# target = get_global_mouse_position()
	var distance : float = global_position.distance_to(target)
	fitness = 1/ (distance*distance)
	#print(fitness)
	return fitness
	
func _draw() -> void:
	var points: PackedVector2Array = [
		Vector2(0,-length),
		Vector2(-length/2, length/2),
		Vector2(length/2, length/2)
	]
	draw_colored_polygon(points,color)
