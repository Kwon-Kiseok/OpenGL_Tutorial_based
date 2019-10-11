#version 330 core

// Input vertex data, different for all executions of this shader.
layout(location = 0) in vec3 vertexPosition_modelspace; //정점정보
layout(location = 1) in vec3 vertexColor; //정점색 정보

layout(location = 2) in vec3 vertexPosition_modelspace2;
layout(location = 3) in vec3 vertexColor2;
										  // Output data ; will be interpolated for each fragment.
out vec3 fragmentColor;
// Values that stay constant for the whole mesh.
uniform mat4 MVP;


void main() {

	// Output position of the vertex, in clip space : MVP * position
	gl_Position = MVP * vec4(vertexPosition_modelspace, 1);
	// The color of each vertex will be interpolated
	// to produce the color of each fragment
	fragmentColor = vertexColor;
	fragmentColor = vertexColor2 + vec3(0.0f, 0.3f, 1.0f);
	//ex. 빨간색을 추가하고 싶으면 vertexColor + vec3(1.0f, 0.0f, 0.0f); 라고 하면 vec3에 RGB 순으로 색상정보가 입혀짐
	//정점들에 지정된 색의 정보를 토대로 한 면의 중간색들이 정해짐 , 단면색을 만들고 싶다면 버퍼들의 색상을 일치시켜주면 됨
}