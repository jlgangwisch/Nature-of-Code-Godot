extends Node2D
onready var viewport_size = get_viewport().get_visible_rect().size

var lines = []

func _ready():
	
	var start = Vector2(0,300)
	var end = Vector2(600, 300)
	
	var k = Koch_Line_08_05.new(start, end)
	lines.append(k)
	
	for i in range(1):
		generate()
	
	for i in lines:
		add_child(i)
	
func generate():
	var next = []
	for i in lines:
		var a = i.k_start()
		var b = i.k_left()
		var c = i.k_mid()
		var d = i.k_right()
		var e = i.k_end()
		#print(a,b,c,d,e)
		print (b.distance_to(d))
		next.append(Koch_Line_08_05.new(a,b))
		next.append(Koch_Line_08_05.new(b,c))
		next.append(Koch_Line_08_05.new(c,d))
		next.append(Koch_Line_08_05.new(d,e))
	lines = next
