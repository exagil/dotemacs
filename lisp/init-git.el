;;; init-git -- Initializes Git DVCS Configs

;;; Commentary:
;;;
;;; Configures Git DVCS support.
;;; Uses Magit as an interface to Git.
;;;
;;; Find more information at:-
;;;
;;; Home Page: http://magit.vc/
;;; Manual: http://magit.vc/manual

;;; Code:

(battery:require-packages 'magit
			  'diff-hl)

(battery:after-initializing
 (global-diff-hl-mode t)
 (global-set-key (kbd "C-c g") 'magit-status))

(provide 'init-git)

;;; init-git ends here
