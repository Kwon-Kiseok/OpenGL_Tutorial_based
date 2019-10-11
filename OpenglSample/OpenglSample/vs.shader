#version 330 core

// Input vertex data, different for all executions of this shader.
layout(location = 0) in vec3 vertexPosition_modelspace; //��������
layout(location = 1) in vec3 vertexColor; //������ ����

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
	//ex. �������� �߰��ϰ� ������ vertexColor + vec3(1.0f, 0.0f, 0.0f); ��� �ϸ� vec3�� RGB ������ ���������� ������
	//�����鿡 ������ ���� ������ ���� �� ���� �߰������� ������ , �ܸ���� ����� �ʹٸ� ���۵��� ������ ��ġ�����ָ� ��
}