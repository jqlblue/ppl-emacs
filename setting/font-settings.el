
;;------------------------------------------------------------------------------
;; 字体设置
;; 
;; 英文字体使用 consolas, 中文字体使用 微软雅黑(msyh).
;;------------------------------------------------------------------------------

;;Emacs 会优先选用 Consolas + “雅黑”的组合。如果“雅黑”没有装的话，就
;;使用“文泉驿等宽微米黑”，依此类推。这份字体配置不用改动就能在不同的操作系统字体
;;环境下面使用，相信应该没有其它编辑器有这么变态的后备字体列表设置了吧。


(defun qiang-font-existsp (font)
(if (null (x-list-fonts font))
nil t))


(defvar font-list '("Microsoft Yahei" "文泉驿等宽微米黑" "黑体" "新宋体" "宋体"))
(require 'cl) ;; find-if is in common list package
(find-if #'qiang-font-existsp font-list)

(defun qiang-make-font-string (font-name font-size)
(if (and (stringp font-size)
(equal ":" (string (elt font-size 0))))
(format "%s%s" font-name font-size)
(format "%s %s" font-name font-size)))

(defun qiang-set-font (english-fonts
english-font-size
chinese-fonts
&optional chinese-font-size)
"english-font-size could be set to \":pixelsize=18\" or a integer.
If set/leave chinese-font-size to nil, it will follow english-font-size"
(require 'cl) ; for find if
(let ((en-font (qiang-make-font-string
(find-if #'qiang-font-existsp english-fonts)
english-font-size))
(zh-font (font-spec :family (find-if #'qiang-font-existsp chinese-fonts)
:size chinese-font-size)))


;; Set the default English font
;;
;; The following 2 method cannot make the font settig work in new frames.
;; (set-default-font "Consolas:pixelsize=18")
;; (add-to-list 'default-frame-alist '(font . "Consolas:pixelsize=18"))
;; We have to use set-face-attribute
(message "Set English Font to %s" en-font)
(set-face-attribute
'default nil :font en-font)


;; Set Chinese font
;; Do not use 'unicode charset, it will cause the english font setting invalid
(message "Set Chinese Font to %s" zh-font)
(dolist (charset '(kana han symbol cjk-misc bopomofo))
(set-fontset-font (frame-parameter nil 'font)
charset
zh-font))))

(qiang-set-font
'("Consolas" "Courier New" "Monaco" "DejaVu Sans Mono" "Monospace") ":pixelsize=15"
'("Microsoft Yahei" "文泉驿等宽微米黑" "黑体" "新宋体" "宋体"))


;;------------------------------------------------------------------------------
;; end of font setting
;;------------------------------------------------------------------------------
