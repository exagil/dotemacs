;;; init-ruby -- Initializes Ruby Language Pack Configs

;;; Commentary:
;;;
;;; Configures editor support Ruby tooling and modes.
;;;
;;; Find more information at:-
;;;
;;; Home Page: http://www.ruby-lang.org/en/

;;; Code:

(battery:require-packages 'rspec-mode
			  'ruby-tools
			  'yaml-mode
			  'ruby-electric)

(eval-after-load 'rspec-mode
  '(rspec-install-snippets))

(provide 'init-ruby)

;;; init-ruby ends here
