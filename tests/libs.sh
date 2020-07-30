#!/bin/bash

echo "Commencing unit testing of all libraries..."

for lib in `find lib -type f`
do
	if grep IFTEST $lib > /dev/null
	then
		libname=`echo $lib|sed -e 's/lib\///'`
		echo $libname
		reva -t -n $libname
	fi
done
