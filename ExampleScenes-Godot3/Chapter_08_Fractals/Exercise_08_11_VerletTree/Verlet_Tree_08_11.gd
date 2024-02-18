extends Position_Based_Dynamics_08_11
@onready var viewport_size = get_viewport().get_visible_rect().size

var lines = []
var vertices = []
var theta = PI/6
var levels = 10
var length = 200
var changeable = []
var wind = 100000

var noise = FastNoiseLite.new()
var n1 = 1
var n2 = 10000

#var line_vertices = PoolVector2Array([])
#var next_vertices = PoolVector2Array([])

func _ready():
	randomize()
	plant_tree()
	levels = 0
	
#	var k = Branch_10.new(start, length)
#	add_child(k)
#	lines.append(k)
	noise.seed = randi()
	noise.fractal_octaves = 4
	noise.period = 5
	noise.persistence = 0.8

func plant_tree():
	var start = Vector2(viewport_size.x/2, viewport_size.y/2+266)
	var end = start + Vector2(0,-length)
	var v1 = add_vertex(start, true)
	v1.add_to_group("vertices")
	var v2 = add_vertex(end,true)
	v1.add_child(v2)
	v2.add_to_group("vertices")
	#v1.set_mass(levels)
	#v2.set_mass(levels)
	#line_vertices.append(start)
	#line_vertices.append(end)
	var s1 = add_spring( v1, v2, compress_stiffness, stretch_stiffness, length )
	lines.append(s1)
	vertices.append(v2)
	length = length*2/3
	#print(lines)

	for i in range(levels):
		generate()
		#print(i)
	
#	var k = Branch_10.new(start, length)
#	add_child(k)
#	lines.append(k)
	length = length *2/3

func _process(delta):


	
	if Input.is_action_just_pressed("ui_down"):
		for i in $constraints.get_children():
			$constraints.remove_child(i)
			i.queue_free()
		for i in $verticles.get_children():
			$verticles.remove_child(i)
			i.queue_free()
		vertices.clear()
		lines.clear()
		levels = 3
		length = 200
		plant_tree()
		levels = 0
		#print("planted")
		
		#print($verticles.get_child_count())
		#print($constraints.get_child_count())
		return
	print(levels)
	if levels == 0:
		#for node in $verticles.get_children():
		for node in get_tree().get_nodes_in_group("vertices"):
			if node.is_static != true:
				#external_force.x = abs(sin(wind + node.position.y/100.0) + abs(sin((wind+ node.position.y/100.0)*3.67))) * 10000
	
				apply_external_forces( node, delta )
				apply_velocity_damping( node, delta, damping )
				calculate_projected_position( node, delta )
	
		solve_distance_constraint( 4, 1.0 )
		solve_floor_collision_constraint( 700.0 - position.y )
		update_vertex_position( delta )
		#update_polyline_verticles()
		
		update()
#	elif lines.size()>0:
#		var branch_index = rand_range(0,lines.size()-1)
#		if lines[branch_index].grown:
#			var leaf = Leaf_08_11.new()
#			leaf.position = Vector2(0,-lines[branch_index].length)
#			lines[branch_index].add_child(leaf)
#			lines.remove(branch_index)
#			#print (lines.size())
#	if Input.is_action_just_pressed("left_mouse"):
#		for i in changeable:
#			var l1 = noise.get_noise_1d(n1)
#			var r1 = noise.get_noise_1d(n2)
#			l1 = my_map(l1, -1,1,length/2, length)
#			r1 = my_map(r1,-1,1,-PI/2,PI/2)
#			i.length = l1
#			i.rotation = r1
#			i.update()
#			n1+=1000
#			n2+=1000
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
	var next_v = []
	for i in lines:
		var v1 = vertices[0]
		var r1 = randf_range(2,3)
		for w in range(r1):
			var l1 = noise.get_noise_1d(n1)
			var r2 = noise.get_noise_1d(n2)
			l1 = my_map(l1, -1,1,length/2, length)
			r2 = my_map(r2,-1,1,-PI/2,PI/2)
			var start = i.point_2.position
			var end = Vector2(0, -l1)
			end= end.rotated(r2)	
			end = end + start
			var v2 = add_vertex(end, false)
			v2.add_to_group("vertices")
			v1.add_child(v2)
			#v2.set_mass(levels+1)
			next_v.append(v2)
			var s1 = add_spring( v1,v2, compress_stiffness, stretch_stiffness,l1 )
			next.append(s1)
			n1+=1000
			n2+=100
		vertices.remove(0)

	length = length*2/3
	lines = next
	vertices = next_v
	#print(levels)

func my_map(input, minInput, maxInput, minOutput, maxOutput):
	#explained here: https://victorkarp.wordpress.com/2019/10/01/godot-engine-how-to-remap-a-range-of-numbers-to-another-range-visually-explained/
	var output = ( (input - minInput) / (maxInput - minInput) * (maxOutput - minOutput) + minOutput )
	return output
