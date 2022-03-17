#!/usr/bin/env -S sbcl --core ../cgi.core --script
(unless (member :script *features*)
  (ql:quickload "cgi"))

(in-package :cgi)

(defun hello-www ()
  (http-response-header)
  (format t "~a~%"
          (make-html
           `(html
             ()
             (body () ; all elements must have attribute list, even if NIL
                   (p (:id #"hello") ; The reader macro #"..." helps for attributes
                      "Hello, World Wide Web!"))))))

(when (member :script *features*)
  (hello-www))
