// fs
#version 330 core

// Interpolated values from the vertex shaders
in vec2 UV;
in vec3 Position_worldspace;
in vec3 Normal_cameraspace;
in vec3 EyeDirection_cameraspace;
in vec3 LightDirection_cameraspace;
in vec3 RedLightDirection_cameraspace;

// Ouput data
out vec4 color;

// Values that stay constant for the whole mesh.
uniform sampler2D myTextureSampler;
uniform mat4 MV;
uniform vec3 LightPosition_worldspace;
uniform vec3 RedLightPosition_worldspace;

void main() {

	// Light emission properties
	// You probably want to put them as uniforms
	vec3 LightColor_White = vec3(1, 1, 1);
	vec3 LightColor_Red = vec3(1, 0, 0);
	float LightPower = 80.0f;

	// Material properties
	vec3 MaterialDiffuseColor = texture(myTextureSampler, UV).rgb;
	vec3 MaterialAmbientColor = vec3(0.1f, 0.1f, 0.1f) * MaterialDiffuseColor;
	vec3 MaterialSpecularColor = vec3(0.3, 0.3, 0.3);

	// Distance to the light
	float distance = length(LightPosition_worldspace - Position_worldspace);	// 물체와 광원 사이의 거리
	float distance_Red = length(RedLightPosition_worldspace - Position_worldspace);
	// Normal of the computed fragment, in camera space
	vec3 n = normalize(Normal_cameraspace);
	// Direction of the light (from the fragment to the light)
	vec3 l = normalize(LightDirection_cameraspace);
	// Cosine of the angle between the normal and the light direction, 
	// clamped above 0
	//  - light is at the vertical of the triangle -> 1
	//  - light is perpendicular to the triangle -> 0
	//  - light is behind the triangle -> 0
	float cosTheta = clamp(dot(n, l), 0, 1);
	// dot 내적 ( n = 카메라 공간에서의 노말, 정점에서의 법선  l = 빛 ) clamp( 내적을 0 과 1 사이의 값으로 만들어 줌)

	vec3 nr = normalize(Normal_cameraspace);
	vec3 lr = normalize(RedLightDirection_cameraspace);
	float cosTheta_R = clamp(dot(nr, lr), 0, 1);

	color.rgb += MaterialDiffuseColor * LightColor_White * LightPower * cosTheta / (distance*distance);
	color.rgb += MaterialDiffuseColor * LightColor_Red * LightPower * cosTheta_R / (distance_Red*distance_Red);
	color.rgb += MaterialAmbientColor;

	color.a = 0.8f;
}