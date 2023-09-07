shader_type canvas_item;

void fragment() {
	vec4 col = texture(TEXTURE,UV);
	COLOR = vec4(col.g,col.g*1.4,col.b*0.7,col.a);
}