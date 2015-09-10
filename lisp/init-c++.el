;;; init-c++ -- Initializes C/C++ Language Pack Configs

;;; Commentary:
;;;
;;; Configures editor support C++ tooling and modes.
;;;
;;; Find more information at:-
;;;
;;; Home Page: https://isocpp.org/

;;; Code:

(battery:after-initializing
 (add-hook 'c++-mode-hook
	   (lambda ()
	     (setq flycheck-clang-language-standard "c++11"))))

(provide 'init-c++)

;;; init-c++ ends here
