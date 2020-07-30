macro
: HI ." hi!" cr ;
forth

needs alg/structs        | for windows api structures
needs util/locals
needs callbacks

| Author Gtinker   10-Feb-2006
| John Conway's Game of Life
| see http://en.wikipedia.org/wiki/Conway%27s_Game_of_Life

| Reva6.0 version for windows
| modified for 6.0.1 by Ron
| modified for 7.0.6 by gtinker 22-Feb-08

| Handles for Windows functions

u32 drop  | switch to USER lib
1 func:  RegisterClassA as RegisterClass
12 func:  CreateWindowExA as CreateWindow
2 func:  LoadIconA as LoadIcon
2 func:  LoadCursorA as LoadCursor
1 func:  PostQuitMessage
4 func:  DefWindowProcA as DefWindowProc
4 func:  GetMessageA as GetMessage
5 func:  PeekMessageA as PeekMessage
1 func:  TranslateMessage
1 func:  DispatchMessageA as DispatchMessage
2 func:  BeginPaint
2 func:  EndPaint
1 func:  GetDC
2 func:  ReleaseDC

k32 drop | switch to KERNEL lib
1 func:  GetModuleHandleA as GetModuleHandle

g32 drop | switch to GDI lib
5 func:  TextOutA as TextOut
1 func:  CreateSolidBrush
4 func:  SetPixel

: setpix SetPixel ;  

1000 value nextid |
: getnextid nextid dup 1+ to nextid ;  ( -- n )   | get a unique id for a button etc.

| Windows constants
32512 dup   constant IDI_APPLICATION
            constant IDC_ARROW
15          constant COLOR_BTNFACE
$010000000  constant WS_VISIBLE
$000080000  constant WS_SYSMENU
$0002       constant WM_DESTROY
$000040000  constant WS_THICKFRAME
$000F       constant WM_PAINT
$40000000   constant WS_CHILD
$01         constant BS_DEFPUSHBUTTON
$0111       constant WM_COMMAND
$01         constant PM_REMOVE
$00         constant PM_NOREMOVE
$20         constant CS_OWNDC

| button IDs
0 value start-id
0 value clear-id
0 value hline-id
0 value vline-id
0 value square-id
0 value cross-id
0 value pentomino-id
0 value blocks-id
0 value sstep-id

560 constant height  | 560 gets us about centered in the client area
560 constant width

variable hdc
variable hinst
variable hwnd
variable play
variable cellbuf    | pointer to buffer of 'life' cells
variable narray     | pointer to array of neighbour counts
variable pcell
variable nn
variable colour

| Constant strings:
: windowclass z" reva_winapp" ;
: buttonclass z" BUTTON" ;

| Structure declarations
struct: PAINTSTRUCT
    long: ps_hdc
    long: ps_ferase
    long: ps_rcpaint.left
    long: ps_rcpaint.top
    long: ps_rcpaint.right
    long: ps_rcpaint.bottom
    long: ps_frestore
    long: ps_fincupdate
    32 field: ps_rgbreserved
struct;

struct: MSG
    long: ->hwnd
    long: ->msg
    long: ->wp
    long: ->lp
    long: ->time
    long: ->x
    long: ->y
struct;

struct: WNDCLASS
    long: ->style
    long: ->wndproc
    long: ->cbClassExtra
    long: ->cbWndExtra
    long: ->hInstance
    long: ->hIcon
    long: ->hCursor
    long: ->hbrBackground
    long: ->lpszMenuName
    long: ->lpszClassName
struct;

| Structure variables
PAINTSTRUCT ps
MSG msg
WNDCLASS wc



| count the neighbours of each cell
: nloop
  height 1- 1 do  | avoid boundaries
     width  i * cellbuf @ + pcell !     | address of this cell
     width i * narray @ + nn !  | n is current pointer into neighbour array

     width 1-  1 do | for one row of pixels
        | look at each cell and if set,
        | bump each of its 8 neighbour counters
        i  pcell @ + c@  | get cell
        if  | bump the neighbour counters
            nn @ i +
            width - dup ++
            1- dup ++
            2 + dup ++
            width + dup ++
            2 - dup ++
            width + dup ++
            1+ dup ++
            1+ ++
        then
      loop
  loop
  ;

: pixloop  | set or clear a pixel depending on neighbour count
    height 1-  1  do     | for each row of cells
 |      $0201 colour @ + $0ffffff and colour ! \ new colour
       i width * cellbuf @ + pcell !   | address of this row of cells
       i width * narray @ + nn !       | address of this row of neighbour counts
       width 1-  1  do               | for each cell in a row
            pcell ++             | bump cell address
            nn dup ++ @ c@ dup 3              | get neighbour count, is it 3
            =if drop pcell @ c@      | is cell off?
                 0if
                    1 pcell @  c!    | turn it on
                    hdc @ i j $008fff8f SetPixel drop    | draw pixel
                then
            else 2                   | not three neighbours, is it also not two?
                <>if  pcell @  c@     | if cell is on
                     if 0 pcell @  c! | turn it off
                        hdc @ i j $0 SetPixel  drop  | clear pixel
                     then
                then
            then
        loop
    loop
    ;
| reva register usage
| EAX Top of stack
| ESI Data stack
| [ESI] Second item on stack,  4 [ESI] third item on stack, 8 [ESI] etc
| ESP Return stack  (also push and pop stack pointer in assembler)
| other registers are used but do not need to be preserved
| so we have EBX, ECX, EDX, EBP, EDI to play with. As well as EAX if we don't need TOS


: pass   | run a pass of life
    narray @ height width * zero   | clear the neighbour counts
    nloop | scan the cells and count the neighbors
    pixloop | now update the playfield according to new counts
    ;

| Draw initial patterns in reponse to button presses
: pix   ( x y ) | draw a pixel
    hdc @ rot rot $00ffffff SetPixel drop ;

: clear-field  | clear all cells
    height 0 do
        width 0 do hdc @ i j 0 SetPixel drop loop   | clear all pixels
    loop
    cellbuf @ height width * zero ;         | clear the cell buffer

: hline            | draw a horizontal line
    width 3 4 */     | to 75% of width
    width 4 /        | from 25% of width
    do
        i height 2 / pix  | draw pixels
        1 width height 2 / *  i + cellbuf @ + c!  | set the corresponding cells
    loop ;

: vline
    height 3 4 */     | to 75% of height
    height 4 /        | from 25% of height
    do
        width 2 / i pix
        1  i  width * width 2 / + cellbuf @ + c!  | set the corresponding cells
    loop ;  | draw pixels

: square
    width 3 4 */  width 4 /
    do i height 4 / pix    1 width height  4 / * i + cellbuf @ + c!    loop      | draw top
    width 3 4 */  width 4 /
    do i height 3 4 */ pix  1 width height  3 4 */ * i + cellbuf @ + c!  loop   | draw bottom
    height 3 4 */  height 4 /
    do width 4 / i pix   1  i width * width 4 /  + cellbuf @ + c!   loop      | draw left side
    height 3 4 */ 1+ height 4 /
    do width 3 4 */ i pix  1  i width * width 3 4 */ + cellbuf @ + c! loop ;  | draw right side

: cross
    height 3 4 */ 1+
    height 4 /
    do i i pix
       1  i width *  i + cellbuf @ + c!
       i height i - pix
       1  height i - width * i + cellbuf @ + c!
    loop ;

: pentomino
    width 2 /  height 2 / 1-  pix  1 height 2 / 1-  width *      width 2 / + cellbuf @ + c!
    width 2 / 1-   height 2 / pix  1 height 2 / width *          width 2 / 1- + cellbuf @ + c!
    width 2 / height 2 / pix  1 height 2 /  width *              width 2 / + cellbuf @ + c!
    width 2 / height 2 / 1+ pix  1 height 2 / 1+  width *        width 2 / + cellbuf @ + c!
    width 2 / 1+  height 2 / 1+  pix  1 height 2 / 1 +  width *  width 2 / 1+  + cellbuf @ + c! ;


: setcell ( x y -- )    | set pixel and cell at x, y
    over over pix   | draw the pixel
    width * + cellbuf @ + 1 swap c!
    ;

: blocks
    width 2 / height 2 /      | get centre
    over 1 + over 2 - setcell
    over 2 + over 2 - setcell
    over 3 + over 2 - setcell
    over 1 + over 1 - setcell
    over 2 + over 1 - setcell
    over 3 + over 1 - setcell
    over 1 + over 0 - setcell
    over 2 + over 0 - setcell
    over 3 + over 0 - setcell

    over 2 - over 1 + setcell
    over 1 - over 1 + setcell
    over 0 - over 1 + setcell
    over 2 - over 2 + setcell
    over 1 - over 2 + setcell
    over 0 - over 2 + setcell
    over 2 - over 3 + setcell
    over 1 - over 3 + setcell
    over 0 - over 3 + setcell
    2drop
    ;


| do the button functions

' hline variable, startingpattern
: setpat ( xt -- )
     dup startingpattern !  execute ;

| decode a button click
: decodebuttons local[ hwnd msg wparam lparam -- ]
    wparam $ffff and      | get button id from wparam
    case
        start-id of  play @ -1 xor play ! endof
        clear-id of  clear-field  endof
        hline-id of  ['] hline setpat endof
        vline-id of  ['] vline setpat endof
        square-id of ['] square setpat endof
        cross-id of ['] cross setpat endof
        pentomino-id of  ['] pentomino setpat endof
        blocks-id of ['] blocks setpat endof
        sstep-id of 1 play ! endof
    endcase
    ;
HI


| the Window procedure
| ::          | we only need the XT for the callback, we don't need a name
: winproc callback-std 
    0 cb-param  1 cb-param  2 cb-param  3 cb-param  ( -- hwnd uMsg wParam lParam ) | get the params
    third                                  | get uMsg
    WM_PAINT =if                            | process WM_PAINT message
        fourth ps                           | hwnd ps
        BeginPaint dup hdc !                | leaves HDC on stack
        650 10 " GAME OF LIFE" TextOut drop   | write our message
        fourth ps EndPaint ;;                 | tell Windows we are done
    then
    third WM_DESTROY =if 0 PostQuitMessage ;;  then
    third WM_COMMAND =if  decodebuttons ;;  then
    DefWindowProc                   | pass to default handler
	4 cb-ret 
    ; 


| message loop:
: msgloop
    repeat
        msg 0 0 0 PM_NOREMOVE PeekMessage 0if 1 ;; then  | return with 1 (no messages)
        msg 0 0 0 GetMessage 0if 0 ;; then    | return with 0 (quit)
        msg TranslateMessage drop
        msg DispatchMessage drop
    again ;

: create-button local[ a x y w h -- id ]
    0 buttonclass
    a
    WS_VISIBLE WS_CHILD or BS_DEFPUSHBUTTON or
    x y w h
    hwnd @
    getnextid dup >r
    hinst @ 0 CreateWindow drop r>
    ;

| The Main program

: go
    | set up the window class
    0 GetModuleHandle dup hinst ! wc ->hInstance !
    0 IDI_APPLICATION LoadIcon wc ->hIcon !
    0 IDC_ARROW LoadCursor wc ->hCursor !
    ['] winproc wc ->wndproc !
    $00 CreateSolidBrush wc ->hbrBackground !    | black background
    | COLOR_BTNFACE 1 + wc ->hbrBackground !
    windowclass wc ->lpszClassName !
    CS_OWNDC wc ->style !   | this gets a window with a private Device Context
    wc RegisterClass drop

    | create main window
    0 windowclass z" winlife"   | class and title strings
    WS_VISIBLE WS_SYSMENU or WS_THICKFRAME or
    0 0 800 600
    0 0 hinst @ 0
    CreateWindow hwnd !

    | create buttons
    z" START" 670 40 60 25 create-button to start-id
    z" CLEAR" 670 70 60 25 create-button to clear-id
    z" HLINE" 670 100 60 25 create-button to hline-id
    z" VLINE" 670 130 60 25 create-button to vline-id
    z" SQUARE" 670 160 60 25 create-button to square-id
    z" CROSS" 670 190 60 25 create-button to cross-id
    z" PENT" 670 220 60 25 create-button to pentomino-id
    z" BLOCKS" 670 250 60 25 create-button to blocks-id
    z" SSTEP" 670 280 60 25 create-button to sstep-id

    height width * allocate cellbuf !   | allocate the cell buffer memory
    cellbuf @ height width * zero          | clear it
    height width * allocate narray !   | allocate the neighbour count memory
    narray @ height width * zero          | clear it

    | we have specified a private Device Context, so we only need to get it once
    hwnd @ GetDC hdc !

    startingpattern @ execute   | starting pattern
    -1 play !  | set it playing

    | the main loop
    repeat
        play @
        if
            play @ 1
            =if pass 0 play !   | single step
            else
                pass
            then
        else 1 ms   | free up cpu if not running passes
        then
        msgloop     | process windows messages, returns 0 on quit message
    while

    cellbuf @ free   | free cell buffer
    narray @ free
    bye
    ;

| code to make executable: change '1' to '0' below:
1 [IF]
 go
[ELSE]
 ' go is ~sys.appstart
 save winlife.exe
[THEN]

