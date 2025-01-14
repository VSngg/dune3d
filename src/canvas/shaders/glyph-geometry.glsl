#version 330
layout(points) in;
layout(triangle_strip, max_vertices = 4) out;

uniform mat3 screen;

in vec4 origin_to_geom[1];
in vec2 shift_to_geom[1];
flat in uint flags_to_geom[1];
flat in uint bits_to_geom[1];
in float scale_to_geom[1];
flat in uint pick_to_geom[1];
flat out uint pick_to_frag;
flat out vec3 color_to_frag;
smooth out vec2 texcoord_to_fragment;

##ubo

void main() {
	color_to_frag = get_color(flags_to_geom[0]);
	
	vec4 o = origin_to_geom[0];
    o /= o.w;
   
    vec4 shift = vec4(screen * vec3(shift_to_geom[0], 0), 0);
    
    
    uint bits = bits_to_geom[0];
    float glyph_x = (bits>>22)&uint(0x3ff);
	float glyph_y = (bits>>12)&uint(0x3ff);
	float glyph_w = (bits>>6)&uint(0x3f);
	float glyph_h = (bits>>0)&uint(0x3f);
    
    vec3 sz = vec3(glyph_w, -glyph_h, 0)*scale_to_geom[0];
    vec3 sz_scaled = screen * sz;
    vec4 size = vec4(sz_scaled, 0);
    
	pick_to_frag = pick_to_geom[0];
	gl_Position = o+shift;
    texcoord_to_fragment = vec2(glyph_x,glyph_y)/1024;
	EmitVertex();
	
	gl_Position = o+shift+vec4(size.x, 0,0,0);
    texcoord_to_fragment = vec2(glyph_x+glyph_w,glyph_y)/1024;
	EmitVertex();
	
	gl_Position = o+shift+vec4(0, size.y,0,0);
    texcoord_to_fragment = vec2(glyph_x,glyph_y+glyph_h)/1024;
	EmitVertex();
    
	gl_Position = o+shift+vec4(size.x, size.y,0,0);
    texcoord_to_fragment = vec2(glyph_x+glyph_w,glyph_y+glyph_h)/1024;
	EmitVertex();
	
	EndPrimitive();
	
}
