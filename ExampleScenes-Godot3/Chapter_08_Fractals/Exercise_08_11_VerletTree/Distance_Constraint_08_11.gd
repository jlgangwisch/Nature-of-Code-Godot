extends Node2D

class_name Distance_Constraint_08_11

@export var node_path_1: NodePath: set = set_node_1
@export var node_path_2: NodePath: set = set_node_2

var point_1:PointMass_08_11
var point_2:PointMass_08_11

var mass_ratio_1 :float = 0
var mass_ratio_2 :float = 0

var constrain_vector  := Vector2( 0.0, 0.0 )
var rest_length       := 0.0
var compress_stiffness:= 0.1
var stretch_stiffness := 0.1

var sprite_size = Vector2(20,128)


func initialize( node_1:PointMass_08_11, node_2:PointMass_08_11, length):
	point_1 = node_1
	point_2 = node_2
	constrain_vector = point_2.position - point_1.position #- d
	#constrain_vector = Vector2(0, -length)
	rest_length = constrain_vector.length()
	
func _ready():
	if !point_1:
		point_1 = get_node(node_path_1) as PointMass_08_11
	if !point_2:
		point_2 = get_node(node_path_2) as PointMass_08_11
	point_1.add_neighbor(point_2)
	point_2.add_neighbor(point_1)
	mass_ratio_1 = point_1.mass / (point_1.mass + point_2.mass)
	mass_ratio_2 = point_2.mass / (point_1.mass + point_2.mass)


func _physics_process(delta):
	if point_1 and point_2 :
		position            = 0.5 * ( point_1.position + point_2.position )
		
		var relation_vector := point_1.position - point_2.position
		
		rotation            = atan2( relation_vector.x, -relation_vector.y )
		scale.y             = max(10, relation_vector.length()) / sprite_size.y
		scale.x             = sprite_size.x / clamp( relation_vector.length(), sprite_size.x, sprite_size.y )
	update()



func set_node_1(value:NodePath):
	node_path_1 = value
	
	
func set_node_2(value:NodePath):
	node_path_2 = value

func _draw():
	#draw_line(a,b,Color(0,0,1),width)
	sprite_size.x = rest_length/5
	draw_rect(Rect2(-sprite_size/2, sprite_size), Color(0,0,1))
