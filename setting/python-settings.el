(defun my-python-mode()
(setenv "PYTHONPATH" "/usr/lib/python2.7/site-packages")
(require 'ipython)
(setq py-python-command-args '( "-colors" "Linux"))

(defadvice py-execute-buffer (around python-keep-focus activate)
  "return focus to python code buffer"
  (save-excursion ad-do-it))

(setenv "PYMACS_PYTHON" "python2.7")
(require 'pymacs)

(pymacs-load "ropemacs" "rope-")

(when (load "flymake" t)  
         (defun flymake-pyflakes-init ()  
           (let* ((temp-file (flymake-init-create-temp-buffer-copy  
                              'flymake-create-temp-inplace))  
              (local-file (file-relative-name  
                           temp-file  
                           (file-name-directory buffer-file-name))))  
             (list "pyflakes" (list local-file))))  

         (add-to-list 'flymake-allowed-file-name-masks  
                  '("\\.py\\'" flymake-pyflakes-init)))  

   (add-hook 'find-file-hook 'flymake-find-file-hook)

(when (load "flymake" )
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "pyflakes" (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pyflakes-init)))

(add-hook 'find-file-hook 'flymake-find-file-hook)
(load-library "flymake-cursor")  ;在minibuffer显示错误信息
(global-set-key (kbd "<f11>") 'flymake-start-syntax-check)
(global-set-key (kbd "<s-up>") 'flymake-goto-prev-error)
(global-set-key (kbd "<s-down>") 'flymake-goto-next-error)

)
(add-hook 'python-mode-hook (lambda () (flymake-mode 1)))
(add-hook 'python-mode-hook 'my-python-mode)

(provide 'python-settings)
