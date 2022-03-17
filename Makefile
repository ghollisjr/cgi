cgi.core:html.lisp macros.lisp package.lisp query.lisp response.lisp utilities.lisp
	make-sbcl-core '(:cgi)' cgi.core
install:cgi.core
	mkdir -p ${HOME}/lib/sbcl-cores
	cp -v cgi.core ${HOME}/lib/sbcl-cores/
clean:
	rm -f cgi.core
