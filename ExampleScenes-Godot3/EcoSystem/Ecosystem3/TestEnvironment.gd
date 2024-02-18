

extends Node2D

@onready var viewport_size = get_viewport().get_visible_rect().size
@onready var sneks = get_node("Sneks").get_children()



const GRAVITY = 0.4


func _ready():
	randomize()
	
	for snek in sneks:
		snek.position = Vector2(randf_range(0,viewport_size.x),randf_range(0,viewport_size.y))
		snek.velocity = Vector2(randf_range(-1,1), randf_range(-1,1))
	
		
		
func _physics_process(delta):
	var mouse_pos = get_global_mouse_position()
	

	
	for snek in sneks:
		var direction = mouse_pos - snek.position
		#the look_at() function was built to do this.
		var angle = atan2(snek.velocity.y, snek.velocity.x)
		direction = direction.normalized()
		snek.acceleration = direction * 0.5
		snek.heading = angle
		print(angle)
		
