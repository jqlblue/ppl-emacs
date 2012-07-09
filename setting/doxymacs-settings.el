(require 'doxymacs)

(add-hook 'c-mode-common-hook 'doxymacs-mode)
(add-hook 'php-mode-common-hook 'doxymacs-mode)

(defconst doxymacs-php-file-comment-template
 '(
   "/**" > n
   "*" (if (buffer-file-name)
   " "   (file-name-nondirectory (buffer-file-name))
     "") > n
   "*" " @desc"> n
   "*" > n
   "*" " @package open 360"> n
   "*" " @version $Id$"> n
   "*" " @copyright 2005-" (format-time-string "%Y" (current-time)) " 360.CN All Rights Reserved"> n
   "*" " @author gaoyuan@360.cn"> n
 "**/" > n)'
 "Default php-style template for file documentation.")

(defconst doxymacs-php-function-comment-template
 '((let ((next-func (doxymacs-find-next-func)))
     (if next-func
	 (list
	  'l
	  "/** " '> 'n
	  " * " 'p '> 'n
	  (doxymacs-parm-tempo-element (cdr (assoc 'args next-func)))
	  (unless
	      (string-match "^[ \t\n]*void[ \t\n]*$"
			    (cdr (assoc 'return next-func)))
	    '(l " * " > n " * @return " (p "Returns: ") > n))
	  " */" '>)
       (progn
	 (error "Can't find next function declaration.")
	 nil))))
 "Default php-style template for function documentation.")

(defconst doxymacs-php-group-begin-comment-template
  ;; The leading space is a hack to get the indentation to work properly
  '(" /*" > n)
  "Default php-style template for beginning-of-group comment.")

(defconst doxymacs-php-group-end-comment-template
  ;; The leading space is a hack to get the indentation to work properly
  '(n " */" >)
  "Default php-style template for end-of-group comment.")

(defconst doxymacs-php-blank-multiline-comment-template
 '("/**" > n "* " p > n "* " > n "*/")
 "Default php-style template for a blank multiline doxygen comment.")

(defconst doxymacs-php-blank-singleline-comment-template
 '("// " > p)
 "Default php-style template for a blank single line doxygen comment.")
