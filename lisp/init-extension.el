;;; init-extension -- Initializes Editor Extensions

;;; Commentary:
;;;
;;; Configures the default editor with some extensions.
;;; Uses various power editing features found in sublime text.

;;; Code:

(battery:require-packages 'expand-region)

(defmacro move-back-horizontal-after (&rest code)
  "Move back to original position after CODE execution."
  `(let ((horizontal-position (current-column)))
     (progn
       ,@code
       (move-to-column horizontal-position))))

(defun comment-or-uncomment-line-or-region ()
  "Comment/Uncomment the current line or a selected region."
  (interactive)
  (if (region-active-p)
      (comment-or-uncomment-region (region-beginning) (region-end))
    (move-back-horizontal-after
     (comment-or-uncomment-region (line-beginning-position) (line-end-position))
     (forward-line 1))))

(defun duplicate-line ()
  "Duplicates the current line."
  (interactive)
  (move-back-horizontal-after
   (move-beginning-of-line 1)
   (kill-line)
   (yank)
   (open-line 1)
   (forward-line 1)
   (yank)))

(defun expand-to-word-and-multiple-cursors (args)
  "Expand and create multiple cursors the next occurance of ARGS."
  (interactive "p")
  (if (region-active-p) (mc/mark-next-like-this args) (er/mark-word)))

(battery:after-initializing
 (require 'expand-region)
 (global-set-key (kbd "M-s-<right>") 'switch-to-next-buffer)
 (global-set-key (kbd "M-s-<left>") 'switch-to-prev-buffer)
 (global-set-key (kbd "s-D") 'duplicate-line)
 (global-set-key (kbd "s-Z") 'undo-tree-redo)
 (global-set-key (kbd "M-;") 'comment-or-uncomment-line-or-region)
 (global-set-key (kbd "s-d") 'expand-to-word-and-multiple-cursors))


(provide 'init-extension)

;;; init-extension ends here
