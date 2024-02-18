extends Control

#Create a sketch that generates random strings. 
#You’ll need to know how to do this in order to implement the GA example that will shortly follow. 
#How long does it take for p5.js to randomly generate the string cat? 
#How might you adapt this to generate a random design using godot's shape-drawing functions?

#https://unicodelookup.com/
#english letters 65-122
#lower case 97-122

var finished := false
var cycles : int = 0
@export var timer_label : Label
@export var cycles_label : Label
@export var string_label : Label
@export var guesses_label : Label

func _ready()->void:
	randomize()

func _process(delta: float) -> void:
	if not finished:
		var s : String = ""
		var rgb : PackedFloat32Array
		for i in 3:
			var n :int =randi_range(97,122)
			var c : String = String.chr(n)
			rgb.append(float(n)/255.0)
			s += c
		string_label.text = s
		timer_label.text = "seconds elapsed: " + str(Time.get_ticks_msec()/1000)
		cycles_label.text = "cycles elapsed: " + str(cycles)
		guesses_label.text = s+" " + guesses_label.text
		if s == "cat":
			finished = true
		var screen_size := Vector2(DisplayServer.screen_get_size())
		var l := Line2D.new()
		l.width = 1
		l.add_point(Vector2(0,0))
		l.add_point(Vector2(screen_size.x,0))
		l.position.y = cycles % int(screen_size.y)
		
		l.default_color = Color(rgb[0],rgb[1],rgb[2],1)
		$Lines.add_child(l)
		cycles +=1
		
	if Input.is_action_just_pressed("left_mouse"):
		finished = !finished
