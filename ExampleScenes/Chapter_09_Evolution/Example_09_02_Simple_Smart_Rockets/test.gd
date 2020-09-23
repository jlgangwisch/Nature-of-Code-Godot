extends Node2D

func _ready():
	var r = Rocket_09_02.new(500)
	r.position = Vector2(200,200)
	add_child(r)
	print(r.dna.genes[0])
