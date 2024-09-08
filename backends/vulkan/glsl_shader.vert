#version 450 core
layout(location = 0) in vec2 aPos;
layout(location = 1) in vec2 aUV;
layout(location = 2) in vec4 aColor;

layout(push_constant) uniform uPushConstant {
    vec2 uScale;
    vec2 uTranslate;
} pc;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(location = 0) out struct {
    vec4 Color;
    vec2 UV;
} Out;

//From comment by uzoochogu, made here:
//https://tuket.github.io/posts/2022-11-24-imgui-gamma/
vec4 toLinear(vec4 sRGB)
{
    bvec3 cutoff = lessThan(sRGB.rgb, vec3(0.04045));
    vec3 higher = pow((sRGB.rgb + vec3(0.055))/vec3(1.055), vec3(2.4));
    vec3 lower = sRGB.rgb/vec3(12.92);
    return vec4(mix(higher, lower, cutoff), sRGB.a);
}

void main()
{
    Out.Color = toLinear(aColor);
    Out.UV = aUV;
    gl_Position = vec4(aPos * pc.uScale + pc.uTranslate, 0, 1);
}