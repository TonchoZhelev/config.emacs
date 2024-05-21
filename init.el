;; this dissables the initial startup screen
;; (setq inhibit-startup-screen t)

(menu-bar-mode   -1)
(tool-bar-mode   -1)
(scroll-bar-mode -1)
(set-frame-font "Comic Mono 16" nil t)
(setq backup-directory-alist '(("." . "~/.cache/emacs/"))) ;; save backup files in the cache directory, instead of in the same dir as the file being edited

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

(ido-mode 1)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; If there are no archived package contents, refresh them
(when (not package-archive-contents)
  (package-refresh-contents))

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

(unless (display-graphic-p)
  (xterm-mouse-mode 1))

(setq catppuccin-flavor 'macchiato) ;; or 'latte, 'frappe, or 'mocha

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
(use-package which-key
	     :init (which-key-mode)
	     :config (setq which-key-side-window-location 'bottom
			   which-key-sort-order #'which-key-key-order-alpha
			   which-key-sort-uppercase-first nil
			   which-key-add-column-padding 1
			   which-key-max-display-columns nil
			   which-key-min-display-lines 6
			   which-key-side-window-slot -10
			   which-key-side-window-max-height 0.25
			   which-key-idle-delay 0.8
			   which-key-max-description-length 25
			   which-key-allow-imprecise-window-fit t))

(use-package magit)

;; lsp
(use-package lsp-mode
  :init (setq lsp-keymap-prefix "C-c l")
  :hook ((lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

(use-package lsp-treemacs)
(use-package lsp-ui :commands lsp-ui-mode)

;; dart
(use-package dart-mode)
(use-package flutter)

(use-package lsp-dart
  :hook (dart-mode . lsp-deferred)
  :config (setq lsp-dart-sdk-dir "~/flutter/current/bin/cache/dart-sdk/"))

;; python
(use-package elpy
  :hook (python-mode . lsp-deferred)
  :init (elpy-enable))

(use-package py-autopep8)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(catppuccin))
 '(custom-safe-themes
   '("d77d6ba33442dd3121b44e20af28f1fae8eeda413b2c3d3b9f1315fbda021992" "80214de566132bf2c844b9dee3ec0599f65c5a1f2d6ff21a2c8309e6e70f9242" default))
 '(package-selected-packages
   '(elpy company lsp-ui lsp-dart flutter dart-mode magit which-key catppuccin-theme smex)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
