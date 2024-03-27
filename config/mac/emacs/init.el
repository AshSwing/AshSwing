;;; init.el


;; Global Setting

(setq-default
 make-backup-files nil              ; 禁用备份
 confirm-kill-emacs #'yes-or-no-p   ; 关闭时询问
 inhibit-startup-message t          ; 关闭欢迎界面
 )

(electric-pair-mode t)              ; 自动补全括号
(column-number-mode t)              ; Mode line 显示行号
(global-auto-revert-mode t)         ; 及时刷新 Buffer
(delete-selection-mode t)           ; 插入选区
(global-display-line-numbers-mode 1); 显示行号
(tool-bar-mode -1)                  ; 关闭 Tool bar
(when (display-graphic-p)           ; 关闭滚动条
  (toggle-scroll-bar -1))

;; Global Setting for coding

(add-hook 'prog-mode-hook #'show-paren-mode)                              ; 括号高亮
(add-hook 'prog-mode-hook (lambda () (setq-local column-number-mode t)))  ; 列号显示
(add-hook 'prog-mode-hook #'hs-minor-mode)                                ; 代码折叠
(add-hook 'prog-mode-hook #'which-function-mode)                          ; Mode line 显示函数名


(add-to-list 'load-path (concat user-emacs-directory "config"))

(provide 'init)
