extends Node2D

@onready var viewport_size = get_viewport().get_visible_rect().size

var tris = []



func _ready():
	var k = Sierpinski_e08_05.new(Vector2(viewport_size.x/2,viewport_size.y/2+75),viewport_size.y/2)

	tris.append(k)
	#add_child(k)
	
	for i in range(7):
		generate()
		pass
	for i in tris:
		add_child(i)
		
func generate():
	var next = []
	for i in tris.size():
		var new_radius = tris[i].radius/2
		var new_length = tris[i].length/2
		var shift = Vector2(0,-new_radius)
		var c1 = tris[i].center + shift
		var c2 = tris[i].center + shift.rotated(2*PI/3)
		var c3 = tris[i].center + shift.rotated(-2*PI/3)
		next.append(Sierpinski_e08_05.new(c1,new_radius))
		next.append(Sierpinski_e08_05.new(c2,new_radius))
		next.append(Sierpinski_e08_05.new(c3,new_radius))
		
	tris = next
	
func _process(delta):
	pass
