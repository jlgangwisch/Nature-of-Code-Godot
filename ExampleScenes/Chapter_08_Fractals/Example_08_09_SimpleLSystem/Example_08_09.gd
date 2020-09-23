extends Node2D

var current = "A"
var count = 0

func _ready():
	print("Generation ", count, ": ", current)

func _process(delta):
	var next = ""

	for i in range(current.length()):
		#I couldn't find a way to return a character at an index in godot.  ord_at returns unicode decimal at index, which allows for this workaround.
		var c = current.ord_at(i)
		if c == "A".ord_at(0):
			next += "AB"
		elif c == "B".ord_at(0):
			next += "A"
	
	current = next
	count += 1
	print("Generation ", count, ": ", current)
			
