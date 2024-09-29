extends Area2D
class_name Food_Example_09_05
var radius : float = 10
var color := Color(1,0,0,1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var c = CollisionShape2D.new()
	c.shape = RectangleShape2D.new()
	c.shape.size = Vector2(radius,radius)
	
	
	
		
	add_child(c)
	#area_entered.connect(_on_area_entered)
	add_to_group("Food")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _draw() -> void:
	draw_rect(Rect2(Vector2(-radius/2, -radius/2), Vector2(radius,radius)),color)
