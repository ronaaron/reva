| tool to create a patch file:

needs util/patchmgr

with~ ~patchmgr


: createpatch ( -- )
	argc 3 <if ." no patch to create" cr ;then	
	2 argv
	." Reading source in " 2dup type cr
	slurp create-patch-file
	." Created patch file " type cr
	;

createpatch bye
