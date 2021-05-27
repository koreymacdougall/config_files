;; link to notes file:
;; ~/config_files/emacs/initial_notes.org
;;{{{ Set up package and use-package

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Bootstrap 'use-package'
(eval-after-load 'gnutls
  '(add-to-list 'gnutls-trustfiles "/etc/ssl/cert.pem"))
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(require 'bind-key)
(setq use-package-always-ensure t)


;; (desktop-save-mode 1)
;; this will ensure that packages are always installed if not present
(require 'use-package)
(setq use-package-always-ensure t)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

;; make escape key escape commands anywhere
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(use-package projectile
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("s-p" . projectile-command-map)
              ("C-c p" . projectile-command-map)))

(use-package markdown-mode
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

;; set fill column / text width to 80
(setq-default fill-column 80)

;; Enable auto-fill minor mode in all text modes
(add-hook 'text-mode-hook 'turn-on-auto-fill)
;; Enable auto-fill-function 
(setq-default auto-fill-function 'do-auto-fill)

;; diplay line and column numbers
(column-number-mode)
(global-display-line-numbers-mode t)
;; disable column numbers for term and org modes
(dolist (mode '(org-mode-hook
		term-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; (set-cursor-color "dodgerblue")
(show-paren-mode 1)

;; (met-frame-parameter (selected-frame) 'alpha '(85 85))
;; (add-to-list 'default-frame-alist '(alpha 85 85))
;; (set-face-attribute 'default nil :background "black"
;;   :foreground "white" :font "Courier" :height 180)

;; Hide scroll/tool/menu bars
(menu-bar-mode -1)
(tool-bar-mode -1)
(toggle-scroll-bar -1)
;; Don't show splash screen on load
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

;; (set-face-attribute 'default nil :font "Fira Code Retina" :height 20)
(set-face-attribute 'default nil :height 140)

;;(setq package-enable-at-startup nil)
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

;; Org Mode Settings
;; set up an agenda keybind
(use-package org
  :config
  (setq org-ellipsis "  ▼"))

(global-set-key (kbd "C-c a") 'org-agenda)
;; enable org-bullet-mode, replace asterisks with bullets
(use-package org-bullets)
;;(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(add-hook 'org-mode-hook #'org-bullets-mode)

;; helm setup
;; (use-package helM
;;   :init
;;   (progn
;;     (require 'helm-config)
;;     ;; limit max number of matches displayed for speed
;;     (setq helm-candidate-number-limit 100)
;;     ;; replace locate with spotlight on Mac
;;     (setq helm-locate-command "locate"))
;;   :bind (("C-x f" . helm-for-files)))

;; intelligently wrap lines in all text modes, including ORG
(setq auto-fill-mode 1)
(add-hook 'text-mode-hook 'visual-line-mode)

;; specify my TODO.org file as file for the agenda
(setq org-agenda-files '("~/TODO.org"))
(setq org-log-done 'time)

;; Doom ModeLine
(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :config
  )

(use-package all-the-icons-gnus)
;; Powerline
;; (use-package powerline)
;;(use-package powerline)
;;(powerline-center-evil-theme)

;; (use-package spacemacs-common
;;     :ensure spacemacs-theme
;;     :config
;;     (load-theme 'spacemacs-dark t))
;; Doom Themes settings
(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-palenight t)
  
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;; (load-theme 'wombat)

;; Evil mode
    (setq evil-undo-system 'undo-fu)
    (use-package evil
      :init
      (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
      (setq evil-want-keybinding nil)
      :config
      (evil-mode 1))

    ;; undo-fu provides redo functionality
    (use-package undo-fu)

    ;; set undo/redo bindings
    (define-key evil-normal-state-map "u" 'undo-fu-only-undo)
    (define-key evil-normal-state-map "\C-r" 'undo-fu-only-redo)
    (setq initial-major-mode 'evil-mode)

    ;; make Ctrl-i jump forward in jump list
    (setq evil-want-C-i-jump 1)

    ;; enable gcc for comments
    (evil-commentary-mode)

    ;; remap colon/semi-colon, though I don't quite understand how
    (with-eval-after-load 'evil-maps
    (define-key evil-motion-state-map (kbd ":") 'evil-repeat-find-char)
    (define-key evil-motion-state-map (kbd ";") 'evil-ex))

    (use-package evil-surround
      :config
      (global-evil-surround-mode 1))

    (use-package evil-collection
      :after evil
      config
      (evil-collection-init))
      

(use-package lorem-ipsum)
(lorem-ipsum-use-default-bindings)
;; default bindings
;; C-c l p 	lorem-ipsum-insert-paragraphs
;; C-c l s 	lorem-ipsum-insert-sentences
;; C-c l l 	lorem-ipsum-insert-list

;;========================================
;; Deprecated variants
;;(define-key key-translation-map (kbd ";") (kbd ":"))
;;(define-key key-translation-map (kbd ":") (kbd ";"))
;; (require 'undo-fu)
;; (require 'evil)
;;========================================



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#292D3E" "#ff5370" "#c3e88d" "#ffcb6b" "#82aaff" "#c792ea" "#89DDFF" "#EEFFFF"])
 '(custom-safe-themes
   (quote
    ("c83c095dd01cde64b631fb0fe5980587deec3834dc55144a6e78ff91ebc80b19" "a3bdcbd7c991abd07e48ad32f71e6219d55694056c0c15b4144f370175273d16" "8f5a7a9a3c510ef9cbb88e600c0b4c53cdcdb502cfe3eb50040b7e13c6f4e78e" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(fci-rule-color "#676E95")
 '(jdee-db-active-breakpoint-face-colors (cons "#1c1f2b" "#c792ea"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#1c1f2b" "#c3e88d"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#1c1f2b" "#676E95"))
 '(objed-cursor-color "#ff5370")
 '(org-agenda-files (quote ("~/TODO.org")))
 '(package-selected-packages
   (quote
    (projectile evil-collection markdown-mode ivy-avy org-bullets doom-themes all-the-icons-ivy all-the-icons-gnus doom-modeline zenburn-theme lorem-ipsum ## powerline use-package evil-commentary undo-fu undo-tree evil notmuch)))
 '(pdf-view-midnight-colors (cons "#EEFFFF" "#292D3E"))
 '(rustic-ansi-faces
   ["#292D3E" "#ff5370" "#c3e88d" "#ffcb6b" "#82aaff" "#c792ea" "#89DDFF" "#EEFFFF"])
 '(vc-annotate-background "#292D3E")
 '(vc-annotate-color-map
   (list
    (cons 20 "#c3e88d")
    (cons 40 "#d7de81")
    (cons 60 "#ebd476")
    (cons 80 "#ffcb6b")
    (cons 100 "#fcb66b")
    (cons 120 "#f9a16b")
    (cons 140 "#f78c6c")
    (cons 160 "#e78e96")
    (cons 180 "#d690c0")
    (cons 200 "#c792ea")
    (cons 220 "#d97dc1")
    (cons 240 "#ec6898")
    (cons 260 "#ff5370")
    (cons 280 "#d95979")
    (cons 300 "#b36082")
    (cons 320 "#8d678b")
    (cons 340 "#676E95")
    (cons 360 "#676E95")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

