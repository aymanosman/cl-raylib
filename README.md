Work in Progress Bindings to raylib

**Running an example**

```shell
$ git clone --branch wip https://github.com/aymanosman/cl-raylib.git ~/quicklisp/local-projects/raylib
```

```lisp
;; optional, if you want to connect from Emacs
;; (ql:quickload "slynk")
;; (slynk:create-server :port 4005 :dont-close t)

(ql:quickload :raylib)

(load "examples/shapes/shapes-collision-area")

(in-package :raylib)

(main)
```
