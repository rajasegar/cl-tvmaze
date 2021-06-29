(defsystem "cl-mdb-test"
  :defsystem-depends-on ("prove-asdf")
  :author "Rajasegar Chandran"
  :license ""
  :depends-on ("cl-mdb"
               "prove")
  :components ((:module "tests"
                :components
                ((:test-file "cl-mdb"))))
  :description "Test system for cl-mdb"
  :perform (test-op (op c) (symbol-call :prove-asdf :run-test-system c)))
