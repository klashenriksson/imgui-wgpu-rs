[[block]]
struct View {
    u_Matrix: mat4x4<f32>,
}

[[group(0), binding(0)]]
var transform: View;

struct VertexOutput {
    [[location(0)]] v_UV: vec2<f32>,
    [[location(1)]] v_Color: vec4<f32>,
    [[builtin(position)]] position: vec4<f32>,
}

fn vs_main(
    [[location(0)]] a_pos: vec2<f32>,
    [[location(1)]] a_UV: vec2<f32>,
    [[location(2)]] a_Color: vec4<f32>
) -> VertexOutput {
    var out: VertexOutput;
    out.v_UV = a_UV;
    out.v_Color = a_Color;
    out.position = transform.u_Matrix * a_pos;

    return out;
}

[[group(1), binding(0)]]
var u_Sampler: sampler;
[[group(1), binding(1)]]
var u_Texture: texture_2d<f32>;

fn fs_main(in: VertexOutput) -> [[location(0)]] vec4<f32> {
    return in.v_Color * textureSample(u_Texture, u_Sampler, in.v_UV);
}