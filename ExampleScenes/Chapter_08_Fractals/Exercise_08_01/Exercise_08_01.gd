extends Node2D

onready var viewport_size = get_viewport().get_visible_rect().size

func fractal(x, y, length):
	if length > 1:
		var end1 = Vector2(x+length,y)
		var end2 = Vector2(x-length,y)
		var end3 = Vector2(x, y+length)
		var end4 = Vector2(x,y-length)
		draw_line(Vector2(x,y),end1, Color(0,0,0), 1)
		draw_line(Vector2(x,y),end2, Color(0,0,0), 1)
		draw_line(Vector2(x,y),end3, Color(0,0,0), 1)
		draw_line(Vector2(x,y),end4, Color(0,0,0), 1)
		
		fractal(end1.x, end1.y, length/2)
		fractal(end2.x, end2.y, length/2)
		fractal(end3.x, end3.y, length/2)
		fractal(end4.x, end4.y, length/2)
func _draw():
	fractal(viewport_size.x/2, viewport_size.y/2, viewport_size.x/4)
