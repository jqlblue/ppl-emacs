;;;
;;; 全局通用设置
;;;

(tool-bar-mode -1)
(menu-bar-mode -1)
(set-scroll-bar-mode nil);;隐藏滚动条
(mouse-wheel-mode 1) ;响应鼠标滚轮
(global-linum-mode t)

;最大化
(defun my-maximized ()
  (interactive)
    (x-send-client-message nil 0 nil "_NET_WM_STATE" 32 
      '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
    (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
      '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
)
(my-maximized)

(global-set-key [f12] 'my-bars)
(defun my-bars()
  (interactive)
  (menu-bar-mode)
  (tool-bar-mode)
  )

(global-set-key [f11] 'my-fullscreen)					;全屏
(defun my-fullscreen ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_FULLSCREEN" 0)
   )
  )
;透明性窗口
(global-set-key [f8] 'loop-alpha)  ;;注意这行中的F8 , 可以改成你想要的按键
(setq alpha-list '((80 55) (100 100)))
(defun loop-alpha ()
  (interactive)
  (let ((h (car alpha-list)))                
    ((lambda (a ab)
       (set-frame-parameter (selected-frame) 'alpha (list a ab))
       (add-to-list 'default-frame-alist (cons 'alpha (list a ab)))
       ) (car h) (car (cdr h)))
    (setq alpha-list (cdr (append alpha-list (list h))))
    )
  )

;; 瞬间变成4个窗口,并且4个窗口显示不同的buffer
(defun split-window-to-four()
  "split current frame to four"
  (interactive)
  (progn
    (split-window-horizontally)
    (set-window-buffer (next-window) (other-buffer))
    (split-window-vertically)
    (set-window-buffer (next-window) (other-buffer))
    (other-window 2)
    (split-window-vertically)
    (set-window-buffer (next-window) (other-buffer))
    (other-window -2)))

(global-set-key (kbd "C-x 4") 'split-window-to-four)


;  配色方案
(require 'color-theme)
(color-theme-deep-blue)

(global-font-lock-mode t);; 语法高亮
(setq frame-title-format "emacs@%b %f");; 设置 emacs 的标题

(auto-image-file-mode);; 可以显示图片
;;所有的问题用y/n方式，不用yes/no方式。有点懒，只想输入一个字母
(fset 'yes-or-no-p 'y-or-n-p) 
;;当指针到一个括号时，自动显示所匹配的另一个括号
(show-paren-mode 1) 
;;在文档最后自动插入空白一行，好像某些系统配置文件是需要这样的
(setq require-final-newline t) 
(setq track-eol t) 
(setq default-indicate-empty-lines 't)     ;显示文件末尾的空行
(setq x-select-enable-clipboard t) ;支持emacs和外部程序的粘贴 

;;;; 显示行号
(setq column-number-mode t)
(setq line-number-mode t)
;;关闭启动时的开机画面
(setq inhibit-startup-message t)

;;;; 显示时间
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(display-time)

;; stop creating those backup~ files 
(setq make-backup-files nil)

;; stop creating those #auto-save# files
(setq auto-save-default nil) 

;; none auto-save
(setq auto-save-mode nil)

; use whitespace replace tab
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;; delete shell buffer when exit shell
(add-hook 'shell-mode-hook 'wcy-shell-mode-hook-func)
(defun wcy-shell-mode-hook-func  ()
  (set-process-sentinel (get-buffer-process (current-buffer))
                            #'wcy-shell-mode-kill-buffer-on-exit)
      )
(defun wcy-shell-mode-kill-buffer-on-exit (process state)
  (message "%s" state)
  (if (or
       (string-match "exited abnormally with code.*" state)
       (string-match "finished" state))
      (kill-buffer (current-buffer))))

;;------------设置(utf-8)模式------------
(set-keyboard-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-selection-coding-system 'utf-8)
(modify-coding-system-alist 'process "*" 'utf-8)
(setq default-process-coding-system '(utf-8 . utf-8))
(setq-default pathname-coding-system 'utf-8)
(set-file-name-coding-system 'utf-8)
(setq ansi-color-for-comint-mode t)

(provide 'global-settings)
