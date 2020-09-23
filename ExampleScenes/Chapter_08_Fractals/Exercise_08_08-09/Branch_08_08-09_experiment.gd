extends Node2D

class_name Branch_09_experiment

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
	b = Vector2(0,-_length)
	c = Vector2(0,0)
	length = _length
	width = length/10
	
func _process(delta):
	
	if cur_length<length:
		cur_length += 1
		c = Vector2(0,-cur_length)
		update()
	else:
		grown = true
	
func _draw():
	draw_line(Vector2(0,0), c,Color(0,0,0), width)

