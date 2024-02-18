extends Node2D

class_name Branch_08_08

var a
var b
var c
var theta = PI/6
var length
var width = 1
var cur_length = 0
var grown = false

func _init(start, end):
	a = start
	b = end
	c = a
	length = b-a
	width = length.length()
	width = width/10

func relocate(origin,theta):
	a = origin
	b = length.rotated(theta) + a
	update()
	
func branch():
	var l = b - a
	l = l*2/3
	var origin = b
	var p1 = origin + l.rotated(-theta)
	var p2 = origin + l.rotated(theta)
	return PackedVector2Array([p1,p2])


func _process(delta):
	
	if cur_length<length.length():
		cur_length += 1
		c =  a + length*(cur_length/length.length())
		update()
	else:
		grown = true
	
func _draw():
	draw_line(a, c,Color(0,0,0), width)

