
;; Для ускорения загрузки Emacs
(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'emacs-startup-hook
	  (lambda ()
	    (setq gc-cons-threshold (expt 2 23))))

;; Простая настройка интерфейса
(setq inhibit-startup-message t)
(global-display-line-numbers-mode)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(set-frame-font "Source Code Pro-10")

;; Красивый статусбар
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-support-imenu t
	doom-modeline-height 25
	doom-modeline-bar-width 0
	doom-modeline-hud t
	doom-modeline-window-width-limit 85
	doom-modeline-project-detection 'auto
	doom-modeline-buffer-file-name-style 'auto
	doom-modeline-icon t
	doom-modeline-major-mode-icon t
	doom-modeline-major-mode-color-icon t
	doom-modeline-time-icon t
	doom-modeline-unicode-fallback nil
	doom-modeline-buffer-name t
	doom-modeline-highlight-modified-buffer-name t
	doom-modeline-minor-modes nil
	doom-modeline-enable-word-count nil
	doom-modeline-buffer-encoding t
	doom-modeline-vcs-max-length 12
	doom-modeline-workspace-name t
	doom-modeline-persp-name t
	doom-modeline-display-default-persp-name nil
	doom-modeline-persp-icon t
	doom-modeline-lsp t
	doom-modeline-modal t
	doom-modeline-modal-icon t
	doom-modeline-gnus t
	doom-modeline-gnus-timer 2
	doom-modeline-gnus-excluded-groups '("dummy.group")
	doom-modeline-time t
	doom-modeline-env-enable-python t
	doom-modeline-env-enable-c++ t
	doom-modeline-env-enable-c t
	doom-modeline-env-enable-rust t
	doom-modeline-env-load-string "..."
	doom-modeline-before-update-env-hook nil
	doom-modeline-after-update-env-hook nil))

;; Отключение автосохранения и backup файлов
(setq make-backup-files nil)
(setq auto-save-default nil)

;; Красивые иконки
(use-package all-the-icons
  :ensure t)

;; Добавление репозитория MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

;; Neotree
(use-package neotree
  :bind (("M-o" . 'neotree-toggle))
  :config
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow)
	neo-smart-open t
	projectile-switch-project-action 'neotree-projectile-action
	))

;; Установка use-package, если не установлен
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure 't)

;; Стартовый экран
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*"))
	dashboard-banner-logo-title "Добро пожаловать домой :3"
	dashboard-startup-banner 'logo
	dashboard-center-content t
	dashboard-projects-backend 'projectile
	dashboard-items '((recents  . 5)
			  (projects . 5))
	dashboard-item-names '(("Recent Files:" . "Последние файлы:")
			       ("Projects:" . "Проекты:"))
	dashboard-set-heading-icons t
	dashboard-set-file-icons t
	dashboard-set-navigator t
	dashboard-set-footer nil
	dashboard-set-init-info nil))

;; Удобные отступы
(global-aggressive-indent-mode 1)
(add-to-list
 'aggressive-indent-dont-indent-if
 '(and (derived-mode-p 'c++-mode)
       (null (string-match "\\([;{}]\\|\\b\\(if\\|for\\|while\\)\\b\\)"
			   (thing-at-point 'line)))))

;; "Радужные скобки"
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; Автозавершение скобок
(electric-pair-mode 1)

;; Проверка синтаксиса flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Языковой сервер
(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook
  (lsp-mode . lsp-enable-which-key-integration)
  :commands (lsp lsp-deferred)
  :config
  (setq lsp-auto-configure nil
	lsp-enable-file-watchers nil
	lsp-prefer-capf t
	lsp-auto-guess-root t
	lsp-keep-workspace-alive nil))

(use-package ccls
  :hook ((c-mode c++-mode objc-mode cuda-mode) .
	 (lambda () (require 'ccls) (lsp))))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-sideline-enable            t
	lsp-ui-sideline-show-diagnostics  t
	lsp-ui-sideline-show-hover        nil
	lsp-ui-sideline-update-mode       'line
	lsp-ui-sideline-show-code-actions t
	lsp-ui-sideline-delay             0.05
	lsp-ui-doc-enable                 nil
	lsp-ui-doc-include-signature      t
	lsp-ui-doc-border                 (face-foreground 'default)
	))

(use-package helm-lsp :commands helm-lsp-workspace-symbol)


;; Помощь с командами в буффере
(use-package helm
  :config
  (setq completion-styles '(flex))
  :init
  (helm-mode 1)
  :bind
  (("M-x"     . helm-M-x)
   ("C-x C-f" . helm-find-files)
   ("C-x b"   . helm-mini)
   ("C-x C-r" . helm-recentf)
   ("C-c i"   . helm-imenu)
   ("M-y"     . helm-show-kill-ring)
   :map helm-map
   ("C-z"     . helm-select-action)
   ("<tab>"   . helm-execute-persistent-action)))

;; Помощь с сочетаниями клавиш
(use-package which-key
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.5
	which-key-idle-secondary-delay 0.5)
  (which-key-setup-side-window-bottom))

;; Автозавершение
(use-package company
  :after lsp-mode
  :hook (prog-mode . company-mode)
  :config
  (setq company-minimum-prefix-lenght 1
	company-idle-delay 0.0
	company-selection-wrap-around t))
(global-company-mode)

;; Тема Nord :3
(use-package nord-theme
  :config (load-theme 'nord t))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(monokai-pro-theme dracula-theme ccls helm-flycheck neotree helm-tree-sitter doom-modeline all-the-icons-completion winum aggressive-completion aggressive-indent rainbow-delimiters helm-projectile projectile all-the-icons dashboard company-ctags lsp-treemacs helm-lsp ls-ui lsp-ui flycheck company helm-fish-completion which-key ## helm use-package tree-sitter-langs nord-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
