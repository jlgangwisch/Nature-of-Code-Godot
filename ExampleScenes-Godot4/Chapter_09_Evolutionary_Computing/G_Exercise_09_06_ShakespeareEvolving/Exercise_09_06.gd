

extends Node2D

var population_num = 500
var population = []
var target = "to be or not to be"
var generation = 0
var finished = false

func _ready():
	randomize()
	initialize_population()
	

	
func _process(delta):
	if !finished:
		var m = selection()
		for i in population.size():
			population[i] = reproduce(m)
		generation += 1
		
		all_phrases_display()
		best_phrase_display()
		stats_display()
		fitness_display()
		
func initialize_population():
	for i in range(population_num):
		var d = exercise_09_06_DNA.new(target)
		population.append(d)
		#print(population[i].fitness)
		
func selection():
	var mating_pool = []

	#this was missing from the book.  I found this in the github code.
	var max_fitness = 0
	for i in population.size():
		if population[i].fitness > max_fitness:
			max_fitness = population[i].fitness

	for i in range(population.size()):
		#This mapping thing was also missing from the textbook
		var fitness = my_map(population[i].fitness, 0, max_fitness, 0, 1)
		var n = int(fitness*100)
		for j in n:
			mating_pool.append(population[i])
	print(mating_pool.size())
	return mating_pool


func reproduce(mating_pool):
	var a = int(randf_range(0, mating_pool.size()))
	var b = int(randf_range(0, mating_pool.size()))
	
	var parent_a = mating_pool[a]
	var parent_b = mating_pool[b]
	
	#print(parent_a, ", ", parent_b)
	
	#Exercise 09_04
	var mating_tries = 10000
	while mating_tries > 0 && parent_a == parent_b:
		mating_pool.pop_at(b)
		b = int(randf_range(0, mating_pool.size()))
		parent_b = mating_pool[b]
		mating_tries -=1
	#print("partners found!  It took ", 10000 - mating_tries, " attempts!")

	var child = exercise_09_06_DNA.new(parent_a.target_string)
	parent_a.crossover(parent_b, child)
	child.mutate()
	child.evaluate_fitness()
	#var three = Vector3(parent_a.fitness, parent_b.fitness, child.fitness)
	#print(three)
	return child

func best_phrase_display():
	var fitness_sort = []

	for i in range(population.size()):
		var n = int(population[i].fitness * 100)
		var item = [n,population[i]]
		fitness_sort.append(item)
	
	fitness_sort.sort_custom(Callable(self, "sort_descending"))
	var best_phrase = fitness_sort[0][1].get_phrase()
	#print(fitness_sort[0][0])
	$Best_Phrase/Phrase.text = best_phrase
	if best_phrase == target:
		finished = true

func all_phrases_display():
	var text = ""
	for i in population.size():
		var phrase = population[i].get_phrase() + "\n"
		text += phrase
	$All_Phrases.text = text	
	
func stats_display():
	var average_fitness = 0
	for i in population.size():
		average_fitness += population[i].fitness
	average_fitness = average_fitness /population.size()
	var n = "\n"
	var line1 = "total generations:  " + str(generation)
	var line2 = "average fitness = " + str(average_fitness)
	var line3 = "total population:  " + str(population.size())
	$Stats.text = line1 + n + line2 + n + line3

func fitness_display():
	var text = ""
	for i in population.size():
		var phrase = str(population[i].fitness) + "\n"
		text += phrase
	$All_Fitness.text = text	
static func sort_descending(a, b):
		if a[0] > b[0]:
			return true
		return false

func my_map(input, minInput, maxInput, minOutput, maxOutput):
	#explained here: https://victorkarp.wordpress.com/2019/10/01/godot-engine-how-to-remap-a-range-of-numbers-to-another-range-visually-explained/
	var output = ( (input - minInput) / (maxInput - minInput) * (maxOutput - minOutput) + minOutput )
	return output
