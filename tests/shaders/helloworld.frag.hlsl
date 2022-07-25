sampler2D implicitInputSampler : register(S0);
float4 main(float2 uv : TEXCOORD) : COLOR {
    float4 color = tex2D( implicitInputSampler, uv );
    float4 invertedColor = float4(color.a - color.rgb, color.a);
    return invertedColor;
}