extends Node2D

var lsys
var turtle
var counter = 0

func _ready():
	var ruleset = []
	#var rule = Rule_08_10.new("F", "FF+[+F-F-F]-[-F+F+F]")
	var rule = Rule_08_10.new("F", "FF+[+F-F-F]-[-F+F+F]")
	ruleset.append(rule)
	lsys = L_System_08_10.new("F", ruleset)
	turtle = Turtle_08_10.new(lsys.get_sentence(), 200, deg_to_rad(25.0))
	print(lsys.get_sentence())
	add_child(turtle)
	turtle.position = Vector2(500,600)
	turtle.rotation -= PI/2


func _process(delta):
	if Input.is_action_just_pressed("left_mouse"):
		if counter<5:
			lsys.generate()
			turtle.set_todo(lsys.get_sentence())
			turtle.change_length(0.5)
			turtle.update()
			counter +=1

		
	
