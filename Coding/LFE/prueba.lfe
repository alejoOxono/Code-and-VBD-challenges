(code:ensure_loaded 'math)

(defun get_primes (one two primes)
  (cond
    ((> one two) primes)
    ((=:= (is_prim one 2 (get_max_prime one)) 1)
      (get_primes (+ one 1) two (+ primes 1)))
    ('true (get_primes (+ one 1) two primes))))

(defun is_prim (num control max_prime)
  (cond
    ((>= control max_prime) 1)
    ((=:= (rem num control) 0) 0)
    ('true (is_prim num (+ control 1) max_prime))))

(defun get_max_prime (num)
  (if (> num 49)
  (cond
    ((=:= (rem num 7) 0) (get_max_prime (div num 7)) )
    ((=:= (rem num 5) 0) (get_max_prime (div num 5)) )
    ((=:= (rem num 3) 0) (get_max_prime (div num 3)) )
    ((=:= (rem num 2) 0) (get_max_prime (div num 2)) )
    ('true (round (+ (math:sqrt num) 1))))
    num))

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
      ((first_num (get_numbers line 1))
      (second_num (get_numbers line 2)))
        (lfe_io:print (get_primes first_num second_num 0))
        (lfe_io:format " " ()))))

(defun cases
  ((1) (print_result))
  ((n) (print_result)(cases (- n 1))))

(defun main()
  (cases
    (list_to_integer (lists:nth 1 (string:tokens (io:get_line "") "\n")))))

(main)