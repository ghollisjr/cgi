(in-package :cgi)

;;;; Query parsing

(defun decode (string)
  "Decodes URL-encoded string"
  (handler-case
      (urldecode
       (map 'string
            (lambda (c)
              (if (char= c #\+)
                  #\Space
                  c))
            string))
    ;; ignore decoding errors for now
    (error nil string)))

(defun parse-query-string (string)
  (when (plusp (length string))
    (let* ((parts (split #\& string))
           (result (make-hash-table :test 'equal)))
      (dolist (part parts)
        (handler-case
            (destructuring-bind (param value)
                (split #\= part)
              (when (not (gethash param result))
                (setf (gethash param result)
                      (decode value))))
          ;; Singleton case
          (error nil (setf (gethash part result) t))))
      result)))

(defun query-method ()
  "Returns string denoting query method or NIL if no query"
  (let* ((string (sb-ext:posix-getenv "REQUEST_METHOD")))
    (unless (zerop (length string))
      string)))

(defun parse-get-query ()
  "Returns hash-table mapping parameter to value from GET query string"
  (when (equalp "GET" (query-method))
    (let ((string (sb-ext:posix-getenv "QUERY_STRING")))
      (parse-query-string string))))

(defun parse-post-query ()
  "Returns hash-table mapping parameter to value from POST query string"
  (when (equalp "POST" (query-method))
    (let ((string (read-line *standard-input* nil "")))
      (when string
        (parse-query-string string)))))

(defun get-queries ()
  "Gets all queries, GET or POST, and returns a hash table."
  (or (parse-get-query)
      (parse-post-query)))
