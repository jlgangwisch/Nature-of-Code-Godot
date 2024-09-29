extends Node2D

var population_start_size : int = 20
var food_size : int = 20
var food_positions : PackedVector2Array = []

func _ready() -> void:
	randomize()
	var v = get_viewport_rect().size
	
	for i in population_start_size:
		var bloop := Bloop_Example_09_05.new()
		bloop.position = Vector2(randf_range(0, v.x), randf_range(0,v.y))
		bloop.dna = DNA_Example_09_05.new(1)
		$Bloops.add_child(bloop)
	
	for i in food_size:
		var food := Food_Example_09_05.new()
		#food.position = Vector2(randi(),randi())
		
		food.position = Vector2(randf_range(0, v.x), randf_range(0,v.y))
		food_positions.append(food.position)
		$Food.add_child(food)


func _on_food_timer_timeout() -> void:
	food_positions[randi_range(0,food_positions.size()-1)]
	var food := Food_Example_09_05.new()
	food.position = food_positions[randi_range(0,food_positions.size()-1)]
	$Food.add_child(food)
	
