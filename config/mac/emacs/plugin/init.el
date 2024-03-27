;;; plugin/init.el --- Plugin init

;; plugin config path
(add-to-list 'load-path (concat user-emacs-directory "plugin"))

;; melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; loading
(require 'utility)
(require 'coding)