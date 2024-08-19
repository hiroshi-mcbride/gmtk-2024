shader_type spatial;
render_mode world_vertex_coords;
 
uniform sampler2D texture_albedo : source_color,filter_linear_mipmap,repeat_enable;
uniform vec4 albedo : source_color;
 
const float steps = 20.0;
 
float snap(float original, float num, float denum) {
    // for snapping vertexes
    // say you want steps of 0.1, then numerator = 1 and denumerator = 10
    // 1 / 10 = 0.1
    return round(original * denum / num) * num / denum;
    // i love stackoverflow
}
 
void vertex() {
    VERTEX = vec3(
        snap(VERTEX.x, 1, steps),
        snap(VERTEX.y, 1, steps),
        snap(VERTEX.z, 1, steps)
    );
}
 
void fragment() {
    vec2 base_uv = UV;
    vec4 albedo_tex = texture(texture_albedo,base_uv);
    ALBEDO = albedo.rgb * albedo_tex.rgb;
}
 
//void light() {
    // Called for every pixel for every light affecting the material.
    // Uncomment to replace the default light processing function with this one.
//}