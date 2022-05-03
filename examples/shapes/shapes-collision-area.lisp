(in-package :raylib)

(defvar box-a)
(defvar box-a-speed-x 4)
(defvar box-b)
(defvar box-collision)
(defvar pause nil)
(defvar collision nil)
(defvar screen-width 800)
(defvar screen-upper-limit 40)

(define-modify-macro multf (&optional (number 1)) *)

(defun game-loop ()
  (if (window-should-close) (return-from game-loop))

  ;; Update
  (when (not pause)
    (incf (rectangle-x box-a) box-a-speed-x))

  (when (or (>= (+ (rectangle-x box-a) (rectangle-width box-a)) (get-screen-width))
            (<= (rectangle-x box-a) 0))
    (multf box-a-speed-x -1))

  (setf (rectangle-x box-b)
        (- (get-mouse-x) (/ (rectangle-width box-b) 2))
        (rectangle-y box-b)
        (- (get-mouse-y) (/ (rectangle-height box-b) 2)))

  (setf collision (check-collision-recs box-a box-b))

  (when collision
    (setf box-collision (get-collision-rec box-a box-b)))

  (when (is-key-pressed :space)
    (setf pause (not pause)))

  (begin-drawing)
  (clear-background +raywhite+)
  (draw-rectangle 0 0 screen-width screen-upper-limit (if collision +red+ +black+))
  (draw-rectangle-rec box-a +gold+)
  (draw-rectangle-rec box-b +blue+)

  (when collision
    (draw-rectangle-rec box-collision +lime+)
    (draw-text "COLLISION!" (- (/ (get-screen-width) 2) (/ (measure-text "COLLISION!" 20) 2)) (- (/ screen-upper-limit 2) 10) 20 +black+)
    (draw-text (format nil "Collision Area: ~a" (* (rectangle-width box-collision) (rectangle-height box-collision)))
               (- (/ (get-screen-width) 2) 100)
               (+ screen-upper-limit 10)
               20
               +black+))

  (draw-fps 10 10)

  (end-drawing)

  (game-loop))

(defun main ()
  (init-window screen-width 450 "raylisp [shapes] example - collision area")
  (unwind-protect
       (progn
         (set-target-fps 60)
         (setf box-a (make-rectangle :x 10
                                     :y (- (/ (get-screen-height) 2.0) 50)
                                     :width 200
                                     :height 100))
         (setf box-b (make-rectangle :x (- (/ (get-screen-width) 2.0) 30)
                                     :y (- (/ (get-screen-width) 2.0) 30)
                                     :width 60
                                     :height 60))
         (setf box-collision (make-rectangle :x 0 :y 0 :width 0 :height 0))
         (game-loop))
    (close-window)))
