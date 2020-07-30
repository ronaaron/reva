: testkeys
	repeat
		key? dup .
		if ekey 27 - 0; drop then
		100 ms
	again ;

." bug 315 : key? holds its value also after releasing the key" cr
." This example will print a '0' if no key is pending; otherwise it will" cr
." print a '-1'.  Press ESC to quit" cr

testkeys cr bye
