extends Node2D

@onready var viewport_size = get_viewport().get_visible_rect().size

var length=100
var theta = PI/6

func _ready():
	position = Vector2(viewport_size.x/2, viewport_size.y/2+length+length*2/3)

func _process(delta):
	theta = get_global_mouse_position().x/100
	print (theta)
	update()

func branch(a, b):
	var l = b - a
	if l.length()>1:
		draw_line(a, b,Color(0,0,0), l.length()/10)
		l = l*2/3
		var origin = b
		var p1 = origin + l.rotated(-theta)
		var p2 = origin + l.rotated(theta)
		
		branch(origin,p2)
		branch(origin,p1)


func _draw():
	branch(Vector2(0,0), Vector2(0,-length))

