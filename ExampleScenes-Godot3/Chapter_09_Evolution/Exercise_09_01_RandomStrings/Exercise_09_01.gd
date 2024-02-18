extends Node2D

var counter = 0
var printed_cat = false

func _process(delta):
	if !printed_cat:
		generate_random_string()
	
		
func generate_random_string():
	#google says the longest word in the english language is: pneumonoultramicroscopicsilicovolcanoconiosis
	#var word_length = rand_range(0,"pneumonoultramicroscopicsilicovolcanoconiosis".length())
	var word_length = 3
	var word = ""
	for i in word_length:
		#range is the decimal unicode for english lower case letters
		var c = randf_range(97,123)
		word += char(c)
	print (word)
	counter +=1
	if word == "cat":
		print("the monkeys did it!  It took them ", counter, " tries.")
		printed_cat = true
