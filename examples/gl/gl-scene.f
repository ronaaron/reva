| Scene2 with some more utilities
| Reva OpenGL demo program
| Andrew Price, 2006

context: ~app

needs callbacks
needs util/auxstack 
needs math/floats
~floats
needs ui/gl  needs ui/glu  needs ui/glut
~gl
~app
variable tmpf32
2variable tmpf64
: f>32 tmpf32 f!4  tmpf32 @ ;
: f>64 tmpf64 f!8  tmpf64 2@ ;
: 3f f>32 f>32 f>32 rot rot swap ;     		| do 3 f>32s

: 3floats  create f>32 f>32 f>32 , , , ; 	| Initialised vector of 3 32bit floats
: 4floats  f>32 3floats , ;  		 	| Initialised vector of 4 32bit floats
: -f1 f1 fnegate ;				| -1.0 on TOFS

0 variable, noargs
: blankargs "  " ;
: windowtitle " GL Test -- Scene" ;
blankargs drop variable, blankargs*
500 variable, width
500 variable, height
f0 f0 f0 f1  4floats light_ambient drop
f1 f1 f1 f1  4floats light_diffuse drop
f1 f1 f1 f1  4floats light_specular drop
f1 f1 f1 f0  4floats light_position drop

variable mywindow
: init	noargs blankargs* glutInit drop
	GLUT_RGB GLUT_DOUBLE GLUT_DEPTH or or  glutInitDisplayMode drop
	width @ height @ glutInitWindowSize drop
	100 100 glutInitWindowPosition drop
	windowtitle drop glutCreateWindow mywindow !
	GL_LIGHT0 GL_AMBIENT light_ambient glLightfv 
	GL_LIGHT0 GL_DIFFUSE light_diffuse glLightfv
	GL_LIGHT0 GL_SPECULAR light_specular glLightfv 
	GL_LIGHT0 GL_POSITION light_position glLightfv
	GL_LIGHTING glEnable 
	GL_LIGHT0 glEnable 
	GL_DEPTH_TEST glEnable 
;

fvariable posx fvariable posy fvariable posz
-f1 0.75e0 f* posx f!  0.5e0 posy f!  f0 posz f!
variable key

: HandleKey ( key x y -- )
| 3dup rot ." Key: " dup $ff and . ." (" emit ." ) x: " swap . ." y: " .
rot $ff and key ! 2drop  key @
|	 ." Key " rot dup dup key !  emit 32 emit . . . cr
	key @
	case
		'w of posy f@ 0.05e0 f+ posy f! endof | w
		's of posy f@ 0.05e0 f- posy f! endof | s
		'd of posx f@ 0.05e0 f+ posx f! endof | d
		'a of posx f@ 0.05e0 f- posx f! endof | a
		'q of posz f@ 0.05e0 f+ posz f! endof | q
		'e of posz f@ 0.05e0 f- posz f! endof | e
		27 of bye endof
	endcase
	glutPostRedisplay drop ;	| ( key a b -- )

: HandleMouse  ." Mouse " . . . . cr ;



: DrawScene  | ." Draw" cr
	GL_COLOR_BUFFER_BIT GL_DEPTH_BUFFER_BIT or glClear 
	GL_PROJECTION glMatrixMode 
	glLoadIdentity 
	-f1 2.5e0 f* f>64 2.5e0 f>64 -f1 2.5e0 f* f>64 2.5e0 f>64 -f1 10.0e0 f* f>64 10.0e0 f>64 glOrtho 
	GL_MODELVIEW glMatrixMode 
	glLoadIdentity 
	glPushMatrix 
	 20.0e0 f1 f0	3f f0 f>32 glRotatef 
	 glPushMatrix 
	  posx f@ posy f@ posz f@ 		3f glTranslatef 
	  90.0e0 f>32 	f1 f0 f0	3f glRotatef 
	  0.275e0 f>64 0.85e0 f>64 30 30 glutSolidTorus 
	 glPopMatrix 
	 glPushMatrix 
	  -f1 0.75e0 f* f>32 -f1 0.5e0 f* f>32 0.0e0 f>32 glTranslatef 
	  270.0e0 f>32 f1 f>32 f0 f>32 f0 f>32 glRotatef 
	  1.0e0 f>64 2.0e0 f>64 15 15 glutSolidCone 
	 glPopMatrix 
	 glPushMatrix 
	  0.75e0 f>32 0.0e0 f>32 -f1 f>32 glTranslatef
|	  1.0e0 f>64 30 30 glutSolidSphere
	  1.0e0 f>64 glutSolidTeapot
	 glPopMatrix 
	glPopMatrix 
	glFlush 
	glutSwapBuffers 
;


: Reshape ( width height -- )
   height ! width ! 					| ( width height -- )
	0 0 width @ height @ glViewport ." Reshape " width @ . height @ . cr
	GL_PROJECTION glMatrixMode 
	glLoadIdentity 
	-f1 2.5e0 f* f>64 2.5e0 f>64 -f1 2.5e0 f* f>64 2.5e0 f>64 -f1 10.0e0 f* f>64 10.0e0 f>64 glOrtho 
	GL_MODELVIEW glMatrixMode 
	glLoadIdentity 

;

: SceneDrawer callback DrawScene ; 
: KeyHandler callback 0 cb-param 1 cb-param 2 cb-param HandleKey ;
: MouseHandler callback  HandleMouse ; 
: ReshapeHandler callback 0 cb-param 1 cb-param Reshape ; 
: setup-callbacks 	['] SceneDrawer glutDisplayFunc drop 	['] KeyHandler glutKeyboardFunc drop
			['] MouseHandler glutMouseFunc drop 	['] ReshapeHandler glutReshapeFunc drop ;

init setup-callbacks ." press ESC to quit" cr glutMainLoop drop
