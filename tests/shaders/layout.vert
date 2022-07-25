#version 450

layout(set=0, binding=0) uniform SceneMatrices {
    mat4 projection;
    mat4 view;
};
layout(set=0, binding=1) uniform ModelMatrices {
    mat4 model;
};
layout(set=1, binding=0) uniform texture2D LightMap;
layout(set=2, binding=0) uniform sampler LightMapSampler;
layout(set=3, binding=0) uniform sampler2D BoneMap;

void main(){}