;;; init-backups -- Initializes Backups Configs

;;; Commentary:
;;;
;;; Configures file backups and auto-saves.

;;; Code:

(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Save point position between sessions
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (expand-file-name ".places" user-emacs-directory))

(provide 'init-backups)

;;; init-backups ends here
