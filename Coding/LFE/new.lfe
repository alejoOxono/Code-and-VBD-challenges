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