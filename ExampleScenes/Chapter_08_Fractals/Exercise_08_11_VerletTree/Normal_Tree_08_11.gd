
extends Node2D
onready var viewport_size = get_viewport().get_visible_rect().size

var lines = []
var theta = PI/6
var levels = 10
var length = 200
var changeable = []

var noise = OpenSimplexNoise.new()
var n1 = 1
var n2 = 10000

func _ready():
	randomize()
	var start = Vector2(viewport_size.x/3-100, viewport_size.y/2+266)
	var end = start + Vector2(0,-length)
	
	var k = Branch_10.new(start, length)
	add_child(k)
	lines.append(k)
	length = length *2/3
	noise.seed = randi()
	noise.octaves = 4
	noise.period = 5
	noise.persistence = 0.8

func _process(delta):
	if levels >0:
		generate()
	elif lines.size()>0:
		var branch_index = rand_range(0,lines.size()-1)
		if lines[branch_index].grown:
			var leaf = Leaf_08_11.new()
			leaf.position = Vector2(0,-lines[branch_index].length)
			lines[branch_index].add_child(leaf)
			lines.remove(branch_index)
			#print (lines.size())
	if Input.is_action_just_pressed("ui_up"):
		for i in changeable:
			var l1 = noise.get_noise_1d(n1)
			var r1 = noise.get_noise_1d(n2)
			l1 = my_map(l1, -1,1,length/2, length)
			r1 = my_map(r1,-1,1,-PI/2,PI/2)
			i.length = l1
			i.rotation = r1
			i.update()
			n1+=1000
			n2+=1000
#	for i in changeable:
#		var r1 = noise.get_noise_1d(n2)
#
#		r1 = my_map(r1,-1,1,-PI/16,PI/16)
#		i.rotation += r1/100
#		#print(r1)
#		n2+=0.00001
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
				var l1 = noise.get_noise_1d(n1)
				var r2 = noise.get_noise_1d(n2)
				l1 = my_map(l1, -1,1,length/2, length)
				r2 = my_map(r2,-1,1,-PI/2,PI/2)
			
				
				var a = Branch_08_11.new(Vector2(0,-i.length),l1)
				a.rotation = r2	
				next.append(a)
				changeable.append(a)
				i.add_child(a)
				n1+=1000
				n2+=100
		else:
			return
	levels -= 1
	length = length*2/3
	lines = next
	#print(levels)

func my_map(input, minInput, maxInput, minOutput, maxOutput):
	#explained here: https://victorkarp.wordpress.com/2019/10/01/godot-engine-how-to-remap-a-range-of-numbers-to-another-range-visually-explained/
	var output = ( (input - minInput) / (maxInput - minInput) * (maxOutput - minOutput) + minOutput )
	return output
