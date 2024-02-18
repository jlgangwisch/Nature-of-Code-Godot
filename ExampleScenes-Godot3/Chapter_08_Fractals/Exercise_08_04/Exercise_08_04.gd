extends Node2D

@onready var viewport_size = get_viewport().get_visible_rect().size

var lines = []



func _ready():
	var k = Cantor_08_04.new(Vector2(50,50), viewport_size.y-100)
	add_child(k)
	lines.append(k)
	
	for i in range(5):
		generate()
		
func generate():
	var next = []
	for i in lines.size():
		var y = lines[i].start.y + 20
		var x = lines[i].start.x
		var l = lines[i].length
		
		var c1 = Cantor_08_04.new(Vector2(x,y),l/3)
		var c2 = Cantor_08_04.new(Vector2(x+l*2/3, y), l/3)
		
		add_child(c1)
		add_child(c2)
		next.append(c1)
		next.append(c2)
	lines = next
