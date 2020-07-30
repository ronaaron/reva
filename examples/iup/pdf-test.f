| vim: ft=reva
|
| Simple PDF drawing using CD

needs ui/cd

with~ ~cd

variable cd_canvas
variable cd_context

variable size-x
variable size-y
variable size-x-mm
variable size-y-mm

variable origin-x
variable origin-y

: init-cd-canvas
  cd-context-pdf
  dup cd_context !


  z" testing123.pdf -p4" cd-create-canvas dup cd_canvas !

  dup extraCanvasGetWidth 10 * size-x !
  dup extraCanvasGetHeigth 10 * size-y !

  size-x ? size-y ? cr
  dup z" SUBJECT" z" Test PDF file" cdCanvasSetAttribute
  dup z" CREATOR" z" Reva"	cdCanvasSetAttribute
  z" Times, Bold 12" cd-native-font
  CD_SOUTH_WEST cd-context-text-alignment
  | position 1cm down and right from the top

  254 size-y @ 254 + " Hello, world!" cd-canvas-text

  z" Linux Libertine O" cd-canvas-vector-font
  100 cd-canvas-vector-char-size
  254 254 " Bigger and better than ever" cd-vector-text
  drop
;


: release-cd-canvas
  cd_canvas @  cd-kill-canvas
;


: go  
	init-cd-canvas 
	release-cd-canvas  ;

go bye
