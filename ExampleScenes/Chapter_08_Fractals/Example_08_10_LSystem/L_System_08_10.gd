extends Node2D
class_name L_System_08_10

var sentence := ""
var ruleset := []
var generation := 0

func _init(axiom:String, r):
	sentence = axiom
	ruleset = r
	generation = 0

func generate():
	var next = ""
	for i in range(sentence.length()):
		#I couldn't find a way to return a character at an index in godot.  ord_at returns unicode decimal at index, which allows for this workaround.
		var c = sentence.ord_at(i)
		#replace with self unless it matches one of our rules.
		#char(c) returns a string from the unicode decimal
		var replace = "" + char(c)
		
		for j in range(ruleset.size()):
			var a = ruleset[j].get_a()
			if c == a.ord_at(0):
				replace = ruleset[j].get_b()
				break
		next += replace
	sentence = next
	generation += 1

func get_sentence():
	return sentence
	
func get_generation():
	return generation
	

			
