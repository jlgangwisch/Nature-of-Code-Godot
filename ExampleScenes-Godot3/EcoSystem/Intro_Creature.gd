extends Node2D

@onready var viewport = get_viewport()
@onready var viewport_size = get_viewport().get_visible_rect().size


# Instantiate
var noise = FastNoiseLite.new()
var tx = 0
var ty = 10000
var mass = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	#configure OpenSimplex Noise
	noise_configure()

	#set Node2D position to center of screen
	position = Vector2(randf_range(0,viewport_size.x), randf_range(0,viewport_size.y))
	mass = randf_range(0.5, 5)

	var shape = CircleShape2D.new()
	shape.set_radius(mass)
	get_node("CollisionShape2D").set_shape(shape)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#There is no built in map function in this version.  See my_map() below
	position.x = my_map(noise.get_noise_1d(tx), -1, 1, -viewport_size.x, viewport_size.x*2)
	position.y = my_map(noise.get_noise_1d(ty), -1, 1, -viewport_size.x, viewport_size.y*2)
	tx += 0.01 *mass
	ty += 0.01 *mass

func noise_configure():
	noise.seed = randi()
	noise.fractal_octaves = 4
	noise.period = 20.0
	noise.persistence = 0.8
	
func my_map(input, minInput, maxInput, minOutput, maxOutput):
	#explained here: https://victorkarp.wordpress.com/2019/10/01/godot-engine-how-to-remap-a-range-of-numbers-to-another-range-visually-explained/
	var output = ( (input - minInput) / (maxInput - minInput) * (maxOutput - minOutput) + minOutput )
	return output

