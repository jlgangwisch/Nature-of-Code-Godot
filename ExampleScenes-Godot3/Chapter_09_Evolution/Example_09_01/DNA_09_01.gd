extends Node2D

class_name DNA_09_01

var genes = []

var fitness = 0.0
var target_string
var mutation_rate = 0.1

func _init(_target_string):
	generate_DNA()
	target_string = _target_string
	evaluate_fitness()

func evaluate_fitness():
	var score = 0
	for i in genes.size():
		if genes[i].ord_at(0) == target_string.ord_at(i):
			score += 1
	fitness = float(score)/target_string.length()

func generate_DNA():
	#google says the longest word in the english language is: pneumonoultramicroscopicsilicovolcanoconiosis
	#var word_length = rand_range(0,"pneumonoultramicroscopicsilicovolcanoconiosis".length())
	var phrase_length = 18
	for i in phrase_length:
		#range is the ASCII code for space through DEL
		var c = randf_range(32,128)
		genes.append(char(c))

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
			var new_character = char(randf_range(32,128))
			genes[i] = new_character
			#print("was ", og, ", is now ", new_character, " at position: ", i)

func get_phrase():
	var phrase = ""
	for i in genes.size():
		phrase += genes[i]
	return phrase
