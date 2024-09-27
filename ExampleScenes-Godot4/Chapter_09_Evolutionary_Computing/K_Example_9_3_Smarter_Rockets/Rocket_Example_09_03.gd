extends Node2D
class_name Rocket_Example_09_03

var radius : float = 4
var color := Color(1.0,1.0,1.0,1.0)

var velocity : Vector2
var acceleration : Vector2
var fitness : float = 0
var dna : DNA_Example_09_03
var gene_counter : int = 0

func _init(_global_position: Vector2, _dna: DNA_Example_09_03)->void:
	dna = _dna
	position = _global_position


	
func _process(delta: float) -> void:
	if gene_counter < dna.genes.size():
		apply_force(dna.genes[gene_counter])
		gene_counter += 1
		
		velocity += acceleration
		position += velocity
		acceleration *= 0
		rotation = atan2(velocity.y, velocity.x) + PI/2
	else:
		pass

func apply_force(_force: Vector2)->void:
	acceleration += _force
	
func calculate_fitness(_target: Vector2)->float:
	# mouse target: 
	# target = get_global_mouse_position()
	var distance : float = global_position.distance_to(_target)
	fitness = 1/ (distance*distance)
	#print(fitness)
	return fitness
	
func _draw() -> void:
	var points: PackedVector2Array = [
		Vector2(0,-radius),
		Vector2(-radius/2, radius/2),
		Vector2(radius/2, radius/2)
	]
	draw_colored_polygon(points,color)
