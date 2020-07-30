| Implement the IupCells example in Reva
| http://www.tecgraf.puc-rio.br/iup/examples/C/cells_numbering.c
| planmac at gmail dot com ( August 2012 )

needs ui/gui
needs ui/cd

with~ ~ui
with~ ~iup
with~ ~cd

context: ~cells
~cells

| ============================
0 func: IupCells
3 vfunc: IupSetAttributeHandle
5 vfunc: cdCanvasBox as cd-canvas-box
4 vfunc: cdCanvasText as cd-canvas-text

: ]d prior ]d swap drop ;
| dialog[ pushes a creation handle and ]d pushes a finalise handle
| so this fix leaves a clean stack

| ============================
0 value dlg
0 value grd

| ============================
| callbacks
0 value line 0 value col  | re-use param slots
0 value xmin 0 value xmax
0 value ymin 0 value ymax
0 value canvas
0 value xm 0 value ym

create buff 64 allot  | re-use the char buffer
IupMessageDlg value msg  | re-use the msg dialog

| quit 
: cb-quit callback gui-close ;
: click-cb callback  | ( handle button pressed line col x y status -- return? )
  buff off  | There must be a better way to fill tha char buffer?
  " CLICK: " buff place 1 cb-param (.) buff +place
  "  (" buff +place 3 cb-param (.) buff +place
  " , " buff +place 4 cb-param (.) buff +place
  " )" buff +place

  msg
    " Hi!" attr: TITLE
    buff 1+ zcount attr: VALUE  | buff is a counted string..
  popup drop

;

: draw-cb callback  | ( handle line col xmin xmax ymin ymax canvas -- return? )
|  0 cb-param to handle
  1 cb-param to line
  2 cb-param to col
  3 cb-param to xmin
  4 cb-param to xmax
  5 cb-param to ymin
  6 cb-param to ymax
  7 cb-param to canvas

  xmax xmin + 2 / to xm
  ymax ymin + 2 / to ym

  buff off
  " (" buff place line (.) buff +place
  " , " buff +place col (.) buff +place
  " )" buff +place

  line 20 * col 100 * line 100 * cd-encode-color
  canvas swap cd-foreground

  canvas xmin xmax ymin ymax cd-canvas-box
  canvas CD_CENTER cd-text-alignment
  canvas CD_BLACK cd-foreground
  canvas xm ym buff 1+ cd-canvas-text
;

: ncols-cb callback 20 ;  | Changed these a bit..
: nlines-cb callback 20 ;
: width-cb callback 55 ;
: height-cb callback 30 ;

| ============================
| make dialog and set callbacks
: make-dlg
  dialog[ IupCells dup to grd ]d
  " 500x500" attr: RASTERSIZE
  " IupCells" attr: TITLE
  ['] click-cb z" MOUSECLICK_CB" set-callback
  ['] draw-cb z" DRAW_CB" set-callback
  ['] width-cb z" WIDTH_CB" set-callback
  ['] height-cb z" HEIGHT_CB" set-callback
  ['] nlines-cb z" NLINES_CB" set-callback
  ['] ncols-cb z" NCOLS_CB" set-callback
  ['] cb-quit z" CLOSE_CB" set-callback 
  ['] cb-quit z" DESTROY_CB" set-callback 
;
make-dlg to dlg

| To get the msg popup in front of the grd dialog
msg z" PARENTDIALOG" dlg IupSetAttributeHandle


| ============================
: go dlg show drop gui-main-loop ;
to~ ~ go


without~ | ~iup
without~ | ~ui

exit~ | ~cells
go bye
