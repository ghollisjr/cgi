cgi.core:html.lisp macros.lisp package.lisp query.lisp response.lisp utilities.lisp
	make-sbcl-core '(:cgi)' cgi.core
clean:
	rm -f cgi.core
install:cgi.core
	mkdir -p /usr/local/lib/sbcl-cores
	cp -v cgi.core /usr/local/lib/sbcl-cores/
uninstall:
	rm -v /usr/local/lib/sbcl-cores/cgi.core
