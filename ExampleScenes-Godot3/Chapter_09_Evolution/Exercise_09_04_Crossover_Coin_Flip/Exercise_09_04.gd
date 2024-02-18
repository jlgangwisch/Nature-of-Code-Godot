func crossover_coin(partner, child):

	for i in genes.size():
		var r1 = randf()
		print(r1)
		if r1 > 0.5:
			child.genes[i] = genes[i]
		else:
			child.genes[i] = partner.genes[i]
