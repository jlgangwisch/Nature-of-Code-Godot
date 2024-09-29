extends Area2D
class_name Bloop_Example_09_05

var noise := FastNoiseLite.new()
var max_speed : float = 5
var radius : float = 15
var xoff := randf_range(-1000,1000)
var yoff := randf_range(-1000,1000)
var color := Color(1,1,1,1)
var dna : DNA_Example_09_05
var health : float = 100


func _ready() -> void:
	#phenotype
	radius = dna.genes[0]*25
	max_speed = (1.0-dna.genes[0])* 15
	
	var c = CollisionShape2D.new()
	c.shape = CircleShape2D.new()
	c.shape.radius = radius
	add_child(c)
	area_entered.connect(_on_area_entered)
	add_to_group("Bloops")

func _process(delta: float) -> void:
	var vx := noise.get_noise_1d(xoff)*max_speed
	var vy := noise.get_noise_1d(yoff)*max_speed
	
	var velocity := Vector2(vx,vy)
	position += velocity
	
	xoff += 0.1
	yoff += 0.1
	
	if xoff > 1000:
		xoff = -1000
	if yoff > 1000:
		yoff = -1000
		
	var viewport_size = get_viewport_rect().size
	if position.x > viewport_size.x:
		position.x = 0
	elif position.x < 0:
		position.x = viewport_size.x
	if position.y < 0:
		position.y = viewport_size.y
	elif position.y > viewport_size.y:
		position.y = 0
	
	health -= 0.2
	modulate.a = health/100
	
	if health <= 0.0:
		queue_free()
	
	clone_self()
		
func _on_area_entered(_area: Area2D)->void:
	if _area.is_in_group("Food"):
		health += 100
		_area.queue_free()
	pass
	
func clone_self()->void:
	if randf()< 0.001:
		var child_dna := DNA_Example_09_05.new(1)
		child_dna.genes = dna.genes.duplicate()
		child_dna.mutate(0.01)
		var bloop := Bloop_Example_09_05.new()
		bloop.position = position
		bloop.dna = child_dna
		get_parent().add_child(bloop)
		#print("this gene:  ", dna.genes[0], "   that gene: ", bloop.dna.genes[0])
		
func _draw() -> void:
	draw_circle(Vector2.ZERO, radius,color)
