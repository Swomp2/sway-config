;; Requires
(require 'tree-sitter)
(require 'tree-sitter-langs)
(require 'package)

;; MELPA
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

;; Simple customizations
(global-display-line-numbers-mode)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(set-frame-font "Source Code Pro-10")

;; Nord theme
(load-theme 'nord t)

;; Brackets autocomplete
(electric-pair-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(lsp-treemacs lsp-ui company flycheck lsp-mode nord-theme ##)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
