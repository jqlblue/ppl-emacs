;; 设置yasnippet
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(setq doxymacs-doxygen-style "php")

(defun php-doc-paragraph-boundaries ()
  (setq paragraph-separate "^[ \t]*\\(\\(/[/\\*]+\\)\\|\\(\\*+/\\)\\|\\(\\*?\\)\\|\\(\\*?[ \t]*@[[:alpha:]]+\\([ \t]+.*\\)?\\)\\)[ \t]*$")
  (setq paragraph-start (symbol-value 'paragraph-separate)))

(add-hook 'php-mode-user-hook 'php-doc-paragraph-boundaries)

(defun my-php-mode()
  ;; 设置php-mode
  (require 'php-mode)

  (add-to-list 'auto-mode-alist
			   '("\\.php[34]?\\'\\|\\.phtml\\'" . php-mode))
  (setq php-completion-file "~/.emacs.d/script/php-doc/php-completion-file")
  (defun php-run ()
	(interactive)
	(shell-command
	 (concat "php -q \"" (buffer-file-name) "\"")))
  (defun php-check () 
	(interactive) 
	(let ((compilation-error-regexp-alist '(php)) 
		  (compilation-error-regexp-alist-alist ())) 
	  (pushnew '(php "\\(syntax error.*\\) in \\(.*\\) on line \\([0-9]+\\)$" 2 3 nil nil 1) 
			   compilation-error-regexp-alist-alist) 
	  (compile (concat "php -l -f \"" (buffer-file-name) "\"")))) 
  (defun php-check-style () 
	"Performs a PHP code sniffer check on the current file." 
	(interactive) 
	(let ((compilation-error-regexp-alist '(gnu))) 
	  ;; (compile (format "phpcs --standard=PEAR --report=emacs \"%s\"" 
	  (compile (format "phpcs --standard=ZEND \"%s\"" 
					   (buffer-file-name))))) 

  (define-key php-mode-map
	[menu-bar php php-run]
	'("Run PHP" . php-run)
	)
  (define-key php-mode-map
	[menu-bar php php-check]
	'("PHP Check" . php-check)
	)
  (define-key php-mode-map
	[menu-bar php php-check-style]
	'("PHP Check Style" . php-check-style)
	)

  ;; 设置php-tokens
  (require 'php-tokens)

  (setq php-mode-force-pear 1)
  (setq imenu-auto-rescan 1)
  
  (setq-default tab-width 4)
  (setq-default indent-tabs-mode nil)  ;用空格代替tab
  
  ;; 将回车代替C-j的功能，换行的同时对齐
  (define-key c-mode-map [return] 'newline-and-indent)

  (define-key php-mode-map [(control tab)] 'php-complete-function)
  (define-key php-mode-map [(control c) (r)] 'php-run)
  (define-key php-mode-map [(control c) (c)] 'php-check)
  (define-key php-mode-map [(control c) (l)] 'php-check-style)

  (define-key php-mode-map [(control c) (t)] 'php-tokens)

  (interactive)
  (setq fill-column 78)
  ;; 设置php程序的对齐风格
  (c-set-style "K&R")
  ;; 自动模式，在此种模式下当你键入{时，会自动根据你设置的对齐风格对齐
  (c-toggle-auto-state)
  ;; 此模式下，当按Backspace时会删除最多的空格
  (c-toggle-hungry-state)
  ;; TAB键的宽度设置为4
  (setq c-basic-offset 4)
  ;; 在菜单中加入当前Buffer的函数索引
  (imenu-add-menubar-index)
  ;; 在状态条上显示当前光标在哪个函数体内部
  (which-function-mode)
  )

(add-hook 'php-mode-hook
          '(lambda () (define-abbrev php-mode-abbrev-table "ex" "extends")))
(add-hook 'php-mode-hook (lambda () (flymake-mode 1)))
(add-hook 'php-mode-hook (lambda () (hs-minor-mode 1)))
(add-hook 'php-mode-hook 'my-php-mode)
;;-----------------------------------

(provide 'php-settings)
