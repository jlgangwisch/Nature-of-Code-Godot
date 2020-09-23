extends Node2D

onready var viewport_size = get_viewport().get_visible_rect().size

func cantor(x, y, length):
	if length > 1:
		draw_line(Vector2(x,y),Vector2(x+length,y), Color(0,0,0), 3)
	
		y += 20
	
		cantor(x, y, length/3)
		cantor(x+length*2/3, y, length/3)
		
func _draw():
	cantor(10, 10, viewport_size.x-10)
