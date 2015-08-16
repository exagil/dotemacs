;;; init-slime -- Initializes Common Lisp Language Pack Configs

;;; Commentary:
;;;
;;; Extends editor with support for intractive programming
;;; in Common Lisp.
;;;
;;; Find more information at:-
;;;
;;; Home Page: https://common-lisp.net/project/slime/
;;; GitHub Page: https://github.com/slime/slime

;;; Code:

(battery:require-packages 'slime)

(setq inferior-lisp-program "/usr/local/bin/sbcl")
(setq slime-contribs '(slime-fancy))

(provide 'init-slime)

;;; init-slime ends here
