extends Node2D

class_name DNA_09_03

var genes = []


var max_force = 0.3
func _init(lifetime:int):
	randomize()
	generate_DNA(lifetime)


func generate_DNA(genes_length):

	for i in genes_length:
		var rand_v2 = new_random_v2()
		genes.append(rand_v2)
	
	
func new_random_v2():
		var angle = randf_range(0,2*PI)
		var rand_v2 = Vector2(1,0).rotated(angle)
		rand_v2 *= randf_range(0, max_force)
		return rand_v2
		
func crossover(partner_genes, child_genes):
	var midpoint = int(randf_range(0,genes.size()))

	for i in genes.size():
		if i > midpoint:
			child_genes[i] = genes[i]
		else:
			child_genes[i] = partner_genes[i]
	

func mutate(mutation_rate):
	for i in genes.size():
		var og = genes[i]
		var r1 = randf()
		if r1 < mutation_rate:
			var rand_v2 = new_random_v2()
			genes[i] = rand_v2
			#print("was ", og, ", is now ", new_character, " at position: ", i)

func get_phrase():
	var phrase = ""
	for i in genes.size():
		phrase += genes[i]
	return phrase
	
func my_map(input, minInput, maxInput, minOutput, maxOutput):
	#explained here: https://victorkarp.wordpress.com/2019/10/01/godot-engine-how-to-remap-a-range-of-numbers-to-another-range-visually-explained/
	var output = ( (input - minInput) / (maxInput - minInput) * (maxOutput - minOutput) + minOutput )
	return output

