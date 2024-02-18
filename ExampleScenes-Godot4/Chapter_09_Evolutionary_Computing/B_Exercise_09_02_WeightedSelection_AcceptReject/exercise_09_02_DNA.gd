extends Node
class_name exercise_09_02_DNA

var gene_length : int
var genes : PackedInt32Array = []
var genes_as_string : String = ""
var gene_min : int = 32
var gene_max : int = 127

var fitness : float 

func _init(_gene_length:int) -> void:
	randomize()
	gene_length = _gene_length
	fitness = 0
	#fill gene with data
	for g in gene_length:
		var i :int = randi_range(gene_min,gene_max)
		genes_as_string += String.chr(i)
		genes.append(i)
	

		
