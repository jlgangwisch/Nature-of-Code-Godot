extends Node

#rewrite crossover reproduction to be 50% chance from either parent

#implemented in both below by pop_back() from array 
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
		var dna = exercise_09_05_DNA.new(_gene_length)
		dna_array.append(dna)	
	return dna_array

func selection(_population:Array, _num_of_parents:int)->Array:
	var mating_pool :Array= []
	var parents : Array = []
	for p in _population:
		calculate_fitness("to be or not to be", p)
		var i : int = 100 * p.fitness
		for m in i:
			mating_pool.append(p)
	mating_pool.shuffle()
	while parents.size() < _num_of_parents:
		parents.append(mating_pool.pop_back())
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
	#print([ranked_mating_pool[0].size(),ranked_mating_pool[1].size(),ranked_mating_pool[2].size()])
	for a in ranked_mating_pool:
		a.shuffle()
	#select parents with weighted ranks
	while parents.size()<_num_of_parents:
		var rn :float = randf()
		if rn <= 0.5 and ranked_mating_pool[0].size()>0:
			var parent :exercise_09_05_DNA = ranked_mating_pool[0].pop_back()
			parents.append(parent)
		elif rn <= 0.5 + 0.33 and ranked_mating_pool[1].size()>0:
			var parent :exercise_09_05_DNA = ranked_mating_pool[1].pop_back()
			parents.append(parent)
		else:
			var parent :exercise_09_05_DNA = ranked_mating_pool[2].pop_back()
			parents.append(parent)
	#print([ranked_mating_pool[0].size(),ranked_mating_pool[1].size(),ranked_mating_pool[2].size()])
	return parents

func reproduction_crossover(_parentA:exercise_09_05_DNA, _parentB:exercise_09_05_DNA)->exercise_09_05_DNA:
	#crossover
	var gene_length : int= _parentA.gene_length
	var midpoint = randi_range(0, gene_length)
	var child := exercise_09_05_DNA.new(gene_length)
	for i in gene_length:
		if i< midpoint:
			child.genes[i]=_parentA.genes[i]
		else:
			child.genes[i]=_parentB.genes[i]
	child.update_genes_as_string()
	return child

func reproduction_coinflip(_parentA:exercise_09_05_DNA, _parentB:exercise_09_05_DNA)->exercise_09_05_DNA:
	var gene_length : int= _parentA.gene_length
	#var midpoint = randi_range(0, gene_length)
	var child := exercise_09_05_DNA.new(gene_length)
	var rn := randi() % 2
	
	for i in gene_length:
		if rn == 0:
			child.genes[i]=_parentA.genes[i]
		else:
			child.genes[i]=_parentB.genes[i]
	child.update_genes_as_string()
	return child


func calculate_fitness(_target: String, _dna:exercise_09_05_DNA)->void:
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
		#var parents : Array = selection(population,2)
		var parents : Array = select_parents_ranked(population,2)
		#print(parents)
		var child : exercise_09_05_DNA = reproduction_coinflip(parents[0],parents[1])
		#print(parents[0].genes_as_string,parents[1].genes_as_string)
		#print(child.genes_as_string)
		
	if run:
		if population_label:
			population_label.text = ""
			for p in population:
				population_label.text += p.genes_as_string + " "
		#var fitnesses : PackedInt32Array
		#for p in population:
		
