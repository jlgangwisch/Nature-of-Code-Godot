extends Node2D

var perceptron : Perceptron_Exercise_10_1
var training : Array
var count = 0
var viewport_size :Vector2

func _ready() -> void:
	perceptron = Perceptron_Exercise_10_1.new(3, 0.0001)
	viewport_size = get_viewport_rect().size
	for i in 2000:
		var x : float = randf_range(-viewport_size.x/2, viewport_size.x/2)
		var y : float = randf_range(-viewport_size.y/2, viewport_size.y/2)
		training.append([x,y,1])

func y_of_line(_x: float)->float:
	return 0.5 * _x - 1.0
	#return _x
func _process(delta: float) -> void:
	queue_redraw()
func _draw() -> void:
	#the camera has the zoom y flipped so that negative numbers go down like a cartesian graph
	draw_line(Vector2(-viewport_size.x/2, y_of_line(-viewport_size.x/2)), Vector2(viewport_size.x/2,y_of_line(viewport_size.x/2)),Color(0,0,0,1), 2)
	var x : float = training[count][0]
	var y : float = training[count][1]
	var desired: int = 1
	if y > y_of_line(x):
		desired = -1
	
	perceptron.train(training[count], desired)
	count = (count + 1) % training.size()
	
	for data_point in training:
		var guess : float = perceptron.feed_forward(data_point)
		var color := Color(1,1,1,1)
		if guess > 0:
			color = Color(0,0,0,1)
		draw_circle(Vector2(data_point[0],data_point[1]),8, color)
