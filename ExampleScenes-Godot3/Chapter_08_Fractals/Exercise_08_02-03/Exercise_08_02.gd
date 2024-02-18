extends Node2D
@onready var viewport_size = get_viewport().get_visible_rect().size

var lines = []
var side_length = 200
func _ready():
	var x_off = side_length/2
	var y_off = side_length*sin(PI/3)
	var start = Vector2(-x_off, -y_off)
	var end = Vector2(x_off, -y_off)
	
	for i in range(6):
		
		var k = Koch_Line_08_02.new(start, end)
		lines.append(k)
		
		var l = end - start
		start = end
		l = l.rotated(PI/3)
		end = l + start
		print(start)

	
	for i in range(5):
		generate()
		
	
	
	for i in lines:
		add_child(i)
		

func _process(delta):
	position.y += 1
	rotation += 0.01
	if position.y > viewport_size.y +side_length*sin(PI/3)+100:
		position.y = -side_length*sin(PI/3)-100

	
func generate():
	var next = []
	for i in lines:
		var a = i.k_start()
		var b = i.k_left()
		var c = i.k_mid()
		var d = i.k_right()
		var e = i.k_end()
		#print(a,b,c,d,e)
		
		next.append(Koch_Line_08_02.new(a,b))
		next.append(Koch_Line_08_02.new(b,c))
		next.append(Koch_Line_08_02.new(c,d))
		next.append(Koch_Line_08_02.new(d,e))
	lines = next
