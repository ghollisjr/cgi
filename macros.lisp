(in-package :cgi)

;; Reader macro to make automatically including quotes in a string
;; easier, e.g.:
;;
;; #"hello" => "\"hello\"".  This is useful for e.g.
;;
;; (make-html (parse-html '(p (:class #"special") "Some interesting text")))
;; ==>
;; <p class="special">Some interesting text</p>
(defun html-string-reader-macro (stream subchar arg)
  "Provides reader macro syntax for implicitly quote-surrounding a
string.  Useful for generating strings that need quotes when expanded
into HTML code.  E.g.:

Normal string printing: \"hello\" => hello
Quote-surround string printing: #\"hello\" => \"hello\""
  (declare (ignore subchar arg))
  (labels ((parse-string (stream)
             ;; read until unescaped " detected
             (let* ((escape nil)
                    (result nil))
               (do ((c (read-char stream)
                       (read-char stream)))
                   ((and (not escape)
                         (char= c #\"))
                    (coerce (cons #\"
                                  (nreverse
                                   (cons #\" result)))
                            'string))
                 (cond
                   ((and (not escape)
                         (char= c #\\))
                    (setf escape t))
                   (t
                    (when escape
                      (setf escape nil))
                    (push c result)))))))
    (parse-string stream)))

(set-dispatch-macro-character
 #\# #\"
 #'html-string-reader-macro)
