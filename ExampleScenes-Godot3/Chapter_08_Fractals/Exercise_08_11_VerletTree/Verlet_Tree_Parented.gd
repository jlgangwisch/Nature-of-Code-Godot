
extends Position_Based_Dynamics_08_11
@onready var viewport_size = get_viewport().get_visible_rect().size

var lines = []
var theta = PI/6
var levels = 3
var length = 200
var changeable = []

var noise = FastNoiseLite.new()
var n1 = 1
var n2 = 10000

func _ready():
	randomize()
	var start = Vector2(viewport_size.x/2, viewport_size.y/2+266)
	var end = start + Vector2(0,-length)
	
	var k = Verlet_Branch_08_11.new(start, length, true)
	add_child(k)
	lines.append(k)
	length = length *2/3
	noise.seed = randi()
	noise.fractal_octaves = 4
	noise.period = 5
	noise.persistence = 0.8

func _process(delta):
	if levels >0:
		generate()
	elif lines.size()>0:
		var branch_index = randf_range(0,lines.size()-1)
		if lines[branch_index].grown:
			var leaf = Leaf_08_11.new()
			leaf.position = Vector2(0,-lines[branch_index].length)
			lines[branch_index].add_child(leaf)
			lines.remove(branch_index)

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


	
func generate():
	var next = []
	for i in lines:
		if i.grown:
			
			var r1 = randf_range(2,3)
			for w in range(r1):
				var l1 = noise.get_noise_1d(n1)
				var r2 = noise.get_noise_1d(n2)
				l1 = my_map(l1, -1,1,length/2, length)
				r2 = my_map(r2,-1,1,-PI/2,PI/2)
			
				
				var a =Verlet_Branch_08_11.new(Vector2(0,-i.length),l1, false)
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


func my_map(input, minInput, maxInput, minOutput, maxOutput):
	#explained here: https://victorkarp.wordpress.com/2019/10/01/godot-engine-how-to-remap-a-range-of-numbers-to-another-range-visually-explained/
	var output = ( (input - minInput) / (maxInput - minInput) * (maxOutput - minOutput) + minOutput )
	return output
