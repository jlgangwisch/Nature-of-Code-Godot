extends Node2D

#This is unfinishided, but has enough to go on.  

#TODO:  Create a verlet branch scene so that each branch can be parented onto the one before it.
#practice with dampend spring joints.



# mouse drag param
var pressed             := false
var selectionDistance   := 20.0
var prev_mouse_position := Vector2.ZERO
var selection: PointMass_08_11

var use_mouse_point_drag = false

func _physics_process(delta):
	# mouse drag :
	if pressed && selection != null:
		if selection.is_static:
			selection.global_transform.origin =  get_local_mouse_position()
			selection.previous_position  = selection.position
		selection.global_transform.origin   = get_local_mouse_position()
		selection.velocity = -(selection.previous_position - selection.position) / delta
		selection.previous_position  = selection.position
		selection.projected_position = selection.position
	
func _process(delta):
	pass
func _input(event):
	
	if event is InputEventMouseButton:
		if event.pressed:
			pressed   = true
			selection = null
			
		
			for node in get_node("Verlet_Tree").get_node("verticles").get_children():
				if event.position.distance_to( node.global_transform.origin ) < selectionDistance:
					selection = node
					break
			
			
		else:
			pressed   = false
			selection = null
