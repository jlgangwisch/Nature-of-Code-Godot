extends Position_Based_Dynamics_08_11

class_name Verlet_Branch_08_11

var a
var b
var theta = PI/6
var length
var width = 1
var cur_length = 0
var grown = false
var verticles = Node2D.new()
var constraints = Node2D.new()
var origin
var v1
var v2
var isTrunk
var line_vertices = PackedVector2Array([])


func _init(start, _length, _isTrunk):
	position = start
	isTrunk = _isTrunk
	length = _length
	b = Vector2(0,-length)
	width = length/10
	grown = true
	
	
func _ready():
	add_child(verticles)
	add_child(constraints)
	verticles.set_name("verticles")
	constraints.set_name("constraints")
	compress_stiffness = get_parent().compress_stiffness
	stretch_stiffness = get_parent().stretch_stiffness
	damping = get_parent().damping
	gravity = get_parent().gravity
	generate_body()
	
	

	
#func _draw():
#	draw_line(Vector2(0,0), b,Color(0,0,0), width)
#


func generate_body():
	v1 = add_vertex(Vector2(0,0))
	v1.add_to_group("vertices")
	v2 = add_vertex(b)
	v2.add_to_group("vertices")
	var s1 = add_spring(v1,v2,compress_stiffness,stretch_stiffness)
