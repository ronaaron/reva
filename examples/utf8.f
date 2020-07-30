needs string/iconv

: utf$ " שלום" ;

." This string is utf8:" cr utf$ dump cr
." Converted to unicode:" cr utf$ utf>uni dump cr
." Back to utf8:" cr utf$ utf>uni uni>utf dump cr
bye
