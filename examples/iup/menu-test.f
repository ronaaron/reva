| Simple test for the new GUI library
|
| Author: Danny Reinhold / Reinhold Software Services
| Reva's license terms also apply to this file.

needs callbacks
needs ui/gui

~ui
~iup
context: ~test-app
~test-app

variable mydialog

: quit callback gui-close  ;

: init-dlg
  dialog[

    spacer
    hboxs[  " Quit!" button[  action: quit  ]w  ]c
  ]d  " Little menu test!" title  mydialog !

  " mainMenu" menu[
    " fileMenu" menu[
      " Hello" menu-item[ ]w
      " World!" menu-item[ ]w
      menu-separator
      " Exit!" menu-item[ action: quit  ]w
    " File" ]submenu

    " editMenu" menu[
      " Another" menu-item[ ]w
      " cool" menu-item[ ]w
      menu-separator
      " menu" menu-item[ ]w
      " Have fun with it!" menu-item[ ]w
    " Edit" ]submenu
  ]m
  mydialog @  " mainMenu" attr: MENU
;


~
: go  init-dlg show gui-main-loop ;

exit~ | ~
exit~ | ~test-app
exit~ | ~ui
go bye
