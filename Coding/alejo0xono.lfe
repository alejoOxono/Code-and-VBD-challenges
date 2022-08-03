;Erlang/OTP 24 [erts-12.3.2.1] [source] [64-bit]
;[smp:6:6] [ds:6:6:10] [async-threads:1] [jit]
;Eshell V12.3.2.1  (abort with ^G)

(code:ensure_loaded 'math)

(defun get_triplets (num exp)
  (let*
    [(var_A (+ exp 1))
    (var_B (+ (- (math:pow num 2) (* 2 (* num exp)))
      (* 2 (math:pow exp 2))))
    (var_C (* 2 (- num exp)))]
    (cond
      [(>= var_A (/ num 3)) 0]
      [(=:= (rem (round var_B) (round var_C)) 0)
        (round (math:pow (/ var_B var_C) 2))]
      ['true (get_triplets num var_A)])))

(defun get_numbers (array x)
  (list_to_integer (lists:nth x array)))

(defun split_data ()
  (let
    ((input_data
      (string:split (io:get_line "") "\n")))
    (list
      (lists:nth 1 (string:split
        (lists:nth 1 input_data) " ")))))

(defun print_result ()
  (let
    ((line (split_data)))
    (let
      ((first_num (get_numbers line 1)))
        (lfe_io:print (get_triplets first_num 2))
        (lfe_io:format " " ()))))

(defun cases
  ((1) (print_result))
  ((n) (print_result)(cases (- n 1))))

(defun main()
  (cases
    (list_to_integer (lists:nth 1 (string:tokens (io:get_line "") "\n")))))

(main)

;cat DATA.lst | lfe alejo0xono.lfe
;1483599516961 1060436550625 411714722500 825590304400
;622063464100 357309844516 1232568464521
