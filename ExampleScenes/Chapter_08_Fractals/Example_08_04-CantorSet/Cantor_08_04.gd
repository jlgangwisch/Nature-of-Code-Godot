extends Node2D

class_name Cantor_08_04

var start
var length

func _init(_start, _length):
	start = _start
	length = _length

func _ready():
	pass

func _draw():
	draw_line(start, Vector2(start.x+length, start.y), Color(0,0,0), 3)
