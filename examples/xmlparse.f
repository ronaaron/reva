needs string/xmlparse

: xml-string 
quote !
<?xml version="1.0" encoding="UTF-8"?>
<methodResponse>
<params>
<param>
<value>
<array>
<data>
<value>
<struct>
<member>
<name>number</name>
<value>
<int>1005</int></value></member>
<member>
<name>lat</name>
<value>
<double>38.390202</double></value></member>
<member>
<name>street</name>
<value>
<string>Gravenstein</string></value></member>
<member>
<name>state</name>
<value>
<string>CA</string></value></member>
<member>
<name>zip</name>
<value>
<i4>95472</i4></value></member>
<member>
<name>city</name>
<value>
<string>Sebastopol</string></value></member>
<member>
<name>suffix</name>
<value>
<string/></value></member>
<member>
<name>long</name>
<value>
<double>-122.816010</double></value></member>
<member>
<name>type</name>
<value>
<string>Hwy</string></value></member>
<member>
<name>prefix</name>
<value>
<string/>
</value></member></struct></value></data></array></value></param></params></methodResponse>
!  ;

: cb-start  cr ." Start: "  swap zcount type ; 
: cb-end  cr ." End: "  zcount type ; 
: cb-char  cr ." Char: " type ;

with~ ~xml
0 value parser
: test
	xml-new-parser to parser
	['] cb-start ['] cb-end ['] cb-char parser xml-sethandlers
	parser xml-string  xml-parse
	parser xml-free-parser
	;

test
bye
