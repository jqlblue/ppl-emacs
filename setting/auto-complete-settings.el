;; -*- Emacs-Lisp -*-

;; Time-stamp: <2010-11-19 09:53:20 Friday by taoshanwen>

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories (concat my-emacs-my-lisps-path "auto-complete-compiled/ac-dict"))
(ac-config-default)
(define-key ac-complete-mode-map (kbd "<return>") 'ac-complete)
(define-key ac-complete-mode-map (kbd "M-j")      'ac-complete)
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)

(set-face-background 'ac-candidate-face "lightgray")
(set-face-underline 'ac-candidate-face "darkgray")
(set-face-background 'ac-selection-face "steelblue") ;;; 设置比上面截图中更好看的背景颜色


  (setq ac-auto-show-menu t
        ac-auto-start 3
        ac-dwim t
        ac-candidate-limit ac-menu-height
        ac-quick-help-delay .5
        ac-disable-faces nil)
(provide 'auto-complete-settings)
