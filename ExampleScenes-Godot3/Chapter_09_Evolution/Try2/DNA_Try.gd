extends Node

class_name DNA_Try

var genes = []
var max_force = 0.1

func _init(lifetime:int):
	for i in lifetime:
		var v2 = new_random_v2()
		genes.append(v2)
		
func crossover(partner_genes, child_genes):
	var midpoint = int(randf_range(0,genes.size()))

	for i in genes.size():
		if i > midpoint:
			print(genes[i])
			child_genes[i] = genes[i]
			print(child_genes[i])
		else:
			child_genes[i] = partner_genes[i]

func mutate(mutation_rate):
	for i in genes.size():
		var og = genes[i]
		var r1 = randf()
		if r1 < mutation_rate:
			var rand_v2 = new_random_v2()
			genes[i] = rand_v2
			
func new_random_v2():
		var angle = randf_range(0,2*PI)
		var v2 = Vector2(cos(angle), sin(angle))
		v2 *= randf_range(0,max_force)
		return v2
