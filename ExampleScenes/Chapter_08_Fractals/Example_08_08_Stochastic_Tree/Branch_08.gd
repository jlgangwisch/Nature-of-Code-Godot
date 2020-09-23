extends Node2D

class_name Branch_08

var a
var b
var c
var theta = PI/6
var length
var width = 1
var cur_length = 0
var grown = false

func _init(start, _length):
	position = start
	length = _length
	b = Vector2(0,-length)
	c = Vector2(0,0)

	width = length/10
	grown = true
	
func _process(delta):
	pass
#	if cur_length<length:
#		cur_length += 1
#		c = Vector2(0,-cur_length)
#		update()
#	else:
#		grown = true
	
func _draw():
	draw_line(Vector2(0,0), b,Color(0,0,0), width)

