;;; init.el -- Emacs Initial Config

;;; Commentary:
;;; One config to rule them all

;;; Code:

(require 'cask "/usr/local/share/emacs/site-lisp/cask.el")

(cask-initialize)

;; Menubar with no toolbar, scrollbar or startup message
(if (fboundp 'menu-bar-mode) (menu-bar-mode 1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(setq inhibit-startup-message t)

;; Load path
;; Package definitions
(setq settings-dir
      (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path settings-dir)

;; Custom settings
(setq user-settings-dir
      (concat user-emacs-directory "users/" user-login-name))
(add-to-list 'load-path user-settings-dir)

;; Emacs on OS X?
(setq *is-mac* (equal system-type 'darwin))

;; Backups go here
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Save point position between sessions
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (expand-file-name ".places" user-emacs-directory))

;;; Packages:

;; Editor

(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)

(use-package abbrev
  :diminish abbrev-mode
  :config
  (if (file-exists-p abbrev-file-name)
      (quietly-read-abbrev-file)))

(use-package deft
  :config
  (setq deft-extensions '("txt" "tex" "org"))
  (setq deft-directory "~/Dropbox/Notes")
  (setq deft-recursive t)
  :bind (("<f8>" . deft)))

(use-package nyan-mode
  :init (setq nyan-wavy-trail t)
  :config
  (nyan-mode 1)
  (nyan-start-animation))

(use-package magit
  :bind ("C-c g" . magit-status))

(use-package undo-tree
  :demand t
  :config (global-undo-tree-mode t)
  :bind (("s-Z" . undo-tree-redo)))

(use-package expand-region
  :config
  (defun expand-to-word-and-multiple-cursors (args)
    (interactive "p")
    (if (region-active-p) (mc/mark-next-like-this args) (er/mark-word)))
  :bind (("C-=" . er/expand-region)
	 ("s-d" . expand-to-word-and-multiple-cursors)))

(use-package color-theme
  :config
  (set-face-attribute 'default nil :font  "DejaVu Sans Mono-14")
  (set-frame-font "DejaVu Sans Mono-14" nil t))

(use-package color-theme-solarized
  :config
  (load-theme 'solarized t)
  (color-theme-solarized))

(use-package projectile
  :config
  (projectile-global-mode t)
  (setq projectile-completion-system 'grizzl)
  :bind   (("s-t" . projectile-find-file)
	   ("s-g" . projectile-grep)
	   ("s-p" . projectile-switch-project)))

(use-package rainbow-delimiters
  :config (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

(use-package smartparens
  :config (add-hook 'emacs-lisp-mode-hook 'smartparens-mode))

(use-package company
  :config (global-company-mode t))

(use-package flycheck
  :config (global-flycheck-mode t))

(use-package yasnippet
  :config (yas-global-mode t))

(use-package bind-key
  :init
  (defmacro move-back-horizontal-after (&rest code)
    `(let ((horizontal-position (current-column)))
       (progn
	 ,@code
	 (move-to-column horizontal-position))))

  (defun comment-or-uncomment-line-or-region ()
    (interactive)
    (if (region-active-p)
	(comment-or-uncomment-region (region-beginning) (region-end))
      (move-back-horizontal-after
       (comment-or-uncomment-region (line-beginning-position) (line-end-position))
       (forward-line 1))))

  (defun duplicate-line ()
    (interactive)
    (move-back-horizontal-after
     (move-beginning-of-line 1)
     (kill-line)
     (yank)
     (open-line 1)
     (forward-line 1)
     (yank)))

  (defun back-to-indentation-or-beginning () (interactive)
	 (if (= (point) (progn (back-to-indentation) (point)))
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
    (interactive)
    (transpose-lines 1)
    (forward-line -2))

  (defun move-line-down ()
    (interactive)
    (forward-line 1)
    (transpose-lines 1)
    (forward-line -1))

  :config
  (global-linum-mode t)
  (global-hl-line-mode t)
  (global-visual-line-mode t)
  (column-number-mode t)
  (mouse-avoidance-mode 'banish)
  (ido-mode t)
  (delete-selection-mode t)
  (fset 'yes-or-no-p 'y-or-n-p)
  (scroll-bar-mode -1)
  (add-hook 'before-save-hook 'delete-trailing-whitespace)
  (setq make-backup-files nil)		; Stop creating ~ files

  (setq ido-enable-flex-matching t)
  (setq ido-everywhere t)
  (setq frame-title-format		; Show full file path in the title bar
   '((:eval (if (buffer-file-name)
		(abbreviate-file-name (buffer-file-name))
	      "%b"))))
  (setq scroll-conservatively 10)	; Scroll one line at a time
  (setq ring-bell-function		; Disables audio bell
	(lambda () (message "*beep*")))

  :bind (("s-<left>"    . windmove-left)
	 ("s-<right>"   . windmove-right)
	 ("s-<up>"      . windmove-up)
	 ("s-<down>"    . windmove-down)
	 ("M-s-<right>" . switch-to-next-buffer)
	 ("M-s-<left>"  . switch-to-prev-buffer)
	 ("s-;"         . comment-or-uncomment-line-or-region)
	 ("C-a"         . back-to-indentation-or-beginning)
	 ("M-x"         . smex)
	 ("RET"         . newline-and-indent)
	 ("M-s-<up>"    . move-line-up)
	 ("M-s-<down>"  . move-line-down)
	 ("C-c n"       . indent-region-or-buffer)
	 ("C-M-y"       . duplicate-line)))


;; Languages

(use-package rspec-mode
  :config (rspec-install-snippets))

(use-package go-mode
  :init
  (defun custom-go-mode-hook ()
    (add-hook 'before-save-hook 'gofmt-before-save)
    ;; Customize compile command to run go build
    (if (not (string-match "go" compile-command))
	(set (make-local-variable 'compile-command)
	     "go build -v"))
    (local-set-key (kbd "M-.") 'godef-jump)
    (local-set-key (kbd "M-,") 'pop-tag-mark)
    (local-set-key (kbd "C-c ,") 'go-test-current-file))

  :config
  (require 'go-rename)
  (add-hook 'go-mode-hook 'custom-go-mode-hook)
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize)
    (exec-path-from-shell-copy-env "GOPATH")))

(use-package cider
  :config

  (setq cider-repl-history-file "~/.emacs.d/nrepl-history")
  (setq cider-auto-select-error-buffer t)
  (setq cider-repl-popup-stacktraces t)

  (defcustom clojure-column-line nil
    "When non nil, puts a line at some character on clojure mode"
    :type 'integer
    :group 'clojure)

  (defun custom-cider-shortcuts ()
    (local-set-key (kbd "C-c ,") 'cider-test-run-tests)
    (local-set-key (kbd "C-c ,") 'cider-test-run-tests))

  (defun custom-turn-on-fci-mode ()
    (when clojure-column-line
      (setq fci-rule-column clojure-column-line)
      (turn-on-fci-mode)))

  (defmacro clojure:save-before-running (function)
    `(defadvice ,function (before save-first activate)
       (save-buffer)))

  (defmacro clojure:load-before-running (function)
    `(defadvice ,function (before save-first activate)
       (cider-load-buffer)))

  (add-hook 'clojure-mode-hook 'smartparens-strict-mode)
  (add-hook 'clojure-mode-hook 'clj-refactor-mode)
  (add-hook 'clojure-mode-hook 'show-paren-mode)
  (add-hook 'clojure-mode-hook 'sp-use-paredit-bindings)
  (add-hook 'clojure-mode-hook
	    (lambda () (cljr-add-keybindings-with-prefix "C-c C-m")))
  (add-hook 'clojure-mode-hook 'custom-cider-shortcuts)
  (add-hook 'clojure-mode-hook 'custom-turn-on-fci-mode)

  (add-hook 'cider-repl-mode-hook 'smartparens-strict-mode)
  (add-hook 'cider-repl-mode-hook 'show-paren-mode)
  (add-hook 'cider-repl-mode-hook 'sp-use-paredit-bindings)

  (clojure:save-before-running cider-load-current-buffer)
  (clojure:load-before-running cider-test-run-tests)
  (clojure:load-before-running cider-test-rerun-tests)
  (clojure:load-before-running cider-test-run-test))

(use-package ruby-mode
  :mode "\\.rb\\'"
  :interpreter "ruby"
  :functions inf-ruby-keys
  :config
  (defun custom-ruby-mode-hook ()
    (require 'inf-ruby)
    (inf-ruby-keys))
  (add-hook 'ruby-mode-hook 'custom-ruby-mode-hook))

(use-package python
  :mode ("\\.py\\'" . python-mode)
  :interpreter ("python" . python-mode))

;;; Custom:

;; Local customizations
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; Conclude init by setting up specifics for the current user
(when (file-exists-p user-settings-dir)
  (mapc 'load (directory-files user-settings-dir nil "^[^#].*el$")))

(provide 'init)
;;; init.el ends here
