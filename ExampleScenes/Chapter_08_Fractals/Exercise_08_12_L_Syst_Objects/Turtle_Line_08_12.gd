extends Node2D

class_name Turtle_Line_08_12

var length


func _init(_start, _length, _rot):
	position = _start
	length = _length
	rotation = _rot
	
func _draw():
	var start = Vector2(0,0)
	var end = Vector2(length,0) 
	draw_line(start, end, Color(1,0,0),2)

