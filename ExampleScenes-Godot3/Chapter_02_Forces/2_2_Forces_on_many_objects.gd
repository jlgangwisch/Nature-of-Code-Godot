extends Node2D

@onready var viewport_size = get_viewport().get_visible_rect().size

@export var gravity = Vector2(0,0.01)
@export var wall_aversion = Vector2(0,0)

func _ready():
	randomize()
	for mover in get_children():
		mover.position = Vector2(randf_range(0,viewport_size.x),randf_range(0,viewport_size.y))
		mover.mass = randf_range(1,10)
		
		
func _physics_process(delta):
	for mover in get_children():
		mover.apply_force(gravity)
		process_wall_aversion(mover.position)
		mover.apply_force(wall_aversion)

func process_wall_aversion(position):
	var right_wall_aversion = (position.x / viewport_size.x) *-0.01
	var left_wall_aversion = 1/position.x 
	wall_aversion = Vector2(right_wall_aversion + left_wall_aversion,0)
	print(wall_aversion)
