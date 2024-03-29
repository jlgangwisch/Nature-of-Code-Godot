extends RigidBody2D

class_name Boid_e07_14

@onready var viewport_size = get_viewport().get_visible_rect().size

var velocity : = Vector2(randf_range(-1,1), randf_range(-1,1))
var acceleration : Vector2


@export var size : float

var target: Vector2
var polygon : PackedVector2Array
var color = Color(1,0,0,0.5)

var lookahead = 25
var vision_angle = PI/4

var sep_weight = 2
var coh_weight = 1.0
var align_weight = 1.0
var max_speed : float = 4
var max_force : float = 0.1



func _init(_position:Vector2, _size:float):
	position = _position
	size = _size
	
func _ready():
	
	set_gravity_scale(0)
	set_use_custom_integrator(true)
	set_linear_damp(0)
	var collider = CollisionPolygon2D.new()
	var v1 = Vector2(-size,-size)
	var v2 = Vector2(size,0)
	var v3 = Vector2(-size,size)
	polygon = PackedVector2Array([v1,v2,v3])
	collider.set_polygon(polygon)
	add_child(collider)
	color = Color(1,1,randf())
	
func _process(delta):
	rotation = velocity.angle()

func _integrate_forces(state):
	var xform = state.get_transform()
	velocity += acceleration
	velocity = velocity.limit_length(max_speed)
	xform.origin += velocity
	acceleration *= 0


	if xform.origin.x < 0-size:
		xform.origin.x += viewport_size.x+size
	elif xform.origin.x > viewport_size.x+size:
		xform.origin.x -= viewport_size.x+size
	elif xform.origin.y < 0-size:
		xform.origin.y += viewport_size.y+size
	elif xform.origin.y > viewport_size.y+size:
		xform.origin.y -= viewport_size.y+size
	
	state.set_transform(xform)
	
func flock(boids):
	var force = cellular_automata_rules(boids)
#	var force = separate(boids) * sep_weight
#	force += align(boids) * align_weight
#	force += cohere(boids) * coh_weight

	apply_force(force)

func cellular_automata_rules(boids):
	var count = 0
	var neighbor_distance = 50 * 50
	var mate_color = Color(0,0,0)
	var force = align(boids) * align_weight
	for i in boids:
		var d = position.distance_squared_to(i.position)
		if (d>0) && (d<neighbor_distance):
			count+=1
			if count == 1:
				mate_color = i.color
	
	if count > 3:
		print("killed at position: ", position)
		var d = DeadBoid_e07_14.new(position, 10, rotation)
		get_parent().get_parent().add_child(d)
		queue_free()
		
	elif count == 1:
		var r1 = randf()
		if r1 < 0.01:
			var baby_color = Color((color.r + mate_color.r)/2,(color.g + mate_color.g)/2,(color.b + mate_color.b)/2)
			get_parent().get_parent().make_baby(position, baby_color)
	elif count > 2:
		force += separate(boids) * sep_weight
	else:
		force += cohere(boids) * coh_weight
	return force

func align(boids):
	var neighbor_distance = 50 * 50

	var count = 0
	var sum = Vector2(0,0)
	for i in boids:
		
		var d = position.distance_squared_to(i.position)
		#Exercise_06_15
		if (d>0) && (d<neighbor_distance) && (position.angle_to(i.position)<vision_angle):
		#Example_06_09
		#if (d>0) && (d<neighbor_distance):
			sum += i.velocity
			count+=1
	if count>0:
		sum /= count
		sum = sum.normalized()*max_speed
		sum -= velocity
		sum = sum.limit_length(max_force)
		return sum
	else:
		return Vector2(0,0)

func unblock(boids):
	var neighbor_distance = 50 * 50
	var count = 0
	var sum = Vector2(0,0)
	for i in boids:
		
		var d = position.distance_squared_to(i.position)
		if (d>0) && (d<neighbor_distance)  && (position.angle_to(i.position)<vision_angle):
			position += Vector2(i.velocity.y, -i.velocity.x).normalized()
	

func separate(vehicles):
	var desired_separation = size * 16 * size
	var sum = Vector2()
	var count = 0
	for v in vehicles:
		var d = position.distance_squared_to(v.position)
		if (d>0) && (d < desired_separation):
			var diff = position - v.position
			diff = diff.normalized()
			diff /= d
			sum += diff
			count += 1
	if (count>0):
		sum /= count
		sum = sum.normalized()
		sum *= max_speed
		sum -= velocity
		sum = sum.limit_length(max_force)
		return sum
	else:
		return Vector2(0,0)

func cohere(boids):
	var desired_separation = size * size * size * size
	var sum = Vector2()
	var count = 0
	for b in boids:
		var d = position.distance_squared_to(b.position)
		if (d>0) && (d < desired_separation):
			sum += b.position
			count +=1
	if (count>0):
		sum /= count
		return seek(sum)
	else:
		return Vector2(0,0)

func seek(_target:Vector2):
	var desired = _target - position
	desired = desired.normalized()
	desired *= max_speed * 100
	desired -= velocity
	desired = desired.limit_length(max_force)
	return desired

func apply_force(force:Vector2):
	var f = force
	f /= mass
	acceleration += f



func _draw():
	draw_colored_polygon(polygon, color)
	#draw_circle(Vector2(0,0), size, Color(1,1,1,0.5))
	
func my_map(input, minInput, maxInput, minOutput, maxOutput):
	#explained here: https://victorkarp.wordpress.com/2019/10/01/godot-engine-how-to-remap-a-range-of-numbers-to-another-range-visually-explained/
	var output = ( (input - minInput) / (maxInput - minInput) * (maxOutput - minOutput) + minOutput )
	return output


