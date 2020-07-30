needs data/binarytree

with~ ~binarytree

binarytree: bt

." Putting some data in the tree:"  cr

" nothing" " def" bt put
" something" " xyz" bt put
" whatever" " abc" bt put
" bet" " alef" bt put
" top" " zz" bt put

." Printing the tree:" cr
bt .binarytree

 ." Removing 'alef':" cr
 " alef" bt del
 bt .binarytree

bye
