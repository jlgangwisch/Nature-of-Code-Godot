extends Node2D

class_name Turtle_08_10

var todo := ""
var length : float 
var theta : float
var matrix = []
var local_transform = [Vector2(0,0), 0.0]

func _init(s:String,l:float, t:float):
	todo = s
	length = l
	theta = t
	matrix.append(local_transform)

func set_length(l:float):
	length = l
	
func change_length(percent:float):
	length *= percent
	
func set_todo(s:String):
	todo = s
	
func _draw():
	
#	for i in range(todo.length()):
#		var c = todo.ord_at(i)
#		if (c == "F".ord_at(0) || c== "G".ord_at(0)):
#			var a = Vector2(0,0)
#			var b = Vector2(length, 0)
#			draw_line(a, b, Color(1,0,0), 2)
#			translate(Vector2(length,0))
#	pass
	#local_transform = matrix[matrix.size()-1]
	var local_transform = [Vector2(0,0), 0.0]
	for i in range(todo.length()):
		
		var c = todo.ord_at(i)
		if (c == "F".ord_at(0) || c== "G".ord_at(0)):
			var a = local_transform[0]
			var b =a + Vector2(length,0).rotated(local_transform[1])
			draw_line(a, b, Color(1,0,0,0.5), 2)
			#local_transform[0] += Vector2(length,0)
			local_transform[0] = b
			#print("Line Drawn From A: ", a, " to B: ", b, ". Local Transform:", local_transform)
		elif(c == "+".ord_at(0)):
			local_transform[1] += theta
			#print("rotated right.  Local Transform: ", local_transform)
		elif(c == "-".ord_at(0)):
			local_transform[1] -= theta
			#print("left  Local Transform: ", local_transform)
		elif(c == "[".ord_at(0)):
			var a = local_transform.duplicate()
			matrix.append(a)
			#print("pushed.  List of transforms: ", matrix)
		elif(c == "]".ord_at(0)):
			var t1 = matrix.pop_back()
			local_transform = t1
			#print("t1: ", t1, "  new transform: ", local_transform)
	print("finished")
