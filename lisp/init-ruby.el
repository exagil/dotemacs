;;; init-ruby -- Initializes Ruby Language Pack Configs

;;; Commentary:
;;;
;;; Configures editor support Ruby tooling and modes.
;;;
;;; Find more information at:-
;;;
;;; Home Page: http://www.ruby-lang.org/en/

;;; Code:

(battery:require-packages 'ruby-mode
			  'inf-ruby
			  'rspec-mode
			  'ruby-tools
			  'yaml-mode
			  'ruby-electric)

(eval-after-load 'rspec-mode
  '(rspec-install-snippets))

(battery:after-initializing
 (add-hook 'after-init-hook 'inf-ruby-switch-setup)
 (autoload 'inf-ruby-minor-mode
   "inf-ruby" "Run an inferior Ruby process" t)
 (add-hook 'ruby-mode-hook 'inf-ruby-minor-mode))

(provide 'init-ruby)

;;; init-ruby ends here
