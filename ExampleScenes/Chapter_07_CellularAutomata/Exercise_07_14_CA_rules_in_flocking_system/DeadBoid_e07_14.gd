extends RigidBody2D

class_name DeadBoid_e07_14

onready var viewport_size = get_viewport().get_visible_rect().size

var velocity : = Vector2(rand_range(-1,1), rand_range(-1,1))
var acceleration : Vector2


export var size : float


var polygon : PoolVector2Array
var color = Color(0,0,0)

var lookahead = 25
var vision_angle = PI/4

var sep_weight = 2
var coh_weight = 1.0
var align_weight = 1.0
var max_speed : float = 4
var max_force : float = 0.1



func _init(_position:Vector2, _size:float, _rotation:float):
	position = _position
	rotation = _rotation
	size = _size
	
func _ready():
	
	set_gravity_scale(0.1)
	set_use_custom_integrator(false)
	set_linear_damp(0)
	var collider = CollisionPolygon2D.new()
	var v1 = Vector2(-size,-size)
	var v2 = Vector2(size,0)
	var v3 = Vector2(-size,size)
	polygon = PoolVector2Array([v1,v2,v3])
	collider.set_polygon(polygon)
	add_child(collider)
	
func _process(delta):
	if position.y > viewport_size.y + 100:
		queue_free()

func _draw():
	draw_colored_polygon(polygon, color)
	#draw_circle(Vector2(0,0), size, Color(1,1,1,0.5))
	
func my_map(input, minInput, maxInput, minOutput, maxOutput):
	#explained here: https://victorkarp.wordpress.com/2019/10/01/godot-engine-how-to-remap-a-range-of-numbers-to-another-range-visually-explained/
	var output = ( (input - minInput) / (maxInput - minInput) * (maxOutput - minOutput) + minOutput )
	return output


