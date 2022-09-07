(code:ensure_loaded 'math)

(defun get_order (first_num second_num)
  (if (>= first_num second_num) 
    (let*
      ((bigger first_num)
      (smaller second_num)) 
        (get_floor first_num second_num))
    (let*
      ((bigger second_num)
      (smaller first_num))
        (get_floor second_num first_num))))

(defun get_floor (bigger smaller)
  (let*
    ((exp_bigger (get_exp bigger 0))
    (exp_smaller (get_exp smaller 0))
    (positon_bigger (get_positon bigger exp_bigger))
    (position_smaller (get_positon smaller exp_smaller)))
      (get_result bigger smaller exp_bigger
      exp_smaller positon_bigger position_smaller)))

(defun get_exp (number exp)
  (let
    ((next_floor (round (math:pow 2 exp))))
      (cond
        ((> number next_floor) (get_exp number (+ exp 1)))
        ((< number next_floor) (- exp 1))
        ('true exp))))

(defun get_positon (number exp)
  (let
    ((mid (+ (round (math:pow 2 exp)) (round (math:pow 2 (- exp 1))))))
      (cond
        ((>= number mid) 1)
        ((< number mid) 0))))

(defun get_result 
  (bigger smaller exp_bigger exp_smaller positon_bigger position_smaller)
  (cond
    ((=:= bigger smaller) 1)
    ((=:= positon_bigger position_smaller) 
      (find_branch))
    ('true (+ exp_bigger exp_smaller 1))))

(defun find_branch (arguments)
    body)

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
      (lfe_io:print (get_order first_num second_num))
      (lfe_io:format " " ())))

(defun cases
  ((1) (print_result))
  ((n) (print_result)(cases (- n 1))))

(defun main()
  (cases
    (list_to_integer (lists:nth 1 (string:tokens (io:get_line "") "\n")))))

(main)