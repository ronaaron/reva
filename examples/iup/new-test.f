| A simple dialog...

needs ui/gui

with~ ~ui
with~ ~iup


: dlg
  dialog[
    hboxs[
      vboxs[
        hboxs[ " hallo"      label[ " 50x10" size ]w  text[ ]w  ]c
        hboxs[ " gallaballa" label[ " 50x10" size ]w  text[ ]w  ]c
      ]c
      vboxs[
        hboxs[ " hallo"      label[ " 50x10" size ]w  text[ ]w  ]c
        hboxs[ " gallaballa" label[ " 50x10" size ]w  text[ ]w  ]c
      ]c
    ]c
  ]d " A simple dialog" title
;


: go dlg show gui-main-loop ;

without~ ~ui

go bye
