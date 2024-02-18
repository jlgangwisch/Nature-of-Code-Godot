extends Node

#https://natureofcode.com/genetic-algorithms/
#Revisit the accept-reject algorithm from Chapter 0 
#and rewrite the weightedSelection() function to use accept-reject instead. 
#Like the relay race method, this technique can also end up being computationally intensive, 
#since several potential parents may be rejected as unfit before one is finally chosen.

#Implemented below:
#func select_parents_accept_reject(_population:Array, qualifying_num:float, num_of_parents:int)->Array:
	#var parents : Array 
	#for p in _population:
		#calculate_fitness("to be or not to be", p)
	#while parents.size()<num_of_parents:
		#var test_parent : exercise_09_02_DNA = population.pick_random()
		#if test_parent.fitness >= qualifying_num:
			#parents.append(test_parent)
	#return parents

var population : Array = []
@export var population_size :int = 1000
@export var population_label : Label
@export var best_label : Label
#this is used as a button to run the script in the editor
var run := false

func _ready()->void:
	population = create_word_population(population_size, 18)

func create_word_population(_population_size:int, _gene_length:int) -> Array:
	var dna_array : Array
	for p in _population_size:
		var dna = exercise_09_02_DNA.new(_gene_length)
		dna_array.append(dna)	
	return dna_array

func selection(_population:Array)->Array:
	var mating_pool :Array= []
	var parents : Array = []
	for p in _population:
		calculate_fitness("to be or not to be", p)
		var i : int = 100 * p.fitness
		for m in i:
			mating_pool.append(p)
	parents[0] = mating_pool.pick_random()
	parents[1] = mating_pool.pick_random()

	return parents



func select_parents_accept_reject(_population:Array, qualifying_num:float, num_of_parents:int)->Array:
	var parents : Array 
	for p in _population:
		calculate_fitness("to be or not to be", p)
	while parents.size()<num_of_parents:
		var test_parent : exercise_09_02_DNA = population.pick_random()
		if test_parent.fitness >= qualifying_num:
			parents.append(test_parent)
	return parents

func reproduction(_pool:Array):
	pass



func calculate_fitness(_target: String, _dna:exercise_09_02_DNA)->void:
	var score = 0;
	for i in _dna.genes.size():
		if _dna.genes_as_string[i]==_target[i]:
			score += 1
	_dna.fitness = float(score)/float(_target.length())
	print(_dna.fitness)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left_mouse"):
		run = !run
		
	elif Input.is_action_just_pressed("right_mouse"):
		#run only once
		population = create_word_population(population_size, 18)
		var parents : Array = select_parents_accept_reject(population, 0.05, 2)
		print(parents)
		
	if run:
		if population_label:
			population_label.text = ""
			for p in population:
				population_label.text += p.genes_as_string + " "
		#var fitnesses : PackedInt32Array
		#for p in population:
			
