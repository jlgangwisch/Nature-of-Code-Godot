extends Node2D
onready var viewport_size = get_viewport().get_visible_rect().size

var lines = []
var theta = PI/6
var levels = 10
var length = 100
var rotate_r = []
var rotate_l = []

func _ready():
	
	var start = Vector2(viewport_size.x/2, viewport_size.y/2+166)
	var end = start + Vector2(0,-100)
	
	var k = Branch_09_experiment.new(start, length)
	$Root.add_child(k)
	lines.append(k)
	length = length *2/3

func _process(delta):
	if levels >0:
		generate()
	elif lines.size()>0:
		var branch_index = rand_range(0,lines.size()-1)
		if lines[branch_index].grown:
			var leaf = Leaf_08_09.new()
			leaf.position = Vector2(0,-lines[branch_index].length)
			lines[branch_index].add_child(leaf)
			lines.remove(branch_index)
			print (lines.size())
	theta = get_global_mouse_position().x/100
	for i in rotate_r:
		i.rotation = theta
	for i in rotate_l:
		i.rotation = -theta
	

	
func generate():
	var next = []
	for i in lines:
		if i.grown:
			
	
			var a = Branch_09_experiment.new(Vector2(0,-i.length),length)
			var b = Branch_09_experiment.new(Vector2(0,-i.length), length)
			#print(a,b,c,d,e)
			a.rotation = -theta
			b.rotation = theta
	
			next.append(a)
			next.append(b)
			rotate_l.append(a)
			rotate_r.append(b)
			i.add_child(a)
			i.add_child(b)
		else:
			return
	levels -= 1
	length = length*2/3
	lines = next
	print(levels)
