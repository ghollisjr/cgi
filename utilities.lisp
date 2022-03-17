(in-package :cgi)

(setf (symbol-function
       'split)
      #'split-sequence:split-sequence)

(defun safe-string (string)
  "Cheap way to prevent read-time execution exploits"
  (remove #\# string))
