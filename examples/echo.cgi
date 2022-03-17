#!/usr/bin/env -S sbcl --core ../cgi.core --script
;;;; CGI app to echo query requests
(when (not (member :script *features*))
  (ql:quickload "cgi"))

(in-package :cgi)

(defparameter *query-method* #"GET"
  "Change to POST to test POST queries")

(defun echo ()
  "CGI app to echo queries"
  (http-response-header)
  (let* ((query (get-queries))
         (get-values
          (when query
            (loop
               for k being the hash-keys in query
               for v being the hash-values in query
               collecting `(p () ,(format nil "~s=~s"
                                          k v))))))
    (format t "~a~%"
            (make-html
             `(html
               ()
               (body ()
                     (form (:action #"echo.cgi"
                                    :method ,*query-method*)
                           (label (:for #"field1")
                                  "Enter field1:")
                           (input (:type #"text" :name #"field1" :id #"field1"))
                           (br ())
                           (label (:for #"field2")
                                  "Enter field2:")
                           (input (:type #"text" :name #"field2" :id #"field2"))
                           (br ())
                           (input (:type #"submit" :id #"submit" :value #"Submit")))
                     ,@get-values))))))

(when (member :script *features*)
  (echo))
