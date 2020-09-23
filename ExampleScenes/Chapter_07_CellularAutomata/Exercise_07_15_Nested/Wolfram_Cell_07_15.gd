extends Node2D
#left mouse randomizes seeding row
#right mouse ranomizes ruleset
class_name Wolfram_07_15

var num_cells = 8
var cells = []

var ruleset = []
var new = true
var grid = []

var start_delay = 0

var cur_state = 0
var prev_state = 0

var sum = 0.0
var size = 10
func _ready():
	randomize()
	ruleset = [0,1,0,1,1,0,1,0]
#	ruleset = rand_ruleset()
	#get_viewport().set_clear_mode(Viewport.CLEAR_MODE_NEVER)
	for i in range(num_cells):
		cells.append(randi()%2)
	print("ruleset: ", ruleset)
	grid.append(cells)



func _process(delta):
	if start_delay < 5:

		start_delay += 1
	
	else:
		grid.append(generate())
		grid.pop_front()

		

	if Input.is_action_just_released("ui_up"):
		randomize_seeder_row()

	update()
	sum_array()
	if sum > 0.5:
		cur_state = 1

	
func randomize_seeder_row():
	for i in range(num_cells):
		var last_row = grid.back()
		last_row[i] = randi()%2

func generate():
	var new_cells = []
	new_cells.resize(cells.size())
	
	#edges double themselves
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

func sum_array():

	for i in grid[0].size():
		sum += grid[0][i] 
	sum = sum /8

func rules(left,middle,right):
	var s = str(left) + str(middle) + str(right)
	var index = bin2dec(int(s))
	
	return ruleset[index]

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


func _draw():
	var color = Color(cur_state-sum,sum,prev_state-sum)
	draw_rect(Rect2(Vector2(0,0), Vector2(size,size)), color)
