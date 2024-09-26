extends Node2D

class_name Population_Example_09_02

var mutation_rate : float = 0.05
@export var population_size : int = 50
var generations : int = 0
@export var target_node : Node2D
@export var frames_alive : int = 250
var frame : int = 0

var best_fitness : float

@export var fitness_label : Label
@export var generations_label :Label
func _ready() -> void:
	
	for r in population_size:
		var rocket := create_rocket()
		add_child(rocket)
	
func _process(delta: float) -> void:
	if frame <= frames_alive:
		frame += 1
	else:
		selection()
		var next_generation = reproduction()
		
		for i in get_children():
			i.queue_free()
		
		for i in next_generation:
			add_child(i)
			
		frame = 0
		generations += 1
		generations_label.text = "generations: " + str(generations)
	
	

func create_rocket()->Rocket_Example_09_02:
	var rocket := Rocket_Example_09_02.new()
	rocket.target = target_node.global_position
	rocket.frames_alive = frames_alive
	rocket.dna = DNA_Example_09_02.new(frames_alive)
	return rocket

func crossover_midpoint(_a:Rocket_Example_09_02, _b:Rocket_Example_09_02)->Rocket_Example_09_02:
	var child := create_rocket()
	var midpoint = randi_range(0, child.dna.genes.size())
	for i in child.dna.genes.size():
		if i< midpoint:
			child.dna.genes[i] = _a.dna.genes[i]
		else:
			child.dna.genes[i] = _b.dna.genes[i]
	return child
func crossover_coinflip(_a:Rocket_Example_09_02, _b:Rocket_Example_09_02)->Rocket_Example_09_02:
	var child := create_rocket()
	for i in _a.dna.genes.size():
		if randi() % 2  == 0:
			child.dna.genes[i] = _a.dna.genes[i]
		else:
			child.dna.genes[i] = _b.dna.genes[i]
	#print("crossover child: ", child)
	return child

func mutate(_rocket: Rocket_Example_09_02, _rate: float)->void:
	#print("mutate: ", _rocket.dna.genes)
	for i in _rocket.dna.genes.size():
		if randf()<_rate:
			_rocket.dna.genes[i] = Vector2(randf_range(-1,1), randf_range(-1,1)).normalized()
	
func reproduction()->Array:
	var new_population : Array = []
	var i : int = 0
	for r in population_size:
		var parent_a : Rocket_Example_09_02 = weighted_selection()
		var parent_b : Rocket_Example_09_02 = weighted_selection()
		#print("parenta: ", parent_a,"  parent b: ", parent_b)
		var child : Rocket_Example_09_02 = crossover_coinflip(parent_a, parent_b)
		mutate(child, mutation_rate)
		#if parent_a.fitness + parent_b.fitness < 0.01:
			#mutate(child, mutation_rate*10)
		#else:
			#mutate(child, mutation_rate)
		new_population.append(child)
		i += 1
		#print("reproductionx : ", i)
	return new_population
		
		
func weighted_selection()->Rocket_Example_09_02:
	var idx : int = 0
	var start : = randf()
	while start >0.0:
		start = start - get_child(idx).fitness
	
		
	#print("weighted selection idx: ", idx, "    child_count: ", get_child_count())
	idx -= 1
	return get_child(idx-1)
		
func selection()->void:
	var total_fitness : float = 0.0
	var gen_best_fitness : float = 0.0
	for r in get_children():
		r.calculate_fitness()
		total_fitness += r.fitness
	
	for r in get_children():
		r.fitness /= total_fitness
		if r.fitness > best_fitness:
			gen_best_fitness = r.fitness
	
	fitness_label.text = "best fitness: " + str(gen_best_fitness)
	#print("best fitness: ", best_fitness)
	

	
