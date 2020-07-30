time (dd if=/dev/zero bs=1M count=800|openssl sha1 )
time (dd if=/dev/zero bs=1M count=800|./sha1 -)
