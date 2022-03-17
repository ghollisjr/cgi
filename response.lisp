(in-package :cgi)

;;; HTTP response headers
(defun http-response-header ()
  "Sends the HTTP response content header to *standard-output*."
  (format t "Content-type: text/html~%~%"))

(defun http-response-redirect (url)
  "Sends HTTP redirect response header to supplied URL"
  (format t "Location: ~a~%~%" url))

