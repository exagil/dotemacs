;;; init-go -- Initializes Go Language Pack Configs

;;; Commentary:
;;;
;;; Configures editor support Go tooling and modes.
;;;
;;; Find more information at:-
;;;
;;; Home Page: http://golang.org/
;;; GitHub: https://github.com/dominikh/go-mode.el

;;; Code:

(battery:require-packages 'go-mode
			  'go-def
			  'go-autocomplete
			  'go-imports
			  'go-oracle
			  'go-test
			  'go-rename)

(defun battery:go-mode-hook ()
  (add-hook 'before-save-hook 'gofmt-before-save)
  ;; Customize compile command to run go build
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v"))
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "M-,") 'pop-tag-mark)
  (local-set-key (kbd "C-c ,") 'go-test-current-file)
  (local-set-key (kbd "C-c .") 'go-test-current-test))

(battery:after-initializing
 (add-hook 'go-mode-hook 'battery:go-mode-hook))

(when *is-mac*
  (battery:after-initializing
   `(add-to-list 'exec-path-from-shell-variables "GOPATH")))

(provide 'init-go)

;;; init-go ends here
