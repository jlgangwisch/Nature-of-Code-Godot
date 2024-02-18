extends Node2D

@onready var viewport_size = get_viewport().get_visible_rect().size

var radius = 100000



func _draw():
	var pos = viewport_size/2
	draw_arc(pos, radius, 0, 2*PI, 64, Color(0,0,0), 1)
	if radius > 1:
		radius *= 0.75
		_draw()
