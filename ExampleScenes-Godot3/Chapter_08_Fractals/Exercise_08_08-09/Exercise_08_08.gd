extends Node2D
@onready var viewport_size = get_viewport().get_visible_rect().size

var lines = []
var theta = PI/6
var levels = 7

func _ready():
	
	var start = Vector2(viewport_size.x/2, viewport_size.y/2+166)
	var end = start + Vector2(0,-100)
	
	var k = Branch_08_08.new(start, end)
	add_child(k)
	lines.append(k)

func _process(delta):
	if levels >0:
		generate()
	elif lines.size()>0:
		var leaf = Leaf_08_09.new()
		var branch_index = randf_range(0,lines.size()-1)
		leaf.position = lines[branch_index].b
		add_child(leaf)
		lines.remove(branch_index)
		print (lines.size())




	
func generate():
	var next = []
	for i in lines:
		if i.grown:
			var newpoints = i.branch()
	
			var a = Branch_08_08.new(i.b,newpoints[0])
			var b = Branch_08_08.new(i.b,newpoints[1])
			#print(a,b,c,d,e)
	
			next.append(a)
			next.append(b)
			add_child(a)
			add_child(b)
		else:
			return
	levels -= 1
	lines = next
	print(levels)
