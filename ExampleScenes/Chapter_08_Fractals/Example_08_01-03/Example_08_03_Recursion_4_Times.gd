extends Node2D

onready var viewport_size = get_viewport().get_visible_rect().size


func draw_circle_fractal(x, y, radius):
	draw_arc(Vector2(x,y), radius, 0, 2*PI, 64, Color(0,0,0), 1)
	if radius > 8:
		draw_circle_fractal(x+radius, y, radius/2)
		draw_circle_fractal(x-radius, y, radius/2)
		draw_circle_fractal(x, y+radius, radius/2)
		draw_circle_fractal(x, y-radius, radius/2)
		
func _draw():
	var pos = viewport_size/2
	var radius = viewport_size.y/2
	draw_circle_fractal(pos.x, pos.y, radius)
