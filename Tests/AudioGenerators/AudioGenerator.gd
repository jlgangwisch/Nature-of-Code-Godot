
extends Node2D

var sample_hz = 22050.0 # Keep the number of samples to mix low, GDScript is not super fast.
var note_a = 440.0 
var note_c = 261.63 
var note_e = 329.63
var pulse_hz = 440.0
var phase = 0.0
var phases = []
var temp = []
var playback: AudioStreamPlayback = null # Actual playback stream, assigned in _ready().
var note_array = [note_a, note_a]
var buffer_size = 22050*2
var wav_buffer = PackedVector2Array([])
var framecount = 0

func _fill_buffer(note):
	
	var increment = note / sample_hz
	var to_fill = playback.get_frames_available()

	while to_fill > 0:
		
		var frame = Vector2.ONE * sin(phase * TAU)
		playback.push_frame(frame) # Audio frames are stereo.
		phase = fmod(phase + increment, 1.0)
		to_fill -=1

func button_sound():

	var to_fill = playback.get_frames_available()
	var add_f = 512
	if to_fill > 0:
	#for i in range(1024):
		var amp =0.0
		var amp_inc = 1.0/add_f
		for i in add_f:
			var frame = Vector2.ZERO
			for j in range(note_array.size()):
				var increment = note_array[j] / sample_hz
				frame += Vector2.ONE * sin(phases[j] * TAU)
				phases[j] = fmod(phases[j] + increment, 1.0)
			wav_buffer[i] *= Vector2.ONE * sin(amp*TAU)
			amp = amp_inc + amp
			playback.push_frame(frame)
			

		#print(framecount)
	#print(playback.can_push_buffer(1024))

func fill_buffer_chords():
	
	var to_fill = playback.get_frames_available()

	while to_fill > 0:
	#for i in range(1024):
		var frame = Vector2.ZERO
		for j in range(note_array.size()):
			var increment = note_array[j] / sample_hz
			frame += Vector2.ONE * sin(phases[j] * TAU)
			phases[j] = fmod(phases[j] + increment, 1.0)
		playback.push_frame(frame)
		to_fill -=1
		framecount += 1
		#print(framecount)
	#print(playback.can_push_buffer(1024))
	

func add_notes(freq:float):
	note_array.append(freq)
	phases.is_empty()
	#set phases to 0?  Does this matter?
	for i in note_array:
		i = 0.0
		phases.append(i)
	if note_array.size() > 3:
		note_array.pop_front()
	#playback.clear_buffer()
	
func add_notes_buffer(freq:float):
	$Player.stop()
	#playback.clear_buffer()
	#note_array.append(freq)
	note_array[0] = freq
	phases.is_empty()
	#set phases to 0?  Does this matter?
	for i in note_array:
		i = 0.0
		phases.append(i)
	if note_array.size() > 5:
		note_array.pop_front()
	create_buffer()

	$Player.play()
	update()
	
	
	
func _process(_delta):
	if Input.is_action_just_pressed("ui_down"):
		add_notes_buffer(get_global_mouse_position().x)
	note_array[0] = get_global_mouse_position().x
	_fill_buffer(get_global_mouse_position().x)
	update()
	if Input.is_action_pressed("ui_up"):
		button_sound()
	#fill_buffer_chords()
	#print(playback.can_push_buffer(1024))

func create_buffer():
	wav_buffer.is_empty()
	wav_buffer.resize(4096)
	var amp =0.0
	var amp_inc = 1.0/wav_buffer.size()
	for i in range(wav_buffer.size()):

		wav_buffer[i] = Vector2.ZERO

		for j in range(note_array.size()):
			var increment = note_array[j] / sample_hz
			#add note
			wav_buffer[i] += Vector2.ONE * sin(phases[j] * TAU)
			phases[j] = fmod(phases[j] + increment, 1.0)
		
		#amp envelope
		wav_buffer[i] *= Vector2.ONE * sin(amp*TAU)
		amp = amp_inc + amp
		
	playback.push_buffer(wav_buffer)
	
	
		#print (amp_inc)
	#print(wav_buffer)
		
func _ready():

	for i in range(note_array.size()):
		phases.append(0.0)
	$Player.stream.mix_rate = sample_hz # Setting mix rate is only possible before play().
	playback = $Player.get_stream_playback()
	create_buffer()
	#_fill_buffer(note_a) # Prefill, do before play() to avoid delay.
	#fill_buffer_chords()
	$Player.play()

func my_map(input, minInput, maxInput, minOutput, maxOutput):
	#explained here: https://victorkarp.wordpress.com/2019/10/01/godot-engine-how-to-remap-a-range-of-numbers-to-another-range-visually-explained/
	var output = ( (input - minInput) / (maxInput - minInput) * (maxOutput - minOutput) + minOutput )
	return output

func _draw():
	var points = PackedVector2Array([])
	var amp =0.0
	for i in 1024:
		points.append(Vector2(0,0))

		var amp_inc = 1.0/1024
		for j in range(note_array.size()):
			
			var increment = note_array[j] / sample_hz
			#add note
			points[i].y += sin(phases[j] * TAU)
			phases[j] = fmod(phases[j] + increment, 1.0)
			
		#amp envelope
		points[i].y *= sin(amp*PI)
		points[i].y = my_map(points[i].y, -1,1, 200, 400)
		amp = amp_inc + amp
		points[i].x = i 

	draw_multiline(points, Color(1,1,1), 2)
	#print(points[1022])
