extends Node2D

class_name exercise_09_08_DNA

var genes = []

var fitness = 0.0
var target_string
var low_mutation_rate = 0.01
var high_mutation_rate = 0.1

func _init(_target_string):
	target_string = _target_string
	generate_DNA()

	evaluate_fitness()

func evaluate_fitness()->void:
	var score = 0
	for i in genes.size():
		if genes[i].unicode_at(0) == target_string.unicode_at(i):
			score += 1
	#exercise 9.8
	# old fitness = float(score) / target_string.length()
	fitness = float(pow(score, 2)) / (target_string.length() * target_string.length())
	#print(genes.size())

func generate_DNA():
	#google says the longest word in the english language is: pneumonoultramicroscopicsilicovolcanoconiosis
	#var word_length = rand_range(0,"pneumonoultramicroscopicsilicovolcanoconiosis".length())
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
	

func mutate(low: bool)->void:
	var mutation_rate : float
	if low:
		mutation_rate = low_mutation_rate
	else:
		mutation_rate = high_mutation_rate
	for i in genes.size():
		var og = genes[i]
		var r1 = randf()
		if r1 < mutation_rate:
			var new_character = String.chr(randf_range(32,128))
			genes[i] = new_character
			#print("was ", og, ", is now ", new_character, " at position: ", i)

func get_phrase():
	var phrase = ""
	for i in genes.size():
		phrase += genes[i]
	return phrase
	
func my_map(input, minInput, maxInput, minOutput, maxOutput):
	#explained here: https://victorkarp.wordpress.com/2019/10/01/godot-engine-how-to-remap-a-range-of-numbers-to-another-range-visually-explained/
	var output = ( (input - minInput) / (maxInput - minInput) * (maxOutput - minOutput) + minOutput )
	return output
