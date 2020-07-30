needs net/xmlrpc

: result parse-result .s cr ;
: try2
	" currentTime.getCurrentTime" 
	" time.xmlrpc.com/RPC2" 
	xmlrpc[ 
	]xmlrpc ;

: try
	" gtkphpnet.access_stats"
	" php-gtk.eu/xmlrpc.php"
	xmlrpc[ ]xmlrpc ;

: foldoc
	" foldoc.about"
	" scripts.incutio.com/xmlrpc/foldoc/server.php"
	xmlrpc[ ]xmlrpc ;

: geocode
	" geocode"
	" rpc.geocoder.us/service/xmlrpc"
	xmlrpc[
		" 1005 Gravenstein Hwy, Sebastopol, CA 95472" strval
	]xmlrpc ;

: s1
quote !
<?xml version="1.0"?>
<methodResponse>
   <params>
      <param>
         <value><i4>1234</i4></value>
         </param>
      </params>
   </methodResponse>
!  ;
: s2
quote !
<?xml version="1.0"?>
<methodResponse>
   <params>
      <param>
         <value><string>South Dakota</string></value>
         </param>
      </params>
   </methodResponse>
!  ;

try type bye
