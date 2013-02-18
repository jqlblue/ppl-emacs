;;
;; @file        init.el
;; @brief
;; @author      jqlblue(gaoyuan.blue@gmail.com)
;; @date        2013-02-14
;;
;; ------------------------------------------------------------------------------
;;
;; auto load path below
(defconst my-emacs-path              "~/.emacs.d/" "my emacs config file path")
(defconst my-emacs-my-lisps-path     (concat my-emacs-path "my-lisp/") "my lisp package")
(defconst my-emacs-vendor-lisps-path (concat my-emacs-path "site-lisp/") "the vendor lisp package")
(defconst my-emacs-settings-path     (concat my-emacs-path "setting/") "my self emacs setting")

;; add all subdir of 'my-emacs-path' to 'load-path'
(load (concat my-emacs-my-lisps-path "my-subdirs"))
(my-add-subdirs-to-load-path my-emacs-vendor-lisps-path)
(my-add-subdirs-to-load-path my-emacs-my-lisps-path)
(my-add-subdirs-to-load-path my-emacs-settings-path)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(starter-kit
                      starter-kit-bindings
                      starter-kit-eshell
                      auto-complete
                      color-theme
                      color-theme-solarized
                      ido-better-flex
                      flymake
                      flymake-cursor
                      flymake-php
                      flymake-phpcs
                      flymake-python-pyflakes
                      flyphpcs
                      php-mode
                      ac-slime
                      projectile
                      undo-tree)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; global-settings
(require 'global-settings)

;; generic-copy
;(require 'generic-copy)

;; autocomplete
(require 'auto-complete-settings)

;; python
(require 'python-settings)

;; php
(require 'php-settings)

;;font settings
(load "font-settings")

;; load flymake-settings
(load "flymake-settings")

;; project
(require 'projectile)
;;(projectile-global-mode) ;; to enable in all buffers
(add-hook 'php-mode-hook #'(lambda () (projectile-mode)))
(setq projectile-enable-caching t)

;; load slime
(load "slime-settings")

;; svn
(require 'psvn)

;; git
(require 'magit)

;; tramp
(require 'tramp-settings)
