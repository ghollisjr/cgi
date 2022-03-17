(asdf:defsystem #:cgi
  :serial t
  :author "Gary Hollis"
  :license "GPLv3"
  :description "CGI web app library"
  :depends-on (#:cl-getopt
               #:sbcl-script
               #:split-sequence
               #:usocket
               #:uiop
               #:cl-fad
               #:cl-ppcre
               #:trivial-clipboard
               #:do-urlencode)
  :components ((:file "package")
               (:file "macros")
               (:file "utilities")
               (:file "response")
               (:file "query")
               (:file "html")))
