extends Node

class_name DNA_Example_09_03

var genes : PackedVector2Array = []
var max_force : float = 0.1

func _init(_gene_length: int) -> void:
	for i in _gene_length:
		var angle : float = randf()*2*PI
		var vector := Vector2.RIGHT.rotated(angle)
		vector *= randf_range(0.0, max_force)
		genes.append(vector)
		
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
			var angle : float = randf()*2*PI
			var vector := Vector2.RIGHT.rotated(angle)
			vector *= randf_range(0.0, max_force)
			genes[i] = vector
