extends Node2D

var seed_length=100

func branch(a, b):
	var l = b - a
	if l.length()>2:
		draw_line(a, b,Color(0,0,0), 2)
		l = l * 2/3
		var origin = b
		var p1 = origin + l.rotated(-PI/6)
		var p2 = origin + l.rotated(PI/6)
		

		print(l)
		branch(origin,p2)
		branch(origin,p1)


func _draw():
	branch(Vector2(0,0), Vector2(0,-seed_length))

