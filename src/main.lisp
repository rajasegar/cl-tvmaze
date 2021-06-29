(in-package :cl-user)
(defpackage cl-mdb
  (:use :cl)
  (:import-from :cl-mdb.config
                :config)
  (:import-from :clack
                :clackup)
  (:export :start
           :stop))
(in-package :cl-mdb)

(defvar *appfile-path*
  (asdf:system-relative-pathname :cl-mdb #P"app.lisp"))

(defvar *handler* nil)

(defun start (&rest args &key server port debug &allow-other-keys)
  (declare (ignore server port debug))
  (when *handler*
    (restart-case (error "Server is already running.")
      (restart-server ()
        :report "Restart the server"
        (stop))))
  (setf *handler*
        (apply #'clackup *appfile-path* args)))

(defun stop ()
  (prog1
      (clack:stop *handler*)
    (setf *handler* nil)))
