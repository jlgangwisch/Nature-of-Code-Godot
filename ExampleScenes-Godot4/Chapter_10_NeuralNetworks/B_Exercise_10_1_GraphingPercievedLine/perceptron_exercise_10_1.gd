extends Node
class_name Perceptron_Exercise_10_1

var weights : Array = []
var learning_constant: float 
var lines:= []


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
#https://thomascountz.com/2018/04/13/calculate-decision-boundary-of-perceptron
func find_line_y(_x: float, _w1x: float, _w2y: float, _bias:float)->void:
	#var x_intercept := Vector2(0, -_bias / _w2y)
	#var y_intercept := Vector2(-_bias/_w1x, 0)
	#var slope :float = -(_bias/_w2y) / (_bias / _w1x)
	var y :float = (-(_bias/_w2y) / (_bias / _w1x))*_x + (-_bias / _w2y)
	
func train(inputs: Array, desired:int)->void:
	lines = []
	var guess : int = feed_forward(inputs)
	var error = desired - guess
	for i in weights.size():
		weights[i]+= error * inputs[i] * learning_constant
	
		
func _draw()->void:
	pass
