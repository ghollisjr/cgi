(in-package :cgi)

;;; HTTP response headers
(defun doctype (&rest args)
  "Return doctype for HTML.  At the moment this only supports HTML5."
  (declare (ignore args))
  (format nil "<!DOCTYPE html>"))

(defun http-response-header (&rest doctype-args)
  "Sends the HTTP response content header to *standard-output*."
  (format t "Content-type: text/html~%~%~a~%"
          (apply #'doctype doctype-args)))

(defun http-response-redirect (url)
  "Sends HTTP redirect response header to supplied URL"
  (format t "Location: ~a~%~%" url))

