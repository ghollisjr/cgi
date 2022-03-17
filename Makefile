cgi.core:html.lisp macros.lisp package.lisp query.lisp response.lisp utilities.lisp
	make-sbcl-core '(:cgi)' cgi.core
clean:
	rm -f cgi.core
