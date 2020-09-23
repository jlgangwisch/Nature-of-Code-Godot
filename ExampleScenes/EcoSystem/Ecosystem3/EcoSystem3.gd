extends Node2D

onready var viewport_size = get_viewport().get_visible_rect().size

var start_angle = 0.0
var heading = 0.0
var angle = 0.0
export var oscillation_scalor = 0.01
export var frequency_scalor = 0.01
export var amplitude = 100
export var period = 10
export var proximity = 24
export var starting_pos = Vector2(0,0)
export var segment_size = 24

var velocity = Vector2(0,0)
var acceleration = Vector2(0,0)
var aVelocity = 0.0
var aAcceleration = 0.0
var mass = 1
var oscillation_speed
var frequency

func _ready():
	oscillation_speed = oscillation_scalor
	#rotation = PI
	pass # Replace with function body.


func _physics_process(delta):
	angle = start_angle
	update()
	oscillation_speed = velocity.length() * oscillation_scalor
	start_angle -= oscillation_speed
	frequency = frequency_scalor * velocity.length()
	
	velocity += acceleration
	#velocity = velocity.clamped(top_speed)
	position += velocity
	acceleration *= 0;
	
	
	aVelocity += aAcceleration
	angle += aVelocity
	rotation = heading + PI
	aAcceleration *= 0



func _draw():
	var radius = segment_size
	for segment in period/proximity:
		var y = my_map(sin(angle), -1, 1, -amplitude, amplitude)
		var x = segment * proximity
		var position = Vector2(x,y) + starting_pos
		var point_color = PoolColorArray( [Color(1, 1, 1)] ) # same as above
		#draw_primitive(point_position, point_color, PoolVector2Array()) # third argument is UV, disregarded here, used to map texture
		draw_circle(position, radius, Color(1,1,1,0.5))
		radius = radius - 1
		angle += frequency
	
func my_map(input, minInput, maxInput, minOutput, maxOutput):
	#explained here: https://victorkarp.wordpress.com/2019/10/01/godot-engine-how-to-remap-a-range-of-numbers-to-another-range-visually-explained/
	var output = ( (input - minInput) / (maxInput - minInput) * (maxOutput - minOutput) + minOutput )
	return output
