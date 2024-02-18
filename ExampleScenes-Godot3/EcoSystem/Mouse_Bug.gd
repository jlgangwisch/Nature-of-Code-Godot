extends Node2D

@onready var viewport_size = get_viewport().get_visible_rect().size

@export var mass = 5.0


func _ready():
	var shape = CircleShape2D.new()
	shape.set_radius(mass)
	get_node("CollisionShape2D").set_shape(shape)


func _physics_process(delta):


	#velocity = velocity.clamped(top_speed)
	position = get_global_mouse_position()


	#check_edges()
	#print(velocity)
