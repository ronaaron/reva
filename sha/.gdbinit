set disassembly-flavor intel
define dd
	disassemble $eip-10,$eip+10
	end
define cpu
	info registers
	end
define wchar_print
echo "
	set $i = 0
	while (1 == 1)
set $c = (char)(($arg0)[$i++])
	if ($c == '\0')
	loop_break
	end
	printf "%c", $c
	end
	echo "\n
	end
	document wchar_print
	wchar_print <wstr>
	Print ASCII part of <wstr>, which is a wide character string of type
	wchar_t*.
	end

	define wxc
	wchar_print $arg0
	end
	document wxc
	wcs <wxChar *>
	Print string
	end

	define wxs
	wchar_print $arg0.m_pchData
	end
	document wxs
	Printout wxString data.
	Usage: wxs _wxString_name_
	end

