;; this dissables the initial startup screen
;; (setq inhibit-startup-screen t)

(menu-bar-mode   -1)
(tool-bar-mode   -1)
(scroll-bar-mode -1)
(set-frame-font "Comic Mono 16" nil t)
(setq backup-directory-alist '(("." . "~/.cache/emacs/"))) ;; save backup files in the cache directory, instead of in the same dir as the file being edited

;; Refreshes files from disk if they change on disk, but not in emacs
(global-auto-revert-mode t)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

(ido-mode 1)

;; Set a 80 column rule for programming modes
(setq display-fill-column-indicator-column 80)
(add-hook 'prog-mode-hook 'display-fill-column-indicator-mode)


(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; If there are no archived package contents, refresh them
(when (not package-archive-contents)
  (package-refresh-contents))

(unless (display-graphic-p)
  (xterm-mouse-mode 1))

;; Makes the background transparent in terminal
(defun on-after-init ()
  (unless (display-graphic-p (selected-frame))
    (set-face-background 'default "unspecified-bg" (selected-frame))))

(add-hook 'window-setup-hook 'on-after-init)

;; setup so that use-package ensure is always true by default
;; you can still disable it by setting ensure to nil for specific packages
(require 'use-package-ensure)
(setq use-package-always-ensure t)

;;

(use-package catppuccin-theme
  :config (setq catppuccin-flavor 'macchiato)) ;; or 'latte, 'frappe, or 'mocha

(use-package auto-dark
  :config
  (setq auto-dark-dark-theme 'catppuccin)
  (setq auto-dark-light-theme 'catppuccin)

  (add-hook 'auto-dark-dark-mode-hook
	    (lambda ()
	      (setq catppuccin-flavor 'macchiato)
	      (catppuccin-reload)))

  (add-hook 'auto-dark-light-mode-hook
	    (lambda ()
	      (setq catppuccin-flavor 'frappe)
	      (catppuccin-reload)))
  (auto-dark-mode t))

(use-package undo-tree
  :init (global-undo-tree-mode)
  :config (setq undo-tree-visualizer-diff t
		undo-tree-visualizer-timestamps t
		undo-tree-auto-save-history t))

(use-package smex
  :bind (("M-x" . 'smex)
	 ("M-X" . 'smex-major-mode-commands)))

(use-package recentf
  :commands (recentf-open-files)
  :init (recentf-mode 1)
  :bind (("C-x C-r" . 'recentf-open-files)))

(use-package which-key
	     :init (which-key-mode)
	     :config (setq which-key-side-window-location 'bottom
			   which-key-sort-order #'which-key-key-order-alpha
			   which-key-sort-uppercase-first nil
			   which-key-add-column-padding 1
			   which-key-max-display-columns nil
			   which-key-idle-delay 0.8
			   which-key-max-description-length 25))

(use-package magit
  :bind (("C-c g g" . 'magit)))

(use-package company
  :hook (after-init . global-company-mode)
  :config
  (setq company-tooltip-align-annotations t
        company-minimum-prefix-length 1
        company-idle-delay 1.0))

(use-package yasnippet-snippets)

(use-package yasnippet
  :commands (yas-global-mode yas-reload-all)
  :config (progn (yas-global-mode t)
		 (yas-reload-all)))

;; Load environment variables from shell, I'm not sure if this is actually a good idea

(use-package exec-path-from-shell
  :init (exec-path-from-shell-initialize))

;; lsp

;; sets the completion style so that it works kinda like fzf
(setq completion-styles '(flex basic partial-completion emacs22))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init (setq lsp-keymap-prefix "C-c l")
  :hook ((lsp-mode . lsp-enable-which-key-integration))
  :config (setq lsp-headerline-breadcrumb-enable nil))

(use-package flycheck
  :init (global-flycheck-mode))

;; dart
(use-package dart-mode)
(use-package flutter)

(use-package lsp-dart
  :hook (dart-mode . lsp-deferred)
  :config (setq lsp-dart-dap-flutter-hot-reload-on-save t))

;; python
(use-package poetry)

(use-package lsp-pyright
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp-deferred))))


;; key bindings
(global-set-key (kbd "C-x C-b") 'ibuffer)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(catppuccin))
 '(custom-safe-themes
   '("d77d6ba33442dd3121b44e20af28f1fae8eeda413b2c3d3b9f1315fbda021992" "80214de566132bf2c844b9dee3ec0599f65c5a1f2d6ff21a2c8309e6e70f9242" default))
 '(package-selected-packages
   '(undo-tree yasnippet-snippets exec-path-from-shell lsp-dart flutter dart-mode magit which-key catppuccin-theme smex)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
