(in-package :cl-user)
(defpackage cl-mdb.web
  (:use :cl
        :caveman2
        :cl-mdb.config
        :cl-mdb.view
        :cl-mdb.db
        :datafly
        :sxql)
  (:export :*web*))
(in-package :cl-mdb.web)

;; for @route annotation
(syntax:use-syntax :annot)

;;
;; Application

(defclass <web> (<app>) ())
(defvar *web* (make-instance '<web>))
(clear-routing-rules *web*)

;; Config drakma
(push (cons "application" "json") drakma:*text-content-types*)
(setf drakma:*header-stream* *standard-output*)

;;
;; Routing rules

(defroute "/" ()
  (render #P"index.html"))

(defroute "/shows" ()
  (let ((shows (cl-json:decode-json-from-string
		(drakma:http-request "https://api.tvmaze.com/shows"))))
  (render #P"shows.html" (list :shows shows))))

(defroute "/schedule" ()
  (render #P"schedule.html"))

;;
;; Error pages

(defmethod on-exception ((app <web>) (code (eql 404)))
  (declare (ignore app))
  (merge-pathnames #P"_errors/404.html"
                   *template-directory*))
