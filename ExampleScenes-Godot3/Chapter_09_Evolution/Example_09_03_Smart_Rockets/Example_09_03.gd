extends Area2D

class_name Rocket_09_02


var velocity : Vector2
var acceleration : Vector2
var size = 10

var rocket_color = Color(1,0,0)
var rocket_points = PackedVector2Array()

func _ready():

	var v1 = Vector2(-size, -size)
	var v2 = Vector2(size+size, 0)
	var v3 = Vector2(-size, size)
	rocket_points = PackedVector2Array([v1,v2,v3])
	
	var c = CollisionPolygon2D.new()
	c.set_polygon(rocket_points)
	add_child(c)

func apply_force(f:Vector2):
	acceleration += f

func _process(delta):
	velocity += acceleration
	position += velocity
	acceleration *= 0
	
func _draw():

	
	var thruster_radius = size/2
	var offset = Vector2(thruster_radius/2, thruster_radius/2)
	var thruster1 = Rect2(rocket_points[0]-offset+Vector2(0,thruster_radius), Vector2(thruster_radius,thruster_radius))
	var thruster2 = Rect2(rocket_points[2]-offset-Vector2(0,thruster_radius), Vector2(thruster_radius,thruster_radius))
	draw_rect(thruster1,Color(0,0,1))
	draw_rect(thruster2,Color(0,0,1))
	draw_colored_polygon(rocket_points,rocket_color)


func _on_Rocket_09_02_mouse_exited():
	print("test")
	pass # Replace with function body.
