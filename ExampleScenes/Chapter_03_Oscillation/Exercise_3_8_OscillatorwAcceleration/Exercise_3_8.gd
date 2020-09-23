extends Node2D

onready var viewport = get_viewport()
onready var viewport_size = get_viewport().get_visible_rect().size


var center


export var circle_radius = 10.0
export var circle_color = Color(0,0,0)
export var line_scale = 0.5
export var line_width = 1.0

var angle = Vector2()
var amplitude = Vector2()
var aVelocity = Vector2()
var aAcceleration = Vector2(0.001,0.001)
var target = Vector2()

func _ready():
	randomize()
	center = Vector2 (viewport_size.x/2, viewport_size.y/2) 
	aVelocity = Vector2(rand_range(-0.5,0.5), rand_range(-0.5,0.5))
	amplitude = Vector2(rand_range(0,center.x), rand_range(0,center.y))

func _physics_process(delta):
	var x = amplitude.x * sin(angle.x)
	var y = amplitude.y * sin(angle.y)
	target = Vector2(x + center.x, y+center.y)
	aVelocity += aAcceleration
	update()
	oscillate()


func _draw():
	var line_start = Vector2(center.x,center.y)
	var line_end = target
	draw_line(line_start, line_end, Color(1.0,1.0,1.0), line_width)
	draw_circle(target, circle_radius, circle_color)

func oscillate():
	angle += aVelocity * 0.1
