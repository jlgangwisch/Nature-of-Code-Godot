extends Node2D
@onready var viewport_size = get_viewport().get_visible_rect().size

var lines = []
var lsys
var turtle
var counter = 0
var length = 200
var theta = deg_to_rad(25)

func _ready():
	
	var t = Turtle_Line_08_12.new(Vector2(0,0), length, 0)
	position = Vector2(500,600)
	rotation = -PI/2
	lines.append(t)
	add_child(t)

	var ruleset = []
	#var rule = Rule_08_10.new("F", "FF+[+F-F-F]-[-F+F+F]")
	var rule = Rule_08_10.new("F", "FF+[+F-F-F]-[-F+F+F]")
	ruleset.append(rule)
	lsys = L_System_08_12.new("F", ruleset)
	
func generate():
	var next = []
	for i in lines:
		pass
	lines = next

func _process(delta):
	if Input.is_action_just_pressed("left_mouse"):
		if counter<6:
			lsys.generate()
			length = length * 0.5
			turtle()
			counter +=1
			print(get_child_count())



func turtle():
	for i in get_children():
		remove_child(i)
		i.queue_free()
	var todo =  lsys.get_sentence()
	var line_pos = PackedVector2Array([Vector2(0,0)])
	var angle = []
	angle.append(0.0)
	
	for i in range(todo.length()):
		var c = todo.ord_at(i)
		if (c == "F".ord_at(0) || c== "G".ord_at(0)):
			var p = line_pos[line_pos.size()-1]
			var a = angle[angle.size()-1]
			var t = Turtle_Line_08_12.new(p,length, a)
			add_child(t)
			line_pos[line_pos.size()-1] = p + Vector2(length,0).rotated(a)

		elif(c == "+".ord_at(0)):
			angle[angle.size()-1] += theta

		elif(c == "-".ord_at(0)):
			angle[angle.size()-1] -= theta

		elif(c == "[".ord_at(0)):
			var p = line_pos[line_pos.size()-1]
			line_pos.append(p)
			var a = angle[angle.size()-1]
			angle.append(a)
#			matrix.append(a)
#			#print("pushed.  List of transforms: ", matrix)
		elif(c == "]".ord_at(0)):
			line_pos.remove(line_pos.size()-1)
			angle.pop_back()
#			local_transform = t1
#			#print("t1: ", t1, "  new transform: ", local_transform)
