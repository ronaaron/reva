(          Title:  Sudoku Solver
            File:  sudoku.fs
          Author:  Robert Spykerman
        Modifier:  David N. Williams
Version modified:  1900 01092005
         License:  ?
   Last revision:  November 18, 2005

This source adds a word PUZZLE to input complete puzzles.  It
includes input stream and string extension words to support
that, plus a definition of ((.

See the example at the end.

ANS Forth compatible except for case dependence.

Modifications by dnw:
16Nov05 * Started coding.
17Nov05 * Released.
18Nov08 * Fixed some typos in comments.
        * Inserted ?CR in SKIP-PAST to make it and (( work
          across lines in interactive mode as well.
)


| Newsgroup: comp.lang.forth
| From: robert spykerman <robspyke_nospam@no_spam_iprimus.com.au_no_spam>
| Date: Thu, 01 Sep 2005 18:53:01 +1000
| Local: Thurs, Sep 1 2005 3:53 am
| Subject: Re: Sudoku puzzle solver
| 
| A BETTER SOLVER ENGINE...
| 
| Improved solving engine - uses a bit of intelligence as well as
| recursion, thanks to all of you, who suggested a more intelligent
| approach.
| 
| The new solver finds a grid-position most likely to yield a good guess
| by looking at the number sets first, instead of just blindly thumping
| numbers in from start to end.
| 
| 458 calls to solver versus 250,000+ initially...
| Win32forth hesitated a couple of seconds on the old one.
| Now it doesn't.  Wow...
| 
| Marcel, I haven't figured out your code yet, does yours do it in a
| similar way?

| ------------- SAMPLE RUN ( full source comes after)

| PUZZLE
| 0 9 0 ! 0 0 4 ! 0 0 7
| 0 0 0 ! 0 0 7 ! 9 0 0
| 8 0 0 ! 0 0 0 ! 0 0 0
| ------+-------+------
| 4 0 5 ! 8 0 0 ! 0 0 0
| 3 0 0 ! 0 0 0 ! 0 0 2
| 0 0 0 ! 0 0 9 ! 7 0 6
| ------+-------+------
| 0 0 0 ! 0 0 0 ! 0 0 4
| 0 0 3 ! 5 0 0 ! 0 0 0
| 2 0 0 ! 6 0 0 ! 0 8 0
| 
| | OLD solver:
| solveit
| 
| Solution Found
| 
| 5 9 1 ! 2 8 4 ! 3 6 7
| 6 4 2 ! 3 5 7 ! 9 1 8
| 8 3 7 ! 9 6 1 ! 4 2 5
| ------+-------+------
| 4 7 5 ! 8 2 6 ! 1 9 3
| 3 6 9 ! 7 1 5 ! 8 4 2
| 1 2 8 ! 4 3 9 ! 7 5 6
| ------+-------+------
| 7 5 6 ! 1 9 8 ! 2 3 4
| 9 8 3 ! 5 4 2 ! 6 7 1
| 2 1 4 ! 6 7 3 ! 5 8 9
| 
| Elapsed Time: 547 msec
| Depth : 61
| Calls : 254393
|  ok
| 
| | NEW solver:
| solveit
| 
| Solution Found
| 
| 5 9 1 ! 2 8 4 ! 3 6 7
| 6 4 2 ! 3 5 7 ! 9 1 8
| 8 3 7 ! 9 6 1 ! 4 2 5
| ------+-------+------
| 4 7 5 ! 8 2 6 ! 1 9 3
| 3 6 9 ! 7 1 5 ! 8 4 2
| 1 2 8 ! 4 3 9 ! 7 5 6
| ------+-------+------
| 7 5 6 ! 1 9 8 ! 2 3 4
| 9 8 3 ! 5 4 2 ! 6 7 1
| 2 1 4 ! 6 7 3 ! 5 8 9
| 
| Elapsed Time: 15 msec
| Depth : 61
| Calls : 458
| 
| ))

| ------------- SOURCE
|  Sudoku Solver in Forth.
|  No special extensions were used.
|  Tested on in win32forth, VFX and Swift (evaluation).
|  No locals were harmed during this experiment.
|
|  Version: 1900 01092005 - Robert Spykerman
|  email: robspyke_nospam@iprimus_no_spam.com.au
|         (delete the obvious)
|
|  Input added 17Nov2005 by David N. Williams


|  ---------------------
|  Variables
|  ---------------------

create sudokugrid 81 allot  | PUZZLE fills this in

create sudoku_row 9 cells allot

create sudoku_col 9 cells allot

create sudoku_box 9 cells allot

1024 allot      | just to be sure there is no cache issue.


|  ---------------------
|  Logic
|  ---------------------
|  Basically :  
|     Grid is parsed. All numbers are put into sets, which are
|     implemented as bitmaps (sudoku_row, sudoku_col, sudoku_box)
|     which represent sets of numbers in each row, column, box.
|     only one specific instance of a number can exist in a
|     particular set.
|
|     SOLVER is recursively called
|     SOLVER looks for the next best guess using FINDNEXTSPACE
|     tries this trail down... if fails, backtracks... and tries
|     again.
|

| Grid Related

: xy 9 * + ;   |  x y -- offset ;
: getrow 9 / ;
: getcol 9 mod ;
: getbox dup getrow 3 / 3 * swap getcol 3 / + ;

| Puts and gets numbers from/to grid only
: setnumber sudokugrid + c! ;  | n position --
: getnumber sudokugrid swap + c@ ;

: cleargrid sudokugrid 81 0 do dup i + 0 swap c! loop drop ;

| --------------
| Set related: sets are sudoku_row, sudoku_col, sudoku_box

| ie x y --   ;  adds x into bitmap y
: addbits_row 1 rot << swap cells sudoku_row + dup @ rot or swap ! ;
: addbits_col 1 rot << swap cells sudoku_col + dup @ rot or swap ! ;
: addbits_box 1 rot << swap cells sudoku_box + dup @ rot or swap ! ;

| ie x y --  ; remove number x from bitmap y
: removebits_row 1 rot << swap cells sudoku_row + dup @ rot invert and swap ! ;
: removebits_col 1 rot << swap cells sudoku_col + dup @ rot invert and swap ! ;
: removebits_box 1 rot << swap cells sudoku_box + dup @ rot invert and swap ! ;

| clears all bitsmaps to 0
: clearbitmaps 9 0 do i cells
                     0 over sudoku_row + !
                     0 over sudoku_col + !
                     0 swap sudoku_box + !
           loop ;

| Adds number to grid and sets
: addnumber                   | number position --
    2dup setnumber
    2dup getrow addbits_row
    2dup getcol addbits_col
         getbox addbits_box
;

| Remove number from grid, and sets
: removenumber                | position --
    dup getnumber swap    
    2dup getrow removebits_row
    2dup getcol removebits_col
    2dup getbox removebits_box
    nip 0 swap setnumber
;

| gets bitmap at position, ie
| position -- bitmap

: getrow_bits getrow cells sudoku_row + @ ;  
: getcol_bits getcol cells sudoku_col + @ ;  
: getbox_bits getbox cells sudoku_box + @ ;  

| position -- composite bitmap  (or'ed)
: getbits
    dup getrow_bits
    over getcol_bits
    rot getbox_bits or or
;

| algorithm from c.l.f circa 1995 ? Will Baden
: countbits    ( number -- bits )
         dup  $55555555 and  swap  1 >>  $55555555 and  +
                dup  $33333333 and  swap  2 >>  $33333333 and  +
                dup  $0f0f0f0f and  swap  4 >>  $0f0f0f0f and  +
        255 mod
;

| Try tests a number in a said position of grid
| Returns true if it's possible, else false.
: try  | number position -- true/false
    over 1 swap <<
    over getbits and 0 = rot rot 2drop
;

| --------------
: parsegrid  | Parses Grid to fill sets.. Run before solver.
   sudokugrid | to ensure all numbers are parsed into sets/bitmaps
   81 0 do
     dup i + c@                            
       dup if                              
         dup i try if                    
           i addnumber                          
         else
           unloop drop drop false ;;      
         then  
       else
         drop
       then
   loop
   drop
   true
;

| Morespaces? manually checks for spaces ...
| Obviously this can be optimised to a count var, done initially
| Any additions/subtractions made to the grid could decrement
| a 'spaces' variable.

: morespaces?
    0 81 0 do sudokugrid i + c@  0 = if 1+ then loop ;

: findnextmove         |  -- n ; n = index next item, if -1 finished.

   -1  10                |  index  prev_possibilities  --
                         |  err... yeah... local variables, kind of...

   81 0 do
      i sudokugrid + c@ 0 = if
             i getbits countbits 9 swap -

             | get bitmap and see how many possibilities
             | stack diagram:
             | index prev_possibilities  new_possiblities --

             2dup > if          
                     | if new_possibilities < prev_possibilities...
                 _2nip i swap  
                     | new_index new_possibilies --

             else | else prev_possibilities < new possibilities, so:

                 drop  | new_index new_possibilies --        

             then                
      then
   loop
   drop
;

| findnextmove returns index of best next guess OR returns -1
| if no more guesses. You then have to check to see if there are
| spaces left on the board unoccupied. If this is the case, you
| need to back up the recursion and try again.

: solver
     findnextmove
         dup 0 < if
             morespaces? if
                drop false ;;
             else
                drop true ;;
             then
         then

     10 1 do
        i over try if          
           i over addnumber
           solver  if
                drop unloop true ;;
           else
                dup removenumber
           then
        then
     loop

     drop false
;

| SOLVER

: startsolving        
   clearbitmaps  | reparse bitmaps and reparse grid
   parsegrid     | just in case..
   solver
   and
;

|  ---------------------
|  Display Grid
|  ---------------------
|
| Prints grid nicely
|
: .sudokugrid
  cr cr
  sudokugrid
  81 0 do
    dup i + c@ . ." "
    i 1+
      dup 3 mod 0 = if
         dup 9 mod 0 = if
            cr
            dup 27 mod 0 = if
              dup 81 < if ." ------+-------+------" cr then
            then
         else
           ." ! "
         then      
      then
    drop
  loop
  drop
  cr
;

|  ---------------------
|  Higher Level Words
|  ---------------------

: checkifoccupied  | offset -- t/f
    sudokugrid + c@
;

: add                 | n x y --
    xy 2dup
      dup checkifoccupied if
        dup removenumber
      then
    try if
      addnumber
      .sudokugrid
    else
      cr ." Not a valid move. " cr
      2drop
    then
;

: rm
    xy removenumber
    .sudokugrid
;

: clearit
    cleargrid
    clearbitmaps
    .sudokugrid
;

: solveit
  cr cr
  startsolving
  if
    ." Solution Found " cr .sudokugrid
  else
    ." No Solution Found " cr cr
  then
;

: showit .sudokugrid ;

| Print help menu
: help
  cr
  ." Type clearit     ; to clear grid " cr
  ."      1-9 x y add ; to add 1-9 to grid at x y (0 based) " cr
  ."      x y rm      ; to remove number at x y " cr
  ."      showit      ; redisplay grid " cr
  ."      solveit     ; to solve " cr
  ."      help        ; for help " cr
  ."      puzzle      ; make a new puzzle from the next" cr
  ."                  ; 81 whitespace delimited digits" cr
  cr
;


|  ----------------------
|  Full Puzzle Input
|  ----------------------
: puzzle ( "digit_1<white>...digit_81<white>}" -- )
  sudokugrid 80 +
  81 0 do
    tuck c! 1-
  loop drop
;

|  ---------------------
|  Execution starts here
|  ---------------------

0 9 0    0 0 4   0 0 7
0 0 0    0 0 7   9 0 0
8 0 0    0 0 0   0 0 0

4 0 5    8 0 0   0 0 0
3 0 0    0 0 0   0 0 2
0 0 0    0 0 9   7 0 6

0 0 0    0 0 0   0 0 4
0 0 3    5 0 0   0 0 0
2 0 0    6 0 0   0 8 0
puzzle

: godoit
    cr
    clearbitmaps
    parsegrid if
      cr ." Grid in source valid. "
    else
      cr ." Warning: Grid in source invalid. "
    then
    .sudokugrid
    help
;

| create a new puzzle:
needs random/gm
: clearpuzzle sudokugrid 81 zero ;
: 0-9 rand abs 9 mod 1+ ;
create 0-9-list 9 allot
: 0-9-used ( n -- ) 1 swap 1- 0-9-list + c! ;
: 0-9-used? ( n -- 0|1 ) 1- 0-9-list + c@ ;
: 0-9-first ( -- n )
	0-9-list 9 zero
	0-9 dup 0-9-used
	;
: 0-9-next  ( -- n ) 
	| candidate:
	0-9
	| test it
	dup 0-9-used? 0if
		dup 0-9-used ;;
	then drop 0-9-next
	;
: newpuzzle
	randomize
	clearpuzzle
	| pick a row to fill
	0-9 9 * sudokugrid +
	| a -- put 9 random numbers in there, without reusing
	0-9-first over c!
	1+
	8 0do
		0-9-next over c! 1+
	loop drop
	startsolving if
		." puzzle found: " cr
		.sudokugrid
	else
		newpuzzle
	then
	;

godoit

| ------------- END SOURCE

