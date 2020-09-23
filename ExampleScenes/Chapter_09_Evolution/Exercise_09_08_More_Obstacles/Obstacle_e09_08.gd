extends Node2D

class_name Obstacle_e09_08

export var width = 10
export var height = 200

func contains(v2:Vector2):
	if v2.x > position.x && v2.x <position.x + width && v2.y > position.y && v2.y < position.y + height:
		return true
	else:
		return false

func _draw():
	draw_rect(Rect2(0,0,width,height), Color(0,1,0))
