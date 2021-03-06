| Shading 1.0 beta
| Reva 6.0.4 or greater OpenGL example program
| Andrew Price, 2006
| Dedicated to the public domain
| f>32 and f>64 by Jurica Lovakovic

needs callbacks
needs math/floats
~floats
needs ui/gl
needs ui/glu
needs ui/glut
~gl

0 variable, noargs
: blankargs "  " ;
: windowtitle " GL Shading Test" ;
blankargs drop variable, blankargs*

noargs blankargs* glutInit drop
GLUT_RGB GLUT_SINGLE or  glutInitDisplayMode drop
250 250 glutInitWindowSize drop
100 100 glutInitWindowPosition drop
variable mywindow
windowtitle drop glutCreateWindow mywindow !

GL_SMOOTH glShadeModel drop
f1 f>32 f1 f>32 f1 f>32 f1 f>32 glClearColor 
GL_PROJECTION glMatrixMode drop
glLoadIdentity drop

f0 f>64 f1 f>64 f0 f>64 f1 f>64 f1 fnegate f>64 f1 f>64 glOrtho 

: HandleKey  ." Key " rot dup dup $ff and 27 =if bye ;then emit 32 emit . . . cr ;
: HandleMouse  ." Mouse " . . . . cr ;
: DrawScene
	f0 f>32 f0 f>32 f0 f>32 f1 f>32 glClearColor 
	GL_COLOR_BUFFER_BIT glClear 
	f1 f>32 f1 f>32 f1 f>32 glColor3f 
	GL_POLYGON glBegin 
	   0.25 f>32 0.20 f>32 f0 f>32 glVertex3f 
	   f0 f>32 f1 f>32 f1 f>32 glColor3f 
	   0.75 f>32 0.35 f>32 f0 f>32 glVertex3f 
	   f1 f>32 f1 f>32 f0 f>32 glColor3f 
	   0.75 f>32 0.75 f>32 f0 f>32 glVertex3f 
	   f1 f>32 f0 f>32 f1 f>32 glColor3f 
	   0.25 f>32 0.75 f>32 f0 f>32 glVertex3f 
	glEnd 
	glFlush
	;

: SceneDrawer callback		DrawScene ;  | SceneDrawer is a callback that calls DrawScene
: KeyHandler callback  HandleKey ; 
: MouseHandler callback HandleMouse DrawScene ; 
: setup-callbacks 	['] SceneDrawer glutDisplayFunc drop
			['] KeyHandler glutKeyboardFunc drop
			['] MouseHandler glutMouseFunc drop ;

: go
	." press ESC to quit" cr
	setup-callbacks
	glutReportErrors drop
	glutMainLoop drop
	;

go
