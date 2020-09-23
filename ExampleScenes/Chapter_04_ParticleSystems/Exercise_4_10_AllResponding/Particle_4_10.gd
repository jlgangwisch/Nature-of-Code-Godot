extends Node2D

class_name Particle_e4_10

onready var viewport_size = get_viewport().get_visible_rect().size

var velocity = Vector2()
var acceleration = Vector2()
var lifetime = float()
var size = float()
var color = Color()
var mass = float()


func _ready():
	randomize()
	acceleration = Vector2(0,0)
	velocity = Vector2(rand_range(-1,1), rand_range(-2,0))
	lifetime = 1.0
	color = Color(randf(),randf(),randf())
	size = rand_range(5,10)
	mass = size
	
func _physics_process(delta):
	
	velocity += acceleration
	position += velocity
	update()
	lifetime -= .01
	if lifetime < 0:
		queue_free()

#it looks like draw calls on every level, so to get around it create a custom function that includes the confetti shape.
func _draw():
	confetti_shape()
	
func confetti_shape():
	draw_circle(Vector2(0,0), size, Color(color.r,color.g,color.b, lifetime))

func apply_force(force):
	var f = force
	f /= mass
	acceleration += f

func repel(particle):
	var dir = position - particle.position
	var d = dir.length()
	d = clamp(d, 50, 100)
	dir = dir.normalized()
	var force = -1/ (d * d)
	dir *= force 
	return dir
