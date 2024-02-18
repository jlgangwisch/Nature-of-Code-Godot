extends Node3D

#onready var viewport_size = get_viewport().get_visible_rect().size

@export var velocity = Vector3(2.5,5,4)
@export var circle_radius = 10.0
@export var circle_color = Color(1.0,1.0,1.0)
@export var box_extents = 50

func _physics_process(delta):
	
	translate(velocity)

	if position.x < -box_extents or position.x > box_extents:
		velocity.x *= -1
	if position.y < -box_extents or position.y > box_extents:
		velocity.y *= -1
	if position.z < -box_extents or position.z > box_extents:
		velocity.z *= -1
