extends Node2D
#left mouse randomizes seeding row with floats



onready var viewport_size = get_viewport().get_visible_rect().size
onready var width = viewport_size.x/num_cells
onready var height = viewport_size.y/width

var num_cells = 256
var cells = []

var ruleset = []
var new = true
var grid = []

var start_delay = 0

var rf1 = 0.2
var rf2 = 0.8

func _ready():
	randomize()

	for i in range(num_cells):
		cells.append(Vector3(randf(),randf(), randf()))
	cells[cells.size()/2] = (Vector3(1,1,1))

	grid.append(cells)



func _process(delta):
	if start_delay < 5:
		update()
		start_delay += 1
	else:
		grid.append(generate())
		update()
		if grid.size() > height:
			grid.pop_front()
	if Input.is_action_just_released("left_mouse"):
		randomize_seeder_row()
	if Input.is_action_just_released("right_mouse"):
		rand_ruleset()
		
func randomize_seeder_row():
	for i in range(num_cells):
		var last_row = grid.back()
		last_row[i] = Vector3(randf(),randf(),randf())

func generate():
	var new_cells = []
	new_cells.resize(cells.size())

	var prev_row = grid.back()
	for i in range(prev_row.size()):
		var m = prev_row[i]
		var l
		var r
		if i == 0:
			l = prev_row[i]
			r = prev_row[i+1]
		elif i == cells.size()-1:
			r = prev_row[i]
			l = prev_row[i-1]
		else:
			l = prev_row[i-1]
			r = prev_row[i+1]
			
		new_cells[i] = rules(l,m,r)


	return new_cells

	
# old rules used the 8 bit ruleset.  New rules use probabilities
#func rules(left,middle,right):
#	var s = str(left) + str(middle) + str(right)
#	var index = bin2dec(int(s))
#	return ruleset[index]

func rules(left, middle, right):
	var r = (left.x + right.x + middle.x)/3
	var g = (left.y + middle.y + right.y)/3
	var b = (left.z + middle.z + right.z)/3
	var index = Vector3(r,g,b)

	return index

#used instead of parsing strings
func bin2dec(var binary_value):
	var decimal_value = 0
	var count = 0
	var temp
	while(binary_value != 0):
		temp = binary_value % 10
		binary_value /= 10
		decimal_value += temp * pow(2, count)
		count += 1
	return decimal_value

func rand_ruleset():
#	this used the normal 8 bit ruleset
#	for i in range(ruleset.size()):
#		ruleset[i] = randf()
	rf1 = randf()
	rf2 = randf()

func _draw():

	var size = Vector2(width,width)
	for i in range(grid.size()):
		for j in range (grid[i].size()):
			var c = grid[i][j]
			var color = Color(c.x,c.y,c.z)
#			var color = Color (0,0,0)
#			if grid[i][j] == 1:
#				color = Color (1,1,1)
			var pos = Vector2(width * j, i*width)
			draw_rect(Rect2(pos, size), color)
	
