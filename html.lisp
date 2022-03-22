(in-package :cgi)

;;;; HTML generation

(defstruct html-element
  tag
  attributes
  content)

(defgeneric close-p (tag)
  (:documentation "Returns T if the tag has a closing tag or NIL if it doesn't.")
  (:method (x)
    t))
(defmacro voidtag (tag)
  "Defines a void HTML element (element without closing tag)"
  `(defmethod close-p ((x (eql ',tag)))
     nil))

;; some tags that don't need closing
(progn
  (voidtag img)
  (voidtag br)
  (voidtag hr)
  (voidtag area)
  (voidtag base)
  (voidtag col)
  (voidtag command)
  (voidtag embed)
  (voidtag input)
  (voidtag keygen)
  (voidtag link)
  (voidtag meta)
  (voidtag param)
  (voidtag source)
  (voidtag track)
  (voidtag wbr))

(defun parse-html-sexpr (element)
  (typecase element
    (null "")
    (string element)
    (list
     (destructuring-bind (tag attributes &rest content)
         element
       (make-html-element :tag tag
                          :attributes attributes
                          :content
                          (mapcar #'parse-html-sexpr content))))
    (t (format nil "~a" element))))

(defun downstring (x)
  (string-downcase (format nil "~a" x)))

(defun make-html (element)
  "Generate HTML string from HTML s-expression or html-element"
  (typecase element
    (list (make-html (parse-html-sexpr element)))
    (t
     (with-output-to-string (s)
       (labels ((printer (element)
                  (typecase element
                    (string
                     (format s "~a" element))
                    (html-element
                     (with-slots (tag attributes content) element
                       element
                       (format s "<~a" (downstring tag))
                       (do* ((attrs attributes (cdr attrs))
                             (term (car attrs) (car attrs)))
                            ((null attrs))
                         (if (keywordp term)
                             (let* ((next (progn (pop attrs) (car attrs))))
                               (format s " ~a=~a" (downstring term) next))
                             (format s " ~a" (downstring term))))
                       (format s ">")
                       (when (close-p tag)
                         (dolist (c content) (printer c))
                         (format s "</~a>" (downstring tag))))))))
         (printer element))))))
