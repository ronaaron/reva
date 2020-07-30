| example of using crypt/gpg
| NOTE: on Linux you need 'libgpgme.so', which at least for kubuntu means to
| install "apt-get install libgpgme11-dev"
|
| Well, you should also have a valid GPG setup ...


needs crypt/gpg

with~ ~gpg

variable ctx

: init
	init-gpg ctx !
	;

: key-cb ( key -- )
	." key cb: "
	>r
	r@ key>name type cr
	r@ key>email type cr
	r@ key>id type cr
	r@ key>uid type cr
	rdrop
	cr
	;
: enumkeys  ctx @ 0 0 1 ['] key-cb iterate-keys ;

init enumkeys bye
