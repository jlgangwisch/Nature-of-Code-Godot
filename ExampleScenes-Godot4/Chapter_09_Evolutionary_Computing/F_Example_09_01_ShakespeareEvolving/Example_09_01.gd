extends Node

var population_num : int = 150
var population : Array = []
var target : String = "to be or not to be"
var generation : int = 0
var finished := false

func _ready():
	randomize()
	initialize_population()
	

	
func _process(delta):
	if !finished:
		var m : Array = selection()
		for i in population.size():
			population[i] = reproduce(m)
		generation += 1
		
		#all_phrases_display()
		#best_phrase_display()
		#stats_display()
		#fitness_display()
		#
func initialize_population():
	for i in range(population_num):
		var d = example_09_01_DNA.new(target)
		population.append(d)

		
func selection()->Array:
	var mating_pool := []
	var max_fitness : int = 0
	for i in population.size():
		if population[i].fitness > max_fitness:
			max_fitness = population[i].fitness
			
		#normalizes fitness
		var fitness = lerp(0.0,1.0, population[i].fitness)
		var n = int(fitness*100)
		for j in n:
			mating_pool.append(population[i])

	return mating_pool


func reproduce(mating_pool):
	#exercise 4
	mating_pool.shuffle()
	var parent_a = mating_pool[0]
	var parent_b = mating_pool[1]

	var child = example_09_01_DNA.new(parent_a.target_string)
	parent_a.crossover(parent_b, child)
	child.mutate()
	child.evaluate_fitness()
	#var three = Vector3(parent_a.fitness, parent_b.fitness, child.fitness)
	#print(three)
	return child
#
#func best_phrase_display():
	#var fitness_sort = []
#
	#for i in range(population.size()):
		#var n = int(population[i].fitness * 100)
		#var item = [n,population[i]]
		#fitness_sort.append(item)
	#
	#fitness_sort.sort_custom(Callable(self, "sort_descending"))
	#var best_phrase = fitness_sort[0][1].get_phrase()
	##print(fitness_sort[0][0])
	#$Best_Phrase/Phrase.text = best_phrase
	#if best_phrase == target:
		#finished = true
#
#func all_phrases_display():
	#var text = ""
	#for i in population.size():
		#var phrase = population[i].get_phrase() + "\n"
		#text += phrase
	#$All_Phrases.text = text	
	#
#func stats_display():
	#var average_fitness = 0
	#for i in population.size():
		#average_fitness += population[i].fitness
	#average_fitness = average_fitness /population.size()
	#var n = "\n"
	#var line1 = "total generations:  " + str(generation)
	#var line2 = "average fitness = " + str(average_fitness)
	#var line3 = "total population:  " + str(population.size())
	#$Stats.text = line1 + n + line2 + n + line3
#
#func fitness_display():
	#var text = ""
	#for i in population.size():
		#var phrase = str(population[i].fitness) + "\n"
		#text += phrase
	#$All_Fitness.text = text	
#static func sort_descending(a, b):
		#if a[0] > b[0]:
			#return true
		#return false
#
#func my_map(input, minInput, maxInput, minOutput, maxOutput):
	##explained here: https://victorkarp.wordpress.com/2019/10/01/godot-engine-how-to-remap-a-range-of-numbers-to-another-range-visually-explained/
	#var output = ( (input - minInput) / (maxInput - minInput) * (maxOutput - minOutput) + minOutput )
	#return output
