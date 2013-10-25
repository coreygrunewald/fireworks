#define PROCESSING_TEXTURE_SHADER

uniform mat4 transform;
uniform mat4 texMatrix;

attribute vec4 vertex;
attribute vec4 color;
attribute vec2 texCoord;

varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform float mouseX;
uniform float mouseY;

void main() {

  vec4 thisPos = vertex;

  thisPos.x = mouseX;
  thisPos.y = mouseY;

  // chage to 'thisPos' for custom
  gl_Position = transform * vertex;
  vertTexCoord = texMatrix * vec4(texCoord, 1.0, 1.0);
  vertColor = color;

}
