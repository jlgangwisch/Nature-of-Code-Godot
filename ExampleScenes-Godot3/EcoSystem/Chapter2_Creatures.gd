#these fellows are attracted to the simplex walkers but scared of the mouse

extends Node2D

@onready var viewport_size = get_viewport().get_visible_rect().size
@onready var movers = get_children()
@onready var attractors = get_parent().get_node("Simplex_Walkers").get_children()
@onready var avoiders = get_parent().get_node("Mouse_Bug")

const GRAVITY = 0.4


func _ready():
	randomize()
	
	for mover in movers:
		mover.position = Vector2(randf_range(0,viewport_size.x),randf_range(0,viewport_size.y))
		mover.mass = randf_range(1,10)
		
	
		
func _physics_process(delta):
	var mouse_position = get_global_mouse_position()
	for mover in movers:
		for attractor in attractors:
			var attraction = process_attraction(mover, attractor)
			#print(attractor.position)
			mover.apply_force(attraction)
			var fear = process_fear(mover, avoiders)
			mover.apply_force(fear)

func process_attraction(_mover, _attractor):
	var force = _attractor.position - _mover.position
	var distance = force.length()
	distance = clamp(distance, 5,25)
	force = force.normalized()
	var strength = (GRAVITY * _attractor.mass * _mover.mass) / (distance * distance)
	force = force * strength * 5
	return force
	
func process_fear (_mover, _avoider):
	var force = _mover.position-_avoider.position
	var distance = force.length()
	distance = clamp(distance,5,1000)
	force = force.normalized()
	var strength = (GRAVITY  * _avoider.mass * _mover.mass) / distance 
	force = force * strength * .5
	return force
