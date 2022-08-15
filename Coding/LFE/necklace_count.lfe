(code:ensure_loaded 'math)

(defun GetMCD (first_num second_num)
  (let
    ((rest (rem first_num second_num)))
      (cond
        ((> rest 0)
        (GetMCD second_num rest))
        ('true second_num))))

(defun GetResult (first_num second_num count result)
    (let
      ((power (round (math:pow first_num (GetMCD count second_num)))))
      (if (> count second_num)
        (div result second_num)
        (GetResult first_num second_num (+ count 1) (+ result power)))))

(defun get_numbers (array x)
  (list_to_integer (lists:nth x array)))

(defun split_data ()
  (let
    ((input_data (string:split (io:get_line "") "\n")))
    (list
      (lists:nth 1 (string:split
        (lists:nth 1 input_data) " "))
      (lists:nth 1 (string:split
        (lists:nth 2 (string:split (lists:nth 1 input_data) " "))" ")))))

(defun print_result ()
  (let*
    ((line (split_data))
    (first_num (get_numbers line 1))
    (second_num (get_numbers line 2)))
      (lfe_io:print (GetResult first_num second_num 1 0))
      (lfe_io:format " " ())))

(defun cases
  ((1) (print_result))
  ((n) (print_result)(cases (- n 1))))

(defun main()
  (cases
    (list_to_integer (lists:nth 1 (string:tokens (io:get_line "") "\n")))))

(main)