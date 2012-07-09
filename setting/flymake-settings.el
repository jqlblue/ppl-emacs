;; If you haven't added ~/.emacs.d/site-lisp to your load-path, do it with this.
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/")
;;
;; Require flymake.
(require 'flymake)
;; If you're a TTY emacs user, flymake-cursor is a must-have.
;; Grab it with apt-get or ports or whatever your OS package manager is.
(require 'flymake-cursor)

;; Static analysis can be slow, so only run flymake if I've not been typing for 5 seconds.
;; It will still run on save or hitting return.
(setq flymake-no-changes-timeout 5)
;; Disable in-place checking, and tell it to use ~/.emacs.d/tmp/ for the temp files.
 (setq temporary-file-directory "~/.emacs.d/tmp/")
 (setq flymake-run-in-place nil)
;; Only need these two if you plan to debug Flymake.
(setq flymake-log-file-name (concat temporary-file-directory "flymake.log"))
(setq flymake-log-level -1)
;; Tune how many checks can run in parallel, default of 4 should be fine.
(setq flymake-max-parallel-syntax-checks 1)

;; flymake-phpcs stuff
;; This gets supplied literally as the --standard arg to phpcs, read the
;; phpcs docs for details.
(setq flymake-phpcs-standard "Zend")
;; ;; If flymake_phpcs isn't in your $PATH you'll need to give the full path
;; here
(setq flymake-phpcs-command  "~/.emacs.d/site-lisp/emacs-flymake-phpcs/bin/flymake_phpcs")
(require 'flymake-phpcs)
