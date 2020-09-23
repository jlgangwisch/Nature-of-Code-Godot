extends Node2D
onready var viewport_size = get_viewport().get_visible_rect().size

var lines = []
var theta = PI/6
var levels = 10
var length = 200
var changeable = []


func _ready():
	randomize()
	var start = Vector2(viewport_size.x/2, viewport_size.y/2+266)
	var end = start + Vector2(0,-100)
	
	var k = Branch_08.new(start, length)
	add_child(k)
	lines.append(k)
	length = length *2/3

func _process(delta):
	if levels >0:
		generate()
	elif lines.size()>0:
		var branch_index = rand_range(0,lines.size()-1)
		if lines[branch_index].grown:
			var leaf = Leaf_08_08.new()
			leaf.position = Vector2(0,-lines[branch_index].length)
			lines[branch_index].add_child(leaf)
			lines.remove(branch_index)
			print (lines.size())
	if Input.is_action_just_pressed("left_mouse"):
		for i in changeable:
			var l1 = rand_range(length/2, length)
			var r1 = rand_range(-PI/2,PI/2)
			i.length = l1
			i.rotation = r1
			i.update()
#	theta = get_global_mouse_position().x/100
#
#	for i in rotate_r:
#		i.rotation = theta
#	for i in rotate_l:
#		i.rotation = -theta
	

	
func generate():
	var next = []
	for i in lines:
		if i.grown:
			
			var r1 = rand_range(2,3)
			for w in range(r1):
				theta = rand_range(-PI/2,PI/2)
				var b_length = rand_range(length/2, length)
				var a = Branch_08.new(Vector2(0,-i.length),b_length)
				a.rotation = theta	
				next.append(a)
				changeable.append(a)
				i.add_child(a)
		else:
			return
	levels -= 1
	length = length*2/3
	lines = next
	print(levels)
