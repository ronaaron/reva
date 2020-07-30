| using app library:
needs app/base

::
	." Starting up..." cr
	; is ~app.pre-main

:: 
	." Goodbye, cruel world!" cr
	; is ~app.post-main

:: 
	." Hello, world!" cr
	; is ~app.main

save hello-app
