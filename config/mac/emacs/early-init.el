;;; early-init.el --- Early config file before package and ui

;; before:
;;  - package init
;;  - ui init

;;; Commentary:

;;; Code:

;; 启动参数优化
(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'after-init-hook #'(lambda () (setq gc-cons-threshold 800000)))

;; UI 配置
(push '(scroll-bar-mode . nil) default-frame-alist)
(push '(tool-bar-mode . nil) default-frame-alist)
(push '(menu-bar-mode . nil) default-frame-alist)

(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(provide 'early-init)
;;; early-init.el ends here
