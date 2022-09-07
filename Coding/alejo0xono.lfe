;Erlang/OTP 24 [erts-12.3.2.1] [source] [64-bit]
;[smp:6:6] [ds:6:6:10] [async-threads:1] [jit]
;Eshell V12.3.2.1  (abort with ^G)

(defun print_solution (num1 num2)
  (lfe_io:print (+ num1 num2))
  (lfe_io:format " " ()))

(defun main()
  (let*
    ((list_numbers
      (lists:nth 1 (string:split (io:get_line "") "\n")))
    (num1 (list_to_integer (lists:nth 1 (string:split list_numbers " "))))
    (num2 (list_to_integer (lists:nth 2 (string:split list_numbers " ")))))
      (print_solution num1 num2)))

(main)

;cat DATA.lst | lfe alejo0xono.lfe
;23510
