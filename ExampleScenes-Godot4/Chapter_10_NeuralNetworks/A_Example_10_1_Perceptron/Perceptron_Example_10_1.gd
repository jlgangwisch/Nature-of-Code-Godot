extends Node2D
class_name Perceptron_Example_10_1

var weights : Array = []
var learning_constant: float 
func _init(_total_inputs: int, _learning_rate:float) -> void:
	learning_constant = _learning_rate
	for i in _total_inputs:
		weights.append(randf_range(-1.0,1.0))

func feed_forward(inputs: Array)->int:
	var sum :float = 0.0
	for i in weights.size():
		sum += inputs[i] * weights[i]
	return activate(sum)
	
func activate(_sum:float)->int:
	if _sum > 0:
		return 1
	else:
		return -1
		
func train(inputs: Array, desired:int)->void:
	var guess : int = feed_forward(inputs)
	var error = desired - guess
	for i in weights.size():
		weights[i]+= error * inputs[i] * learning_constant
