#version 330

//uniform sampler2D cubemap[1];
uniform sampler2D cubemap0;
uniform sampler2D cubemap1;

varying vec3 R; // vector from eye to object reflected in the normal direction
varying vec2 outTexCoord;

// Given methods to create homogeneous matrices
mat3 Translate(vec2 t) { return mat3(vec3(1,0,0),vec3(0,1,0),vec3(t.x,t.y,1)); }
mat3 Scale(vec2 s) { return mat3(vec3(s.x,0,0),vec3(0,s.y,0),vec3(0,0,1)); }
mat3 Mat(vec2 v0, vec2 v1, vec2 t) { return mat3(vec3(v0,0),vec3(v1,0),vec3(t,1)); }

void main( void )
{	vec2 uv;        // coodinates in [-1,1] on side of cube
    vec2 st0, st1;  // images after transformation of uv axis (1,0) and uv=(0,1), respectively.
    			    // refer to figure in assignment text
	vec2 offset;    // offset to center of square in cube map in [0,8]x[0,6]
		
	// TODO: Depending on the value of R.x, R.y, R.z
	// compute st0, st1 and offset.
	// Assign boolean expressions for all case and subcase
	// variables, such that you cover all combinations (correspoonding to cube faces) for 
	// R.x, R.y, R.z
	// NOTE: this can be done by 2 cases and 3 subcases (see below)
	// but additional cases may be added (full points may not be given in this case)

	
	// 3d vector h represents the cartesian coordnates 
	// of the intersection with a unit cube face 	
	// TODO: compute h in each case and then compute uv using h
	// HINT: look at preparatory exercise in the assignment text	        | total of 4 points
	
	bool case1,case2;
	bool subcase1, subcase2, subcase3;

	// The half-line from the origin in direction R leaves the unit cube
	// through the face of the component with the largest absolute value.
	case1 = (abs(R.x) >= abs(R.y)) && (abs(R.x) >= abs(R.z));  // face x = +-1
	case2 = (abs(R.y) >= abs(R.z));  // face y = +-1 (x is not largest here); else face z = +-1

	// The sign of that component selects the + or - face
	subcase1 = (R.x >= 0);
	subcase2 = (R.y >= 0);
	subcase3 = (R.z >= 0);

	// In every case: h = R scaled such that its largest component is +-1
	// (intersection with the cube face); uv are the other two components of h.
	// st0/st1 are the directions of u/v in the cube map, read off from the
	// axes in the test cube map. Offset is the centre of the face's 2x2 square
	// in the 8x6 grid: (2*column+1, 2*row+1), counted from the bottom-left.
	if (case1) {
			vec3 h = R/abs(R.x);
			uv = vec2(h.y, h.z);
			if (subcase1){ st0=vec2(0,1); st1=vec2(1,0); offset=vec2(5,3);} 
			else 		{ st0=vec2(0,1); st1=vec2( -1,0); offset=vec2(1,3);}
	} else if (case2) {
			vec3 h = R/abs(R.y);
			uv = vec2(h.x, h.z);
			if (subcase2){ st0=vec2(1,0); st1=vec2( 0,1); offset=vec2(3,5);}
			else		{ st0=vec2(1,0); st1=vec2( 0,-1); offset=vec2(3,1); }
	} else {
			vec3 h = R/abs(R.z);
			uv = vec2(h.x, h.y);
			if (subcase3){ st0=vec2(-1,0); st1=vec2( 0,1); offset=vec2(7,3); }
			else		{ st0=vec2(1,0); st1=vec2( 0,1); offset=vec2(3,3); } 
	}

    // TODO: Create a 3x3 matrix m0, using Mat() function
    // and st0, st1, offset which now represent column vectors in m0.; see below
    // The matrix maps locations on a face of the cube from [-1,1]x[-1,1]
    // to the appropriate cube map patch assuming coordinates range in [0,8]x[0,6] | total 3 points

   // uv in [-1,1]^2 has side 2, as do the squares, so st0/st1 need no scaling
   mat3 m0 = Mat(st0, st1, offset);								
	
    // TODO: Create a 3x3 scaling matrix m1, using Scale() function,
    // such that coordinates are scaled to [1,0]x[0,1]; see below          | total 1 point

    // [0,8]x[0,6] becomes [0,1]x[0,1]
    mat3 m1 = Scale(vec2(1.0/8.0,1.0/6.0));

    // Finally, compute etxture coordinates
    vec3 st = m1*m0*vec3(uv,1);

    gl_FragColor = texture(cubemap1, st.xy/st.z);
}
