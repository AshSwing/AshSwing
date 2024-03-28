;;; coding.el


;; 自动补全 company
(use-package company
  :ensure t
  :init (global-company-mode)
  :config
  (setq company-minimum-prefix-length 1) ; 只需敲 1 个字母就开始进行自动补全
  (setq company-tooltip-align-annotations t)
  (setq company-idle-delay 0.0)
  (setq company-selection-wrap-around t))

(use-package company-box
  :ensure t
  :if window-system
  :hook (company-mode . company-box-mode))

;; 语法检查 flymake
(use-package flymake
  :hook (prog-mode . flymake-mode)
  :bind (("M-n" . #'flymake-goto-next-error)
	 ("M-p" . #'flymake-goto-prev-error)))

;; 语法树解析 treesit
(use-package treesit
  :when (and (fboundp 'treesit-available-p)
         (treesit-available-p))
  :config (setq treesit-font-lock-level 4)
  :init
  (setq treesit-language-source-alist ; 配置 treesit 解析规则集
    '((bash       . ("https://github.com/tree-sitter/tree-sitter-bash"))
      (c          . ("https://github.com/tree-sitter/tree-sitter-c"))
      (cpp        . ("https://github.com/tree-sitter/tree-sitter-cpp"))
      (css        . ("https://github.com/tree-sitter/tree-sitter-css"))
      (cmake      . ("https://github.com/uyha/tree-sitter-cmake"))
      (csharp     . ("https://github.com/tree-sitter/tree-sitter-c-sharp.git"))
      (dockerfile . ("https://github.com/camdencheek/tree-sitter-dockerfile"))
      (elisp      . ("https://github.com/Wilfred/tree-sitter-elisp"))
      (go         . ("https://github.com/tree-sitter/tree-sitter-go"))
      (gomod      . ("https://github.com/camdencheek/tree-sitter-go-mod.git"))
      (html       . ("https://github.com/tree-sitter/tree-sitter-html"))
      (java       . ("https://github.com/tree-sitter/tree-sitter-java.git"))
      (javascript . ("https://github.com/tree-sitter/tree-sitter-javascript"))
      (json       . ("https://github.com/tree-sitter/tree-sitter-json"))
      (lua        . ("https://github.com/Azganoth/tree-sitter-lua"))
      (make       . ("https://github.com/alemuller/tree-sitter-make"))
      (markdown   . ("https://github.com/MDeiml/tree-sitter-markdown" nil "tree-sitter-markdown/src"))
      (ocaml      . ("https://github.com/tree-sitter/tree-sitter-ocaml" nil "ocaml/src"))
      (org        . ("https://github.com/milisims/tree-sitter-org"))
      (python     . ("https://github.com/tree-sitter/tree-sitter-python"))
      (php        . ("https://github.com/tree-sitter/tree-sitter-php"))
      (typescript . ("https://github.com/tree-sitter/tree-sitter-typescript" nil "typescript/src"))
      (tsx        . ("https://github.com/tree-sitter/tree-sitter-typescript" nil "tsx/src"))
      (ruby       . ("https://github.com/tree-sitter/tree-sitter-ruby"))
      (rust       . ("https://github.com/tree-sitter/tree-sitter-rust"))
      (sql        . ("https://github.com/m-novikov/tree-sitter-sql"))
      (vue        . ("https://github.com/merico-dev/tree-sitter-vue"))
      (yaml       . ("https://github.com/ikatyang/tree-sitter-yaml"))
      (toml       . ("https://github.com/tree-sitter/tree-sitter-toml"))
      (zig        . ("https://github.com/GrayJack/tree-sitter-zig"))))
  (add-to-list 'major-mode-remap-alist '(sh-mode         . bash-ts-mode))  ; 配置模式替换 sh-mode → bash-ts-mode (treesit mode)
  (add-to-list 'major-mode-remap-alist '(c-mode          . c-ts-mode))
  (add-to-list 'major-mode-remap-alist '(c++-mode        . c++-ts-mode))
  (add-to-list 'major-mode-remap-alist '(c-or-c++-mode   . c-or-c++-ts-mode))
  (add-to-list 'major-mode-remap-alist '(css-mode        . css-ts-mode))
  (add-to-list 'major-mode-remap-alist '(js-mode         . js-ts-mode))
  (add-to-list 'major-mode-remap-alist '(java-mode       . java-ts-mode))
  (add-to-list 'major-mode-remap-alist '(js-json-mode    . json-ts-mode))
  (add-to-list 'major-mode-remap-alist '(makefile-mode   . cmake-ts-mode))
  (add-to-list 'major-mode-remap-alist '(python-mode     . python-ts-mode))
  (add-to-list 'major-mode-remap-alist '(ruby-mode       . ruby-ts-mode))
  (add-to-list 'major-mode-remap-alist '(conf-toml-mode  . toml-ts-mode))
  (add-to-list 'auto-mode-alist '("\\(?:Dockerfile\\(?:\\..*\\)?\\|\\.[Dd]ockerfile\\)\\'" . dockerfile-ts-mode)) ; 配置脚本识别
  (add-to-list 'auto-mode-alist '("\\.go\\'" . go-ts-mode))
  (add-to-list 'auto-mode-alist '("/go\\.mod\\'" . go-mod-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.y[a]?ml\\'" . yaml-ts-mode)))


;; LSP
(use-package eglot
  :hook (prog-mode . eglot-ensure)
  :bind ("C-c e f" . eglot-format))

;; (use-package eglot
;;   :bind ("C-c e f" . eglot-format)
;;   :init
;;   (advice-add 'eglot-code-action-organize-imports :before #'eglot-format-buffer)
;;   (add-hook 'eglot-managed-mode-hook (lambda () (add-hook 'before-save-hook #'eglot-format-buffer)))
;;   (add-hook 'prog-mode-hook
;; 	    (lambda () (unless (member major-mode '(emacs-lisp-mode))
;; 			 (eglot-ensure)))))



;; ;; Programming Setting

;; ; Python
;; ; ruff for formatter pipx install ruff-lsp
;; ; lsp-pyright for checking pipx install pyright
;; (with-eval-after-load 'eglot
;;   (add-to-list 'eglot-server-programs
;;                `(python-rs-mode . ,(eglot-alternatives
;;                                '(("ruff-lsp")
;;                                  ("pyright-langserver" "--stdio"))))))

(use-package flymake-ruff
  :ensure t
  :hook
    (eglot-managed-mode . flymake-ruff-load))

(defun my-filter-eglot-diagnostics (diags)
    "Drop Pyright 'variable not accessed' notes from DIAGS."
    (list (seq-remove (lambda (d)
                        (and (eq (flymake-diagnostic-type d) 'eglot-note)
                             (s-starts-with? "Pyright:" (flymake-diagnostic-text d))
                             (s-ends-with? "is not accessed" (flymake-diagnostic-text d))))
                      (car diags))))

(advice-add 'eglot--report-to-flymake :filter-args #'my-filter-eglot-diagnostics)

(provide 'coding)
;;; coding.el ends here
