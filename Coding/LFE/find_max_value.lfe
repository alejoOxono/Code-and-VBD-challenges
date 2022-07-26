(defmodule tut9
  (export (list-max 1)))

(defun list-max
  (((cons head tail))
   (list-max tail head)))

(defun list-max
  (('() results)
   results)
  (((cons head tail) result-so-far) (when (> head result-so-far))
   (list-max tail head))
  (((cons head tail) result-so-far)
   (list-max tail result-so-far)))


;;---------------------++++++---------------------


;;lfe> (c "tut9.lfe")
;;#(module tut9)
;;lfe> (tut9:list-max '(1 2 3 4 5 6 7 4 3 2 1))
;;7