shader_type canvas_item;

uniform vec4 color: source_color;

void fragment() {
	vec4 col = texture(TEXTURE,UV);
	COLOR = vec4(color.rgb,color.a*col.a);
}