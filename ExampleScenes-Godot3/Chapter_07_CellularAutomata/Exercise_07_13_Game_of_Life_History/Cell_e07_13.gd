extends Node2D

class_name Cell_e07_13

#adds green the longer it's been alive or dead

var cur_state = 0
var prev_state = 0
var size
var color = Color(0,0,0)
var frames_in_current_state = 0
var green = 0.0

func _process(delta):
	
	update()
	
func _draw():
	
	green = frames_in_current_state/10000.0
	
	if prev_state == 0 && cur_state == 1:
		color = Color(0,green,1)
		frames_in_current_state = 0
		
	elif prev_state == 1 && cur_state == 0:
		color = Color(1,green,0)
		frames_in_current_state = 0
		
	elif cur_state == 1:
		color = Color(1,1-green*10,1)
		frames_in_current_state += 1

	else:
		color = Color(0,green,0)
		frames_in_current_state +=1
		
	draw_rect(Rect2(Vector2(0,0), Vector2(size,size)), color)
	#draw_circle(Vector2(0,0), size/2, color)
	prev_state = cur_state
