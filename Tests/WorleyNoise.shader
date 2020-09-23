shader_type canvas_item;

// no lighting shader
render_mode unshaded;


//uniform allows you to set value from outside shader
uniform vec3 worley_point_01 = vec3(0.4, 0.1, 0.4);

//executes  to every frame
void fragment(){
	COLOR = vec4(1.0, 0.0, 0.0, 1.0);
}