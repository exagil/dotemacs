;;; init-base -- Initializes Base Configs

;;; Commentary:
;;;
;;; Configures bundled and installed packages.

;;; Code:

(battery:require-packages 'anzu
			  'browse-kill-ring
			  'company-mode
			  'etags-select
			  'eproject
			  'deft
			  'projectile
			  'undo-tree
			  'smex
			  'multiple-cursors
			  'yasnippets
			  'rainbow-delimiters
			  'neotree
			  'flycheck
			  'wgrep
			  'smartparens
			  'grizzl)

(when *is-mac*
  (battery:require-packages 'exec-path-from-shell))

(defun back-to-indentation-or-beginning ()
  "Jumps backwards to indentation or begining of line."
  (interactive)
  (if (= (point)
	 (progn (back-to-indentation) (point)))
      (beginning-of-line)))

(defun indent-buffer ()
  "Indent the currently visited buffer."
  (interactive)
  (indent-region (point-min) (point-max)))

(defun indent-region-or-buffer ()
  "Indent a region if selected, otherwise the whole buffer."
  (interactive)
  (save-excursion
    (if (region-active-p)
	(progn (indent-region (region-beginning) (region-end)))
      (progn (indent-buffer)))))

(defun move-line-up ()
  "Move the current line up."
  (interactive)
  (transpose-lines 1)
  (forward-line -2))

(defun move-line-down ()
  "Move the current line down."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1))

(defun visit-project-tags ()
  "Visits and load the current project tags."
  (interactive)
  (let ((tags-file (concat (eproject-root) "TAGS")))
    (visit-tags-table tags-file)
    (message (concat "Loaded " tags-file))))

(defun build-ctags ()
  "Build ctags for current project."
  (interactive)
  (message "Building project tags...")
  (let ((root (eproject-root)))
    (shell-command (concat "ctags -e -R -f " root "TAGS " root)))
  (visit-project-tags)
  (message "Tags built successfully."))

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)

(when *is-mac*
  (battery:after-initializing
   `(exec-path-from-shell-initialize)))

(battery:after-initializing
 (projectile-global-mode t)
 (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
 (add-hook 'emacs-lisp-mode-hook 'smartparens-mode)
 (global-linum-mode t)
 (global-company-mode t)
 (global-undo-tree-mode t)
 (global-flycheck-mode t)
 (column-number-mode t)
 (tool-bar-mode -1)
 (ido-mode 1)
 (delete-selection-mode t)
 (fset 'yes-or-no-p 'y-or-n-p)
 (scroll-bar-mode -1)
 (yas-global-mode t)
 (add-hook 'before-save-hook 'delete-trailing-whitespace))

(battery:after-initializing
 (windmove-default-keybindings)
 (global-set-key (kbd "C-a") 'back-to-indentation-or-beginning)
 (global-set-key (kbd "C-=") 'er/expand-region)
 (global-set-key (kbd "s-t") 'projectile-find-file)
 (global-set-key (kbd "s-g") 'projectile-grep)
 (global-set-key (kbd "M-x") 'smex)
 (global-set-key (kbd "RET") 'newline-and-indent)
 (global-set-key (kbd "s-p") 'projectile-switch-project)
 (global-set-key (kbd "M-s-<up>") 'move-line-up)
 (global-set-key (kbd "M-s-<down>") 'move-line-down)
 (global-set-key (kbd "C-c n") 'indent-region-or-buffer)
 (global-set-key (kbd "<f8>") 'deft)
 (global-set-key (kbd "<f7>") 'build-ctags)
 (global-set-key (kbd "M-?") 'etags-select-find-tag-at-point)
 (global-set-key (kbd "M-.") 'etags-select-find-tag))

;; Show full file path in the title bar
(setq
 frame-title-format
 '((:eval (if (buffer-file-name)
	      (abbreviate-file-name (buffer-file-name))
	    "%b"))))

;; Scroll one line at a time
(setq scroll-conservatively 10)

(global-hl-line-mode)

;; Disables audio bell
(setq ring-bell-function
      (lambda () (message "*beep*")))

(setq projectile-completion-system 'grizzl)

(setq deft-directory "~/Dropbox/Notes")
(setq deft-extensions '("txt" "tex" "org"))
(setq deft-recursive t)

(provide 'init-base)

;;; init-base ends here
