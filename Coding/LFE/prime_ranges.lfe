;Erlang/OTP 24 [erts-12.3.2.1] [source] [64-bit]
;[smp:6:6] [ds:6:6:10] [async-threads:1] [jit]
;Eshell V12.3.2.1  (abort with ^G)

(code:ensure_loaded 'math)

(defun get_primes (one two primes)
  (cond
    ((> one two) primes)
    ((=:= (cond
      ('true (get_max_prime one 2 0))) 1)
        (get_primes (+ one 1) two (+ primes 1)))
    ('true (get_primes (+ one 1) two primes))))

(defun is_prim (num)
  (let* ((round_num (round (math:sqrt num)))
         (total_num (math:sqrt num)))
  (cond
    ((=:= total_num round_num) 0)
    ((=:= (- total_num round_num) 0.0) 0)
    ('true 1))))

(defun get_max_prime (num control break)
  (cond
    ((>= control num) 1)
    ((=:= break 1) 0)
    ; ((> control (round (math:sqrt num))) (is_prim num))
    ((> (rem num control) 1) 
      (get_max_prime num (+ control 1) 0))
    ((=:= (rem num control) 0) (get_max_prime num 0 1))))

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

;cat DATA.lst | lfe alejo0xono.lfe
;26 1895 -18461 -14254 -54623 7919 -46965 14782 -40407 -57921 
;-31445 -57503 -66907 -26688 -55348 5942 55052 4918 36314 21617
;15370 17604 38837 11437 24186 3643 29740 34182 29684 5018
