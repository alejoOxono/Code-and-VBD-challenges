;Erlang/OTP 24 [erts-12.3.2.1] [source] [64-bit]
;[smp:6:6] [ds:6:6:10] [async-threads:1] [jit]
;Eshell V12.3.2.1  (abort with ^G)

(defun split_data (str)
  (string:split str " "))

(defun get_numbers ()
  (let*
    ((str (io:get_line ""))
    (splitting (split_data str))
    (width (erlang:list_to_integer (lists:nth 1 splitting)))
    (height (erlang:list_to_integer (string:trim
      (lists:nth 1 (split_data (lists:nth 2 splitting))))))
    (lenght (erlang:list_to_integer (string:trim
      (lists:nth 2 (split_data (lists:nth 2 splitting)))))))
      (lfe_io:format "0 0 " ())
      (cicle width height lenght 0 0 0 1 1)))

(defun cicle (width height lenght n x y x_way y_way)
  (cond ((< n 100)
    (let*
      ((x_way (get_x_way width lenght x x_way))
      (y_way (get_y_way height y y_way))
      (x_axis (get_sequence_x width lenght x x_way))
      (y_axis (get_sequence_y height y y_way)))
        (lfe_io:print x_axis)
        (lfe_io:format " " ())
        (lfe_io:print y_axis)
        (lfe_io:format " " ())
        (cicle width height lenght (+ n 1) x_axis y_axis x_way y_way)))))

(defun get_x_way (width lenght x x_way)
    (cond
      ((=:= width (+ x lenght)) 0)
      ((=:= x 0) 1)
      ('true x_way)))

(defun get_y_way (height y y_way)
    (cond
      ((=:= height (+ y 1)) 0)
      ((=:= y 0) 1)
      ('true y_way)))

(defun get_sequence_x (width lenght x x_way)
  (if (=:= x_way 1)
    (cond
      ((=:= width (+ x lenght)) (- x 1))
      ('true (+ x 1)))
    (cond
      ((=:= x 0) (+ x 1))
      ('true (- x 1)))))

(defun get_sequence_y (height y y_way)
  (if (=:= y_way 1)
    (cond
      ((=:= height (+ y 1)) (- y 1))
      ('true (+ y 1)))
    (cond
      ((=:= y 0) (+ y 1))
      ('true (- y 1)))))

(defun main()
    (get_numbers))

(main)

;cat DATA.lst | lfe alejo0xono.lfe
;0 0 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 11 11 12 12 13
;13 14 14 15 15 16 16 17 17 18 16 19 15 20 14 21 13 22 12 23
;11 24 10 25 9 26 8 27 7 28 6 29 5 30 4 31 3 32 2 33 1 34 0
;35 1 36 2 37 3 36 4 35 5 34 6 33 7 32 8 31 9 30 10 29 11 28
;12 27 13 26 14 25 15 24 16 23 17 22 16 21 15 20 14 19 13 18
;12 17 11 16 10 15 9 14 8 13 7 12 6 11 5 10 4 9 3 8 2 7 1 6
;0 5 1 4 2 3 3 2 4 1 5 0 6 1 7 2 8 3 9 4 10 5 11 6 12 7 13 8
;14 9 15 10 16 11 17 12 16 13 15 14 14 15 13 16 12 17 11 18
;10 19 9 20 8 21 7 22 6 23 5 24 4 25 3 26 2
