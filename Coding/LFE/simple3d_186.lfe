;Erlang/OTP 24 [erts-12.3.2.1] [source] [64-bit]
;[smp:6:6] [ds:6:6:10] [async-threads:1] [jit]
;Eshell V12.3.2.1  (abort with ^G)

(defun do_operations (coord_x coord_y height)
  (let*
    ((screen_width 480)
    (screen_height 360)
    (scr_dist 0.5)
    (scr_width 0.4)
    (scr_height 0.3)
    (k (/ scr_dist coord_x))
    (rx (round
      (* (+ (* (- 0 coord_y) k) (/ scr_width 2))
      (/ screen_width scr_width))))
    (ry1 (round
      (* (- (/ scr_height 2) (* -1 k))
      (/ screen_height scr_height))))
    (ry2 (round
      (* (- (/ scr_height 2) (* -1 k) (* height k))
      (/ screen_height scr_height)))))
      (lfe_io:print rx)
      (lfe_io:format " " ())
      (lfe_io:print ry1)
      (lfe_io:format " " ())
      (lfe_io:print ry2)
      (lfe_io:format " " ())))

(defun get_numbers (array x cases)
  (cond
    ((=:= cases 0) (list_to_float (lists:nth x array)))
    ('true (list_to_integer (lists:nth x array)))))

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

(defun clean_data ()
  (let*
    ((line (split_data))
    (coord_x (get_numbers line 1 1))
    (coord_y (get_numbers line 2 1))
    (height (get_numbers line 3 0)))
      (do_operations coord_x coord_y height)))

(defun cases
  ((1) (clean_data))
  ((n) (clean_data)(cases (- n 1))))

(defun main()
  (cases
    (list_to_integer (lists:nth 1 (string:tokens (io:get_line "") "\n")))))

(main)

;cat DATA.lst | lfe alejo0xono.lfe
;171 197 153 295 207 185 240 280 220 409 195 171 131 207 139
;126 209 166 0 300 48 480 220 124 440 193 164 40 197 168
;55 203 162 315 255 210 240 223 163

complexity: 12.38
others:
  in: 6
  out: 10
  totals: 16
score:
  initial: 99.65
  final: 112.03
  progress: 12.38
global-rank:
  initial: 5265
  final: 4769
  progress: 496
national-rank:
  initial: 340
  final: 317
  progress: 23
total-time: 182.82
effort: 15.62
productivity: 0.793