extends Node2D

var population_num = 150
var population = []
var mating_pool = []
var target = "to be or not to be"

func _ready():
	randomize()
	initialize_population()

	
func _process(delta):
	selection()
	for i in population.size():
		population[i] = reproduce()
	print(population[0].get_phrase())

func initialize_population():
	for i in range(population_num):
		var d = DNA_e09_06.new(target)
		population.append(d)
		#print(population[i].fitness)
		
func selection():
	for i in range(population.size()):
		var n = int(population[i].fitness*100)
		for j in n:
			mating_pool.append(population[i])
	#print(mating_pool.size())

func reproduce():
	var a = int(rand_range(0, mating_pool.size()))
	var b = int(rand_range(0, mating_pool.size()))
	
	var parent_a = mating_pool[a]
	var parent_b = mating_pool[b]
	
	#print(parent_a, ", ", parent_b)
	
	#Exercise 09_04
	var mating_tries = 10000
	while mating_tries > 0 && parent_a == parent_b:
		mating_pool.remove(b)
		b = int(rand_range(0, mating_pool.size()))
		parent_b = mating_pool[b]
		mating_tries -=1
	#print("partners found!  It took ", 10000 - mating_tries, " attempts!")

	var child = DNA_e09_06.new(parent_a.target_string)
	parent_a.crossover(parent_b, child)
	child.mutate()
	child.evaluate_fitness()
	return child

