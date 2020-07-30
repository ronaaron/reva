needs testing

| How to make a test-case for Reva:
|
| The word ''bad'' is supposed to return '1' but doesn't.  Here is 
| how we make the test case:
|
| First the bad word:
: bad 0 ;

| Now the test case:
| All test cases must return a flag.  "true" means the test was ok, 'false' 
| means it failed.  The line after "test:" is what will be printed if the test 
| failed so one can determine which test failed.  Any text can be there
|
|
| The test below will fail:

test: bad doesn't return '1'
	bad 1 = ;
	

| while this one will pass:
test: just another test
	true ;

| This starts the tests...
test bye

| Now run it using "reva -t test.f"
