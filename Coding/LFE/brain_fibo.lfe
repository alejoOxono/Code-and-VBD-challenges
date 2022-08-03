(defun split_data (str)
  (string:split str " "))

(defun get_cases (data)
  (let*
    ((n_cases (erlang:list_to_integer (lists:nth 1 data))))
      (eval_cases n_cases)))

(defun eval_cases
  ((1) (get_numbers (- n 1)))
  ((n) (get_numbers n)(eval_cases (- n 1))))

(defun get_numbers (n)
    (let*
    ((n_cases (erlang:list_to_integer (lists:nth 1 data)))
    (num_init (erlang:list_to_integer (string:trim 
      (lists:nth 1 (split_data (lists:nth 2 data))))))
    (num_end (erlang:list_to_integer (string:trim 
      (lists:nth 2 (split_data (lists:nth 2 data)))))))
      (lfe_io:print (get_fibo n n_cases num_init num_end)))
      (lfe_io:format " " ()))

(defun get_fibo (n n_cases num_init num_end)
  (let 
    ((ciclos (- n n_cases))
    (new_num_end (+ num_init num_end)))
      (cond
        ((=:= ciclos 0) new_num_end)
        ('true (get_fibo (+ n 1) n_cases num_end new_num_end)))))

(defun main()
    (let*
      ((str (io:get_line ""))
      (splitting (split_data str)))
        (get_cases splitting)))

(main)