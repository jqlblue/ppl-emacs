;; -*- Emacs-Lisp -*-

(require 'auto-complete-config)
(setq ac-dictionary-files (list "~/.emacs.d/elpa/auto-complete-20130209.651/dict"))
(ac-config-default)
(define-key ac-complete-mode-map (kbd "<return>") 'ac-complete)
(define-key ac-complete-mode-map (kbd "M-j")      'ac-complete)
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)

(set-face-background 'ac-candidate-face "lightgray")
(set-face-underline 'ac-candidate-face "darkgray")
(set-face-background 'ac-selection-face "steelblue")

(setq ac-auto-show-menu t
        ac-auto-start 3
        ac-dwim t
        ac-candidate-limit ac-menu-height
        ac-quick-help-delay .5
        ac-disable-faces nil)
(provide 'auto-complete-settings)

;; hack to fix ac-sources after pycomplete.el breaks it
(add-hook 'python-mode-hook
          '(lambda ()
             (setq ac-sources '(ac-source-pycomplete
                                ac-source-abbrev
                                ac-source-dictionary
                                ac-source-words-in-same-mode-buffers))))

(provide 'auto-complete-settings)
