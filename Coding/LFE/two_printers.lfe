;Erlang/OTP 24 [erts-12.3.2.1] [source] [64-bit]
;[smp:6:6] [ds:6:6:10] [async-threads:1] [jit]
;Eshell V12.3.2.1  (abort with ^G)

(defun printing_time
  (printer_one printer_two n_pages pages_one pages_two)
  (let*
    ((time_one (* printer_one pages_one))
    (time_two (* printer_two pages_two)))
  (cond
    ((=:= (+ pages_one pages_two) n_pages)
      (if (>= time_one time_two)
        time_one
        time_two))
    ((=< (+ time_one printer_one) (+ time_two printer_two))
      (printing_time
        printer_one printer_two n_pages (+ pages_one 1) pages_two))
    ((> (+ time_one printer_one) (+ time_two printer_two))
      (printing_time
        printer_one printer_two n_pages pages_one (+ pages_two 1)))
    )))

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
        (lists:nth 2 (string:split (lists:nth 1 input_data) " "))" "))
      (lists:nth 2 (string:split
        (lists:nth 2 (string:split (lists:nth 1 input_data) " "))" ")))))

(defun print_result ()
  (let
    ((line (split_data)))
    (let ((printer_one (get_numbers line 1))
      (printer_two (get_numbers line 2))
      (n_pages
        (if (> (get_numbers line 3) 1000000000)
        1000000000
        (get_numbers line 3))))
        (lfe_io:print (if (=:= printer_one printer_two)
          (div (* printer_one n_pages) 2)
          (printing_time printer_one printer_two n_pages 0 0)))
        (lfe_io:format " " ()))))

(defun cases
  ((1) (print_result))
  ((n) (print_result)(cases (- n 1))))

(defun main()
  (cases
    (list_to_integer (lists:nth 1 (string:tokens (io:get_line "") "\n")))))

(main)

;cat DATA.lst | lfe alejo0xono.lfe
;263570244 119343600 206935150 7594216 443864340 333662520
;465199315 21526648 382587624 10284585 3859542 289537086
;81928440 106453956 110322415
