;;; init-theme -- Initializes Color Theme Configs

;;; Commentary:
;;;
;;; Configures the default color theme.
;;; Uses Ethan Schoonover's solalized color theme.
;;;
;;; Find more information at:-
;;;
;;; Home Page: http://ethanschoonover.com/solarized
;;; GitHub: https://github.com/sellout/emacs-color-theme-solarized

;;; Code:

(battery:require-packages 'color-theme-solarized)
(battery:after-initializing
 (color-theme-solarized-dark)
 (set-default-font "DejaVu Sans Mono 14"))

(provide 'init-theme)

;;; init-theme ends here
