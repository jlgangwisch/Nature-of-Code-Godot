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
		add_child(d)
		population.append(d)
		#print(population[i].fitness)
		
func selection():
	#rank 1 will get added to the mating pool 3 times, 2 twice, and 3 once.
	var rank1 = 3
	var rank2 = 33
	var rank3 = 17
	
	var fitness_sort = []


	for i in range(population.size()):
		var n = int(population[i].fitness * 100)
		var item = [n,population[i]]
		fitness_sort.append(item)
	
	fitness_sort.sort_custom(self, "sort_descending")
	
	for i in range(rank1):
		mating_pool.append(fitness_sort[i][1])
		mating_pool.append(fitness_sort[i][1])
		mating_pool.append(fitness_sort[i][1])
		fitness_sort.remove(i)
	for i in range(rank2):
		mating_pool.append(fitness_sort[i][1])
		mating_pool.append(fitness_sort[i][1])
		fitness_sort.remove(i)
	for i in range(rank3):
		mating_pool.append(fitness_sort[i][1])
		fitness_sort.remove(i)

		
		
static func sort_descending(a, b):
		if a[0] > b[0]:
			return true
		return false
