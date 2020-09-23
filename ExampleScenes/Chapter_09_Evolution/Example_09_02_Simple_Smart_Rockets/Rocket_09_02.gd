extends Area2D

class_name Rocket_09_02

var velocity : Vector2
var acceleration : Vector2
var size = 10

var rocket_color = Color(1,0,0)
var rocket_points = PoolVector2Array()

var fitness = 0.0

var lifetime = 0

var curr_frame = 0

var dna

var hit_target = false

func _init(_start_pos: Vector2, _lifetime:int):
	position = _start_pos
	lifetime = _lifetime
	dna = DNA_09_02.new(lifetime)

func _ready():

	var v1 = Vector2(-size, -size)
	var v2 = Vector2(size+size, 0)
	var v3 = Vector2(-size, size)
	rocket_points = PoolVector2Array([v1,v2,v3])
	
	var c = CollisionPolygon2D.new()
	c.set_polygon(rocket_points)
	add_child(c)
	


func _process(delta):
	pass

func run(curr_frame,target):
	check_target(target)
	if !hit_target:
		apply_force(dna.genes[curr_frame])
		velocity += acceleration
		position += velocity
		rotation = velocity.angle()
		acceleration *= 0


func evaluate_fitness(target:Vector2):
	
	var d = check_target(target)
	fitness = pow (1/d, 2)

func check_target(target):
	var nose = position + Vector2(size+size, 0).rotated(rotation)
	var d = nose.distance_to(target)
	if d < 10:
		hit_target = true
	return d


func apply_force(f:Vector2):
	acceleration += f

	
func _draw():

	
	var thruster_radius = size/2
	var offset = Vector2(thruster_radius/2, thruster_radius/2)
	var thruster1 = Rect2(rocket_points[0]-offset+Vector2(0,thruster_radius), Vector2(thruster_radius,thruster_radius))
	var thruster2 = Rect2(rocket_points[2]-offset-Vector2(0,thruster_radius), Vector2(thruster_radius,thruster_radius))
	draw_rect(thruster1,Color(0,0,1))
	draw_rect(thruster2,Color(0,0,1))
	draw_colored_polygon(rocket_points,rocket_color)


func _on_Rocket_09_02_mouse_exited():
	print("test")
	pass # Replace with function body.


func _on_Rocket_09_02_mouse_entered():
	print("test")
