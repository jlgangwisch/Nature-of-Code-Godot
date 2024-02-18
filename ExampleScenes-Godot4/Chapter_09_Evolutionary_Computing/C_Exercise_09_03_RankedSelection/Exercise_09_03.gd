extends Node
#https://natureofcode.com/genetic-algorithms/
#In some cases, the wheel-of-fortune algorithm will have an extraordinarily high preference for some elements 
#over others. Take the following probabilities:
#Element	Probability
#A	98%
#B	1%
#C	1%
#
#This is sometimes undesirable, given that it will decrease the amount of variety in this system. 
#A solution to this problem is to replace the calculated fitness scores with the ordinals of scoring 
#(meaning their rank):
#Element	Rank	Probability
#A	1	50% (1/2)
#B	2	33% (1/3)
#C	3	17% (1/6)
#
#How can you implement an approach like this? Hint: You don’t need to modify the selection algorithm. 
#Instead, your task is to calculate the probabilities from the rank rather than the raw fitness score.

#func select_parents_ranked(_population:Array, _num_of_parents:int)->Array:
	#var parents : Array = []
	#var mating_pool :Array= []
	#
	##if 32 bit, floats won't match
	#var rank_targets: PackedFloat64Array = []
	#
	## calculate fitnesses and ranks
	#for p in _population:
		#calculate_fitness("to be or not to be", p)
		#if rank_targets.has(p.fitness):
			#pass
		#else: 
			#rank_targets.append(p.fitness)
		#rank_targets.sort()
		#rank_targets.reverse()
	#
#
	##build tiered mating pool
	#var ranked_mating_pool : Array = [ [], [], []]
	#for p in _population:
		#if p.fitness == rank_targets[0]:
			#ranked_mating_pool[0].append(p)
		#elif p.fitness == rank_targets[1]:
			#ranked_mating_pool[1].append(p)
		#elif p.fitness == rank_targets[2]:
			#ranked_mating_pool[2].append(p)
		#else:
			##print(p.fitness, rank_targets)
			#pass
	##print(ranked_mating_pool)
	#print([ranked_mating_pool[0].size(),ranked_mating_pool[1].size(),ranked_mating_pool[2].size()])
	##select parents with weighted ranks
	#while parents.size()<_num_of_parents:
		#var rn :float = randf()
		#if rn <= 0.5:
			#var parent :exercise_09_03_DNA = ranked_mating_pool[0].pick_random()
			#parents.append(parent)
		#elif rn <= 0.5 + 0.33:
			#var parent :exercise_09_03_DNA = ranked_mating_pool[1].pick_random()
			#parents.append(parent)
		#else:
			#var parent :exercise_09_03_DNA = ranked_mating_pool[2].pick_random()
			#parents.append(parent)
	#return parents


var population : Array = []
@export var population_size :int = 1000
@export var population_label : Label
@export var best_label : Label
#this is used as a button to run the script in the editor
var run := false

func _ready()->void:
	randomize()
	population = create_word_population(population_size, 18)

func create_word_population(_population_size:int, _gene_length:int) -> Array:
	var dna_array : Array
	for p in _population_size:
		var dna = exercise_09_03_DNA.new(_gene_length)
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

func select_parents_ranked(_population:Array, _num_of_parents:int)->Array:
	var parents : Array = []
	var mating_pool :Array= []
	
	#if 32 bit, floats won't match
	var rank_targets: PackedFloat64Array = []
	
	# calculate fitnesses and ranks
	for p in _population:
		calculate_fitness("to be or not to be", p)
		if rank_targets.has(p.fitness):
			pass
		else: 
			rank_targets.append(p.fitness)
		rank_targets.sort()
		rank_targets.reverse()
	

	#build tiered mating pool
	var ranked_mating_pool : Array = [ [], [], []]
	for p in _population:
		if p.fitness == rank_targets[0]:
			ranked_mating_pool[0].append(p)
		elif p.fitness == rank_targets[1]:
			ranked_mating_pool[1].append(p)
		elif p.fitness == rank_targets[2]:
			ranked_mating_pool[2].append(p)
		else:
			#print(p.fitness, rank_targets)
			pass
	#print(ranked_mating_pool)
	print([ranked_mating_pool[0].size(),ranked_mating_pool[1].size(),ranked_mating_pool[2].size()])
	#select parents with weighted ranks
	while parents.size()<_num_of_parents:
		var rn :float = randf()
		if rn <= 0.5:
			var parent :exercise_09_03_DNA = ranked_mating_pool[0].pick_random()
			parents.append(parent)
		elif rn <= 0.5 + 0.33:
			var parent :exercise_09_03_DNA = ranked_mating_pool[1].pick_random()
			parents.append(parent)
		else:
			var parent :exercise_09_03_DNA = ranked_mating_pool[2].pick_random()
			parents.append(parent)
	return parents

func reproduction(_pool:Array):
	pass



func calculate_fitness(_target: String, _dna:exercise_09_03_DNA)->void:
	var score = 0;
	for i in _dna.genes.size():
		if _dna.genes_as_string[i]==_target[i]:
			score += 1
	_dna.fitness = float(score)/float(_target.length())


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left_mouse"):
		run = !run
		
	elif Input.is_action_just_pressed("right_mouse"):
		#run only once
		population = create_word_population(population_size, 18)
		var parents : Array = select_parents_ranked(population,2)
		print(parents)
		
	if run:
		if population_label:
			population_label.text = ""
			for p in population:
				population_label.text += p.genes_as_string + " "
		#var fitnesses : PackedInt32Array
		#for p in population:
		
