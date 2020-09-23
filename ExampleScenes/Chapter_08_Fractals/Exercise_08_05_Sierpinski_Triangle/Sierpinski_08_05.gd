extends Node2D

class_name Sierpinski_e08_05

var center
var length
var radius

var a = Vector2()
var b = Vector2()
var c = Vector2()
var points = PoolVector2Array()

func _init(_center, _radius):
	center= _center
	position = center
	radius = _radius
	length = radius * sqrt(3.0)

func _ready():
	var shift = Vector2(0, -radius)
	a = Vector2(0,0)
	b = Vector2(length,0).rotated(PI/3)
	c = Vector2(length,0).rotated(2*PI/3)
	
	a+=shift
	b+=shift
	c+=shift
	
	points = PoolVector2Array([a,b,c])


func _draw():
	draw_colored_polygon(points,Color(0,0,0,0.5))
#	draw_circle(a,10,Color(1,0,0))
#	draw_circle(b,10,Color(0,1,0))
#	draw_circle(c,10,Color(0,0,1))
#	draw_circle(Vector2(0,0),10, Color(1,1,1))
