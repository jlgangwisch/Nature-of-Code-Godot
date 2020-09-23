extends Node2D

var population_num = 100
var population = []

var mating_pool = []

func _ready():
	initialize_population()
	selection()
	
func initialize_population():
	for i in range(population_num):
		var d = DNA_09_01.new("to be or not to be")
		population.append(d)
		#print(population[i].fitness)
		
func selection():
	for i in range(population.size()):
		var n = int(population[i].fitness * 100)
		print(n)
		for j in range(n):
			mating_pool.append(population[i])

func monte_carlo(_fitness_score):
	var count = 10000
	while count<10000:
		var r1 = randf()
		var probability = r1*_fitness_score
		var r2 = randf()
		if (r2 < probability):
			return r1
	return 0

func monte_carlo_selection():
	for i in range(population.size()):
		var n = int(population[i].fitness * 100)
		monte_carlo(n)
		for j in range(n):
			mating_pool.append(population[i])
