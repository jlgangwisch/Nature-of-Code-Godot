extends Node2D

class_name StrikeWare_Brush


var color = Color()
var radius = 5

func _process(delta):
	update()

func _draw():
	draw_circle(Vector2(0,0), radius, color)
