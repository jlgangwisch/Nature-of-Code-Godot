func evaluate_fitness():
	var score = 0.0
	for i in genes.size():
		if genes[i].ord_at(0) == target_string.ord_at(i):
			score += 1.0
	score = score * score
	fitness = my_map(score, 0, target_string.length() * target_string.length(), 0, 1)
	#print(genes.size())
