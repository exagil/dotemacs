;;; init-python -- Initializes Python Language Pack Configs

;;; Commentary:
;;;
;;; Configures editor support Python tooling and modes.
;;;
;;; Find more information at:-
;;;
;;; Home Page: https://www.python.org/
;;; GitHub Page: https://github.com/jorgenschaefer/elpy

;;; Code:

(battery:require-packages 'elpy)

(eval-after-load 'elpy
  '(elpy-enable))

(provide 'init-python)

;;; init-python ends here
