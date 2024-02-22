;; this dissables the initial startup screen
;; (setq inhibit-startup-screen t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(set-frame-font "Comic Mono 18" nil t)
(setq backup-directory-alist '(("." . "~/.cache/emacs/"))) ;; save backup files in the cache directory, instead of in the same dir as the file being edited

(ido-mode 1)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(unless (display-graphic-p)
  (xterm-mouse-mode 1))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(catppuccin))
 '(custom-safe-themes
   '("80214de566132bf2c844b9dee3ec0599f65c5a1f2d6ff21a2c8309e6e70f9242" default))
 '(package-selected-packages
   '(go-mode haskell-mode tree-sitter tree-sitter-langs catppuccin-theme smex)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
