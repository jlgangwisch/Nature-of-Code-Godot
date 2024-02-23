extends Node

#rewrite crossover reproduction to be 50% chance from either parent

#implemented in both below by pop_back() from array 
var population : Array = []
@export var population_size :int = 150
@export var population_label : Label
@export var best_label : Label
@export var target_string = "to be or not to be"
@export var best_element : example_09_01_DNA
#this is used as a button to run the script in the editor
var run := false

func _ready()->void:
	randomize()
	population = create_word_population(population_size, target_string.length())
	population_label = $population_label
	best_label = $best_label
	best_element = population[0]

func create_word_population(_population_size:int, _gene_length:int) -> Array:
	var dna_array : Array
	for p in _population_size:
		var dna = example_09_01_DNA.new(_gene_length)
		dna_array.append(dna)	
	return dna_array

func selection(_population:Array, _num_of_parents:int)->Array:
	var mating_pool :Array= []
	var parents : Array = []
	for p in _population:
		calculate_fitness(target_string, p)
		check_if_best_string(p)
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
		calculate_fitness(target_string, p)
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
			best_label.text = p.genes_as_string
			if best_label.text == target_string:
				run = false
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
			var parent :example_09_01_DNA = ranked_mating_pool[0].pop_back()
			parents.append(parent)
		elif rn <= 0.5 + 0.33 and ranked_mating_pool[1].size()>0:
			var parent :example_09_01_DNA = ranked_mating_pool[1].pop_back()
			parents.append(parent)
		else:
			var parent :example_09_01_DNA = ranked_mating_pool[2].pop_back()
			parents.append(parent)
	#print([ranked_mating_pool[0].size(),ranked_mating_pool[1].size(),ranked_mating_pool[2].size()])
	return parents

func reproduction_crossover(_parentA:example_09_01_DNA, _parentB:example_09_01_DNA)->example_09_01_DNA:
	#crossover
	var gene_length : int= _parentA.gene_length
	var midpoint = randi_range(0, gene_length)
	var child := example_09_01_DNA.new(gene_length)
	for i in gene_length:
		if i< midpoint:
			child.genes[i]=_parentA.genes[i]
		else:
			child.genes[i]=_parentB.genes[i]
	child.update_genes_as_string()
	return child

func reproduction_coinflip(_parentA:example_09_01_DNA, _parentB:example_09_01_DNA)->example_09_01_DNA:
	var gene_length : int= _parentA.gene_length
	#var midpoint = randi_range(0, gene_length)
	var child := example_09_01_DNA.new(gene_length)
	var rn := randi() % 2
	
	for i in gene_length:
		if rn == 0:
			child.genes[i]=_parentA.genes[i]
		else:
			child.genes[i]=_parentB.genes[i]
	child.update_genes_as_string()
	return child

func mutate(_dna: example_09_01_DNA, _mutation_rate: float)->void:
	var gene_length : int= _dna.gene_length
	var rn := randf()
	for i in gene_length:
		if rn < _mutation_rate:
			_dna.genes[i] = randi_range(_dna.gene_min,_dna.gene_max)
			_dna.update_genes_as_string()
		

func calculate_fitness(_target: String, _dna:example_09_01_DNA)->void:
	var score = 0;
	for i in _dna.genes.size():
		if _dna.genes_as_string[i]==_target[i]:
			score += 1
	_dna.fitness = float(score)/float(_target.length())


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left_mouse"):
		run = !run
		print(run)
	elif Input.is_action_just_pressed("right_mouse"):
		#run only once
		run_generation()
		
	if run:

		run_generation()
func check_if_best_string(element: example_09_01_DNA)->bool:
	var is_best:=false
	if element.fitness >= best_element.fitness:
		best_element = element
		best_label.text = element.genes_as_string
		if best_label.text == target_string:
			run = false
	return is_best
	
func run_generation()->void:
	
	for i in population.size():
		#var parents : Array = select_parents_ranked(population,2)
		var parents : Array = selection(population,2)
		#var child : example_09_01_DNA = reproduction_coinflip(parents[0],parents[1])
		var child : example_09_01_DNA = reproduction_crossover(parents[0],parents[1])
		mutate(child, 0.01)
		population[i]=child
			
	if population_label:
		population_label.text = ""
		for p in population:
			population_label.text += p.genes_as_string + " "
