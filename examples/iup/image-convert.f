| This is a sample application for using the new GUI library.
| It allows you to read an image and save it as Reva Forth source code
| usable within your own applications.
|
| Author: Danny Reinhold / Reinhold Software Services
| Reva's license terms also apply to this file

needs callbacks
needs ui/gui
needs ui/gui-iup-img

~ui ~iup

context: ~test-app
~test-app

variable image-holder


: quit callback  gui-close  ;  

: open-action callback  file-open-dialog[ ]fd  popup  getval type cr  gui-default  ; 

: save-action callback  file-save-dialog[ ]fd  popup  getval type cr  gui-default  ;  


: main-dialog
  dialog[
    toolbar[
      " Open Image" button[  img-open image  action: open-action  " Open an image file" tip  ]w
      " Save Forth" button[  img-save image  action: save-action  " Save a Reva source file" tip  ]w
    ]t
    spacer
    " " label[  dup image-holder !  " 200x200" size  expand  ]w
    hboxs[
      " Quit!" button[  " Close the application" tip  action: quit  ]w
    ]c
  ]d  " Reva image converter" title
;


~
: go  main-dialog  show  gui-main-loop  ;
exit~ | ~

exit~ | ~test-app
exit~ | ~ui

go bye
