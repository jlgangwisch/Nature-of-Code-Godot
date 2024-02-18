extends Node2D

@onready var screen_size = get_viewport().get_visible_rect().size
@onready var background = get_node("ColorRect")
@onready var brushes = get_node("brushes")

var brush_count = 2000


var wash_color = Color(0.5,0,0,1)

var frame = 0

func _ready():
	background.size = screen_size
	background.color = wash_color
	get_viewport().set_clear_mode(SubViewport.CLEAR_MODE_NEVER)
	#VisualServer.set_default_clear_color(wash_color)

	for b in range(brush_count):
		var brush = StrikeWare_Brush.new()
		brush.color.r = wash_color.r
		brush.color.g = wash_color.g
		brush.color.b = wash_color.b
		#brush.position = screen_size/2
		brush.position = Vector2(randf_range(0,screen_size.x), randf_range(0,screen_size.y))
		brush.radius = randf_range(1,5)
		brushes.add_child(brush)
		
func _process(delta):
	if frame == 5:
		background.queue_free()
	for brush in brushes.get_children():
		var rX = randf_range(-1,1)
		var rY = randf_range(-1,1)
		#var rR = rand_range(-0.001,0.001)
		var rR = 0
		var rG = randf_range(-0.001,0.001)
		var rB = randf_range(-0.001,0.001)
		var rA = randf_range(-0.001,0.001)
		var rRadius = randf_range(-0.1, 0.1)
		brush.radius += rRadius
		brush.position += Vector2(rX,rY)
		#brush.position = Vector2(rand_range(0,screen_size.x), rand_range(0,screen_size.y))
		brush.color += Color(rR,rG,rB,rA)
	frame += 1
