| This example demonstrates a very simple dialog...

needs ui/gui

context: ~test-app
~test-app

with~ ~ui
with~ ~iup

: dlg
  dialog[
    vboxs[
      " Hello!" label[ ]w
      spacer
      hboxs[
        " Click me!" button[ action[ ." bye" cr gui-close ]a ]w
        spacer
        " Click me, too!" button[ action[ ." well done!" cr gui-default ]a ]w
      ]c
    ]c
  ]d " Simple test!" title
;


: go dlg show gui-main-loop ;
to~ ~ go

without~

exit~ | ~test-app


go bye
