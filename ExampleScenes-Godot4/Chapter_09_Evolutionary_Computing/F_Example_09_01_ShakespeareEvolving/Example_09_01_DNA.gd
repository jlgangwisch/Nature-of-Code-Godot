extends Node2D

class_name example_09_01_DNA

var genes = []

var fitness = 0.0
var target_string
var mutation_rate = 0.01

func _init(_target_string):
	target_string = _target_string
	generate_DNA()
	evaluate_fitness()

func evaluate_fitness():
	var score = 0
	for i in genes.size():
		if genes[i].unicode_at(0) == target_string.unicode_at(i):
			score += 1
	fitness = float(score)/target_string.length()


func generate_DNA():
	var phrase_length = target_string.length()
	for i in phrase_length:
		#range is the ASCII code for space through DEL
		var c = randf_range(32,128)
		genes.append(String.chr(c))

func crossover(partner, child):
	var midpoint = int(randf_range(0,genes.size()))
	for i in genes.size():
		if i > midpoint:
			child.genes[i] = genes[i]
		else:
			child.genes[i] = partner.genes[i]
			
func mutate():
	for i in genes.size():
		var og = genes[i]
		var r1 = randf()
		if r1 < mutation_rate:
			var new_character = String.chr(randf_range(32,128))
			genes[i] = new_character


func get_phrase():
	var phrase = ""
	for i in genes.size():
		phrase += genes[i]
	return phrase
	
