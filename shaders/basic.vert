#version 410 core

layout(location=0) in vec3 vPosition;
layout(location=1) in vec3 vNormal;
layout(location=2) in vec2 vTexCoords;

out vec3 fPosition;
out vec3 fNormal;
out vec2 fTexCoords;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;
uniform mat3 normalMatrix;


uniform vec3 lightDir;
uniform vec3 lightColor;
uniform vec3 baseColor;

out vec3 color;

vec3 ambient;
float ambientStrength = 0.2f;
vec3 diffuse;
vec3 specular;
float specularStrength = 0.5f;
float shininess = 32.0f;



void main() 
{

	//compute ambient light
	
	ambient = ambientStrength * lightColor;
	
	
	vec3 lightDirN = normalize(lightDir);
	vec3 normalEye = normalize(normalMatrix * vNormal);
	diffuse = max(dot(normalEye, lightDirN), 0.0f) * lightColor;
	vec4 vertPosEye = view * model * vec4(vPosition, 1.0f);
	vec3 viewDir = normalize(- vertPosEye.xyz);
	vec3 reflectDir = normalize(reflect(-lightDir, normalEye));
	float specCoeff = pow(max(dot(viewDir, reflectDir), 0.0f), shininess);
	color = min((ambient + diffuse) * baseColor + specular, 1.0f);




	gl_Position = projection * view * model * vec4(vPosition, 1.0f);
	fPosition = vPosition;
	fNormal = vNormal;
	fTexCoords = vTexCoords;
	
	
}
