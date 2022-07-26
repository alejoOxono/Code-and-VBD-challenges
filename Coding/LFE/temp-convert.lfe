(defmodule tut8
  (export (format-temps 1)))

;; Only this function is exported
(defun format-temps
  ((())
    ;; No output for an empty list
    'ok)
  (((cons city rest))
    (print-temp (f->c city))
    (format-temps rest)))

(defun f->c
  (((tuple name (tuple 'C temp)))
    ;; No conversion needed
    (tuple name (tuple 'C temp)))
  (((tuple name (tuple 'F temp)))
    ;; Do the conversion
    (tuple name (tuple 'C (/ (* (- temp 32) 5) 9)))))

(defun print-temp
  (((tuple name (tuple 'C temp)))
    (lfe_io:format "~-15w ~w C~n" (list name temp))))

;;---------**********------------

;;lfe> (c "tut8.lfe")
;;#(module tut8)
;;lfe> (tut8:format-temps
;;    '(#(Moscow #(C 10))
;;      #(Cape-Town #(F 70))
;;      #(Stockholm #(C -4))
;;      #(Paris #(F 28))
;;      #(London #(F 36)))))
;;Moscow          10 C
;;Cape-Town       21.11111111111111 C
;;Stockholm       -4 C
;;Paris           -2.2222222222222223 C
;;London          2.2222222222222223 C
;;ok

;;---------**********------------

(defmodule tut12
  (export (format-temps 1)))

(defun format-temps (cities)
  (print-temps (->c cities)))

(defun ->c
  (((cons (tuple name (tuple 'F temp)) tail))
   (let ((converted (tuple name (tuple 'C (/ (* (- temp 32) 5) 9)))))
     (cons converted (->c tail))))
  (((cons city tail))
   (cons city (->c tail)))
  (('())
   '()))

(defun print-temps
  (((cons (tuple name (tuple 'C temp)) tail))
   (io:format "~-15w ~w c~n" (list name temp))
   (print-temps tail))
  (('())
   'ok))

;;---------**********------------

;;lfe> (c "tut12.lfe")
;;#(module tut12)
;;lfe> (tut12:format-temps
;;    '(#(Moscow #(C 10))
;;      #(Cape-Town #(F 70))
;;      #(Stockholm #(C -4))
;;      #(Paris #(F 28))
;;      #(London #(F 36)))))
;;'Moscow'        10 c
;;'Cape-Town'     21.11111111111111 c
;;'Stockholm'     -4 c
;;'Paris'         -2.2222222222222223 c
;;'London'        2.2222222222222223 c
;;ok
