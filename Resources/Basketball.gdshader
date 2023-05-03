shader_type canvas_item;

uniform vec4 flash_color: hint_color = vec4(1.0);
uniform float flash_modifier: hint_range(0.0, 1.0) = 1;

void fragment() {
    vec4 color = texture(TEXTURE, UV);
    color.rgb = mix(color.rgb, flash_color.rgb, flash_modifier);
    COLOR = color;
}

//uniform float white_progress : hint_range(0,1) = 0;
//
//vec3 interpolate_vec3(vec3 start, vec3 end, float delta){
//    return start + (end - start) * delta;
//}
//
//void fragment(){
//    vec4 origin = texture(TEXTURE, UV);
//    COLOR.rgb = interpolate_vec3(origin.rgb, vec3(1,1,1), white_progress);
//    COLOR.a = origin.a;
//}