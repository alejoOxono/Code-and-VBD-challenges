(defun get_medals (rays segments)
    (cond 
      ((=< segments 1) 0)
      ((=:= (rem rays segments) 0) 0)
      ((> (/ segments rays) 0.5) 0)
      ('true (* rays (- segments 1)))))

(defun get_numbers (array x)
  (list_to_integer (lists:nth x array)))

(defun split_data ()
  (let
    ((input_data
      (string:split (io:get_line "") "\n")))
    (list
      (lists:nth 1 (string:split
        (lists:nth 1 input_data) " "))
      (lists:nth 1 (string:split
        (lists:nth 2 (string:split (lists:nth 1 input_data) " "))" ")))))

(defun print_result ()
  (let
    ((line (split_data)))
    (let*
      ((rays (get_numbers line 1))
      (segments (get_numbers line 2)))
        (lfe_io:print (get_medals rays segments))
        (lfe_io:format " " ()))))

(defun cases
  ((1) (print_result))
  ((n) (print_result)(cases (- n 1))))

(defun main()
  (cases
    (list_to_integer (lists:nth 1 (string:tokens (io:get_line "") "\n")))))

(main)

;52 38 76 17 95 57 44 19 33