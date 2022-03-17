(defpackage #:cgi
  (:use :cl
        :split-sequence
        :do-urlencode)
  (:export
   ;;; utilities
   :split ; alias of split-sequence
   :safe-string
   ;;; HTML generation
   :make-html
   ;; void tags
   :img :br :hr :area :base :col :command :embed
   :input :keygen :link :meta :param :source :track
   :wbr
   ;;; HTTP response
   :http-response-header
   :http-response-redirect
   ;;; Query parsing
   :parse-query-string
   :query-method
   :parse-get-query
   :parse-post-query
   :get-queries))
