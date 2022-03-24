(in-package :cgi)

(setf (symbol-function
       'split)
      #'split-sequence:split-sequence)

(defun safe-string (string)
  "Cheap way to prevent read-time execution exploits"
  (remove #\# string))

(defun quote-string (string)
  "Wraps string in double-quotes for use in e.g. HTML"
  (concatenate 'string
               "\""
               (format nil "~a" string)
               "\""))
