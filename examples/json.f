needs net/json

with~ ~json


JSON_NULL jval value jnull
JSON_STRING jval value jstring
JSON_BOOL jval value jbool
JSON_NUMBER jval value jnum
JSON_ARRAY jval value jarr
JSON_ARRAY jval value jarr2
JSON_OBJECT jval value jobj

" this is a test" jstring >jval
" 123e2" jnum >jval
true jbool >jval
jstring 2 jarr >jval
jbool 1 jarr >jval

jnum 0 jarr2 >jval
jnull 1 jarr2 >jval
jarr2 3 jarr >jval

jnull .jval cr
jstring .jval cr
jbool .jval cr
jnum .jval cr
jarr .jval cr
jobj .jval cr

 jstring " str" jobj >jval 
 jbool " bool" jobj >jval 
 jarr " arr" jobj >jval 
 jnum " number" jobj >jval 
 jnull " nothing" jobj >jval 

jobj .jval cr

" {\"nothing\":null}" ~json.parse
cr
" nully" ~json.parse
| bye
