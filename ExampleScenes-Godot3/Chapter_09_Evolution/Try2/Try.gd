extends Node2D

var lifetime = 3

func _ready():
	var dna1 = DNA_Try.new(lifetime)
	var dna2 = DNA_Try.new(lifetime)
	var dna3 = DNA_Try.new(lifetime)
	dna1.crossover(dna2.genes, dna3.genes)
	print (dna1.genes)
	print (dna2.genes)
	print (dna3.genes)
