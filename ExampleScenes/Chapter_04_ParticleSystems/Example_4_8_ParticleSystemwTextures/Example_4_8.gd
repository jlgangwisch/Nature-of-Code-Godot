extends Node2D

const GRAVITY = Vector2(0,0.01)

onready var ps = ParticleSystem_example4_8.new()

func _ready():
	add_child(ps)

func _physics_process(delta):
	ps.apply_force(GRAVITY*-1)
