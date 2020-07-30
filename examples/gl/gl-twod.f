| Simple 2D grid 1.0 beta
| Reva OpenGL Example program -- intended to show that 2D drawing can be simple in OpenGL
| Andrew Price, 2006
| Dedicated to the public domain
| f>32 and f>64 by Jurica Lovakovic

needs callbacks
needs math/floats
~floats
needs ui/gl  needs ui/glu  needs ui/glut
~gl
: f>32 [ $D9FC768D , $06871E 3, ;  | Put 32 bit IEEE of TOFS on integer stack
: f>64 [ $DDF8768D , $0446871E , ; | Put 64 bit IEEE of TOFS on integer stack

0 variable, noargs
: blankargs "  " ;
: windowtitle " Simple 2D Grid in OpenGL" ;
blankargs drop variable, blankargs*

noargs blankargs* glutInit drop
GLUT_RGB GLUT_DOUBLE or  glutInitDisplayMode drop
500 500 glutInitWindowSize drop
100 100 glutInitWindowPosition drop
variable mywindow
windowtitle drop glutCreateWindow mywindow !

f1 f>32 f1 f>32 f1 f>32 f1 f>32 glClearColor 
GL_PROJECTION glMatrixMode 
glLoadIdentity 

f0 f>64 500.0 f>64 f0 f>64 500.0 f>64 f1 fnegate f>64 f1 f>64 glOrtho 

: HandleKey  rot dup dup $ff and 27 =if bye ;then ." Key "  emit 32 emit . . . cr ;
: HandleMouse  ." Mouse " . . . . cr ;
: DrawScene
	f0 f>32 f0 f>32 f0 f>32 f0 f>32 glClearColor 
	GL_COLOR_BUFFER_BIT glClear 
	$FF $FF $FF glColor3b 
	GL_LINES glBegin 
	   500 0 do
		0 i glVertex2i
		500 i glVertex2i
		i 0 glVertex2i 
		i 500 glVertex2i 
		i 3 *  i 5 *   i 7 *  glColor3b 
	   loop
	glEnd 
	glFlush
	glutSwapBuffers drop
	;

: SceneDrawer callback DrawScene ;
: KeyHandler callback HandleKey ; 
: MouseHandler callback HandleMouse DrawScene ; 
: setup-callbacks ['] SceneDrawer glutDisplayFunc drop ['] KeyHandler glutKeyboardFunc drop ['] MouseHandler glutMouseFunc drop ;
setup-callbacks

." press ESC to quit" cr
glutMainLoop drop
