extends Area2D

class_name Rocket_e09_08

var velocity : Vector2
var acceleration : Vector2
var size = 10

var rocket_color = Color(1,0,0)
var rocket_points = PoolVector2Array()

var fitness = 0.0

var lifetime = 0

var my_frame = 0

var dna

var hit_target = false

var obstacles = []

var stopped = false

var record = 100000000

var finish_time = 0

func _init(_start_pos: Vector2, _lifetime:int):
	position = _start_pos
	lifetime = _lifetime
	dna = DNA_09_03.new(lifetime)

func _ready():
	finish_time = lifetime
	var v1 = Vector2(-size, -size)
	var v2 = Vector2(size+size, 0)
	var v3 = Vector2(-size, size)
	rocket_points = PoolVector2Array([v1,v2,v3])
	obstacles = get_parent().obstacles
	var c = CollisionPolygon2D.new()
	c.set_polygon(rocket_points)
	add_child(c)
	


func _process(delta):
	pass

func obstacles():
	for i in obstacles:
		if i.contains(position):
			stopped = true
			
func run(curr_frame,target):
	if !stopped:
		check_target(target)
		if !hit_target:
			apply_force(dna.genes[curr_frame])
			velocity += acceleration
			position += velocity
			rotation = velocity.angle()
			acceleration *= 0
			obstacles()
			my_frame +=1
			


func evaluate_fitness(target:Vector2):
	
	var d = check_target(target)
	if stopped:
		finish_time = lifetime
	fitness = 1/(finish_time * record)
	fitness = pow (fitness, 2)
	if stopped:
		fitness *= 0.001
	if hit_target:
		fitness *= 2
	#this is a hacky solution for this course only.  It should be done properly with some sort of line of sight
	if position.x<obstacles[2].position.x:
		fitness *= 0.01
	if position.y < obstacles[0].position.y:
		fitness *= 0.1
	if position.y > obstacles[1].position.y:
		fitness *= 0.1
	if position.x > obstacles[4].position.x:
		fitness *= 0.01
func check_target(target):
	var nose = position + Vector2(size+size, 0).rotated(rotation)
	var d = nose.distance_to(target)
	if d < 10:
		hit_target = true
		finish_time = my_frame
		#record = 1
		#d = 1
	if d < record:
		record = d
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
