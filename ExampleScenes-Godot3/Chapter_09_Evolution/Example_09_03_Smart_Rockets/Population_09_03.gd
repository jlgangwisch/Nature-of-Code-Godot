extends Node

class_name Population_09_03

var start_pos = Vector2(200,200)
var population_num = 100
var next_gen = []
var target 
var generation = 0
var finished = false
var mutation_rate = 0.1
var lifetime = 400
var curr_frame = 0
var obstacles = []



func _ready():
	randomize()
	initialize_population()
	target = get_parent().get_node("Target").position
	
	var o = get_parent().get_node("Obstacle_09_03")
	obstacles.append(o)

	
func _process(delta):
	
	if lifetime > curr_frame:
		for i in get_children():
			i.run(curr_frame, target)
		curr_frame += 1
	
	elif curr_frame >= lifetime:
		var m = selection()
		next_gen.clear()
		for i in get_children():
			var c = reproduce(m)
			next_gen.append(c)
		var rockets_arrived = 0
		var average_fitness = 0
		for i in get_children():
			average_fitness+=i.fitness
			if i.hit_target:
				rockets_arrived +=1
			
			remove_child(i)
			i.queue_free()
		
		for i in next_gen:
			add_child(i)
		
		average_fitness /= get_child_count()
		generation += 1
		curr_frame = 0
		
		print (Vector3(generation, rockets_arrived, average_fitness))
	
		
func initialize_population():
	for i in range(population_num):
		var r = Rocket_09_03.new(start_pos, lifetime)
		#population.append(r)
		add_child(r)
		#print(population[i].fitness)
		
func selection():
	var mating_pool = []
	#this was missing from the book.  I found this in the github code.
	var max_fitness = get_max_fitness()
	
	for i in get_children():
		i.evaluate_fitness(target)
		var fitness_normal = my_map(i.fitness, 0.0, max_fitness, 0.0, 1.0)
		
		var n = int(fitness_normal*1000)
		
		if n>0 && i.stopped:
			#print("yo, wtf.  this stopped guy got past.  added this many times:", n)
			pass
		if n>0 && i.hit_target:
			#print("fitness: ", i.fitness, " max fitness: ", max_fitness, "added this many times:", n)
			pass
		if n==0 && i.hit_target:
			#print("fitness normalized: ", fitness_normal, ". distance to target: ", i.check_target(target), ". fitness rating: ", i.fitness, ", finish time", i.finish_time, i.hit_target)
			print("max_fitness: ", max_fitness, "record distance: ", i.record, ", finished time: ", i.finish_time, " fitness rating: ", i.fitness)
		for j in n:
			mating_pool.append(i)
	print(mating_pool.size())
	
	return mating_pool
	

func get_max_fitness():
	var record = 0
	for i in get_children():
		i.evaluate_fitness(target)
		if record < i.fitness:
			record = i.fitness
	return record

func reproduce(mating_pool):
	var a = int(randf_range(0, mating_pool.size()))
	var b = int(randf_range(0, mating_pool.size()))
	
	var parent_a = mating_pool[a]
	var parent_b = mating_pool[b]
	
	#print(parent_a, ", ", parent_b)
	
	#Exercise 09_04
	var mating_tries = 10000
	while mating_tries > 0 && parent_a == parent_b:
		#mating_pool.remove(b)
		b = int(randf_range(0, mating_pool.size()))
		parent_b = mating_pool[b]
		mating_tries -=1
	if mating_tries == 0:
		print("couldn't find a partner")

	var child = Rocket_09_03.new(start_pos, lifetime)
	
	parent_a.dna.crossover(parent_b.dna.genes, child.dna.genes)
	child.dna.mutate(mutation_rate)
	#child.evaluate_fitness()
	#var three = Vector3(parent_a.fitness, parent_b.fitness, child.fitness)
	#print(three)
	return child

static func sort_descending(a, b):
		if a[0] > b[0]:
			return true
		return false

func my_map(input, minInput, maxInput, minOutput, maxOutput):
	#explained here: https://victorkarp.wordpress.com/2019/10/01/godot-engine-how-to-remap-a-range-of-numbers-to-another-range-visually-explained/
	var output = ( (input - minInput) / (maxInput - minInput) * (maxOutput - minOutput) + minOutput )
	return output
