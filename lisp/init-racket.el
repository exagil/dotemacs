;;; init-racket -- Initializes Racket Language Pack Configs

;;; Commentary:
;;;
;;; Configures editor support Racket tooling and modes.
;;;
;;; Find more information at:-
;;;
;;; Home Page: http://racket-lang.org/

;;; Code:

(battery:require-packages 'racket-mode)

(add-hook 'racket-mode-hook
          (lambda ()
            (define-key racket-mode-map (kbd "C-c r") 'racket-run)))

(provide 'init-racket)

;;; init-racket ends here
