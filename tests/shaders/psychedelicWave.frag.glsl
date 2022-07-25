#version 450
#ifdef GL_ES
precision mediump float;
#endif
// mods by dist

layout(location= 0) in float time;
layout(location= 1) in vec2 mouse;
layout(location= 2) in vec2 resolution;
layout(location= 0) out vec4 outColor;

void main( void ) {
  vec2 uPos = ( gl_FragCoord.xy / resolution.xy );//normalize wrt y axis
  uPos -= vec2((resolution.x/resolution.y)/2.0, 0.0);//shift origin to center

  uPos.x -= 0.5;
  uPos.y -= 0.5;

  vec3 color = vec3(0.0);
  float vertColor = 0.0;
  for( float i = 0.0; i < 20.0; ++i ) {
    float t = time * (3.9);

    uPos.y += sin( uPos.x*(i+1.0) + t+i/2.0 ) * 0.1;
    float fTemp = abs(0.3 / uPos.y / 100.0);
    vertColor += fTemp;
    color += vec3( fTemp*(10.0-i)/10.0, fTemp*i/10.0, pow(fTemp,0.909)*2.5 );
  }

  vec4 color_final = vec4(color, 10.0);
  outColor = color_final;
}