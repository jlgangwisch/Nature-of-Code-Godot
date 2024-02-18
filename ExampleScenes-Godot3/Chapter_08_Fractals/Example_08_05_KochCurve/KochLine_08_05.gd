extends Node2D

class_name Koch_Line_08_05

var a
var b

func _init(start, end):
	a = start
	b = end

func k_start():
	return a

func k_end():
	return b

func k_left():
	var v = b - a
	v = v/3
	v = a + v
	return v
	
	
func k_mid():
	var v = b - a
	v = v/3
	
	var p = a + v
	
	v = v.rotated(-PI/3)
	
	p = p+v
	
	return p
	
func k_right():
	var v = a - b
	v = v/3
	v = v + b
	return v
	
func _draw():
	draw_line(a, b, Color(0,0,0),1)
