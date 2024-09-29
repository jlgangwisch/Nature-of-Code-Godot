extends Node
class_name DNA_Example_09_05

var genes : PackedFloat64Array = []
var max_force : float = 0.1

func _init(_gene_length: int) -> void:
	for i in _gene_length:
		genes.append(randf())
		
func crossover(partner: DNA_Example_09_03)->DNA_Example_09_03:
	var child = DNA_Example_09_03.new(genes.size())
	var midpoint = randi_range(0, genes.size())
	for i in genes.size():
		if i< midpoint:
			child.genes[i] = genes[i]
		else:
			child.genes[i] = partner.genes[i]
	return child
	
func mutate(mutation_rate: float)->void:
	for i in genes.size():
		if randf() < mutation_rate:
			genes[i] = randf()
