;; Set up tramp-mode

(add-to-list 'load-path "~/.emacs.d/site-lisp/tramp-2.2.6/share/emacs/site-lisp/")
(add-to-list 'Info-default-directory-list "~/.emacs.d/site-lisp/tramp-2.2.6/share/info/")
(require 'tramp)
(setq tramp-default-user "gaoyuan")
(setq tramp-default-method "ssh")
(setq auth-source-debug t)
(add-to-list 'tramp-default-proxies-alist
                          '(nil "\\`user\\'" "/ssh:%h:"))
(setq auth-sources '((:source "~/.emacs.d/script/authinfo" :host t :protocol t)))
(provide 'tramp-settings)
