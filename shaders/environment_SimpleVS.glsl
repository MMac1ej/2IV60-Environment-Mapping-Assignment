#version 330

layout (location=0) in vec4 P;
layout (location=1) in vec3 N;            // normal vector in object space
layout (location=2) in vec2 texCoord;

uniform mat4 matGeo;
uniform mat4 matVP;
uniform mat4 matV;

varying vec3 R;    // reflective vector in object space
varying vec4 outColor;
varying vec2 outTexCoord;



void main()
{
 	// TODO: compute reflection vector in Model space	| total of 4 points
 	
 	// TODO: compute a 3d point Q, by transforming P
 	// from homogeneous to cartesian coordinates				
	vec3 Q;
	
	// TODO: compute the eye position E4 in homogeneous coordinates  
	// using the provided mat4 variables
	vec4 E4;	
	
 	// TODO: compute 3d point E, by transforming E4
 	// from homogeneous to cartesian coordinates	
	vec3 E;
	
	// TODO: compute vector from vertex towards camera, using E and Q 
	vec3 I;	
	
	// TODO: compute reflection vector R, using I and E
	R = vec3(0,0,0); 			

	gl_Position = (matVP*matGeo) * P;
	outColor  = vec4(1,1,1,1);
	outTexCoord = texCoord;
}
