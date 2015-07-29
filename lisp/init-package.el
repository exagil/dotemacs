;;; init-package -- Initializes Packages

;;; Commentary:
;;;
;;; Configures package respository and battery customizables.
;;; Using el-get to manage packages.
;;;
;;; Find more information at:-
;;;
;;; GitHub: https://github.com/dimitri/el-get

;;; Code:

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (require 'package)
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.org/packages/"))
  (package-refresh-contents)
  (package-initialize)
  (package-install 'el-get)
  (require 'el-get))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")

(setq battery:el-get-packages '())

(defvar battery:initialized-hook nil)

(defun battery:require-packages (&rest packages)
  (setq battery:el-get-packages
	(append battery:el-get-packages packages)))

(defmacro battery:after-initializing (&rest body)
  `(add-hook 'battery:initialized-hook
     (lambda ()
       ,@body)))

(provide 'init-package)

;;; init-package ends here
