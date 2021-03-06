;; -*- mode: Lisp; fill-column: 75; comment-column: 50; -*-
;;; emacs -- Emacs init file for Dean
;;; Commentary:
;; My Emacs file for doing stuff

;;; Code:

;; Set encoding
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Default tabs and spacing
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80))
(setq-default py-indent-offset 4)

;; Keyboard changes
(setq mac-command-modifier 'super)
(setq mac-option-modifier 'meta)
(setq mac-option-key-is-meta t)
(global-set-key (kbd "s-v") 'yank)
(global-set-key (kbd "s-c") 'kill-ring-save)

;; Some display settings for line numbers and the menubar
;;(global-linum-mode 1)
(setq line-number-mode t)
(setq column-number-mode t)
;; (setq linum-format "%5d ")
;;(global-visual-line-mode t)
(menu-bar-mode -1)
(tool-bar-mode -1)

;; Don't display the 'Welcome to GNU Emacs' buffer on startup
(setq inhibit-startup-message t)

;; I like backups because I don't use version control for everything
;; Put everything in a saves directory so backups are scattered out everywhere
(setq backup-directory-alist `((".*" . "~/.saves")))
(setq auto-save-file-name-transforms `((".*" "~/.saves" t)))
(setq backup-by-copying t)
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

;; Set auto revert mode 
(global-auto-revert-mode 1)

(setq ns-use-srgb-colorspace t)

;; Reopen files with sudo if they are read-only
(defadvice find-file (after find-file-sudo activate)
  "Find file as root if necessary."
  (unless (and buffer-file-name
               (file-writable-p buffer-file-name))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

;; Set up package repos
(require 'package)
(setq package-archives
      '(("gnu"          . "https://elpa.gnu.org/packages/")
        ("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")
        ("melpa"        . "https://melpa.org/packages/")
        ("org"          . "http://orgmode.org/elpa/"))
      package-archive-priorities
      '(("melpa-stable" . 10)
        ("org"          . 8)
        ("gnu"          . 5)
        ("melpa"        . 0)))
(package-initialize)

(setq package-list '(ag
                     all-the-icons
                     color-theme-sanityinc-tomorrow
                     company
                     csv-mode
                     dockerfile-mode
                     elpy
                     embrace
                     exec-path-from-shell
                     expand-region
                     helm
                     helm-ag
                     helm-projectile
                     jinja2-mode
                     json-mode
                     json-snatcher
                     kubernetes
                     magit
                     markdown-mode
                     neotree
                     org-plus-contrib
                     org-tree-slide
                     pandoc-mode
                     pretty-mode
                     projectile
                     pyvenv
                     rainbow-delimiters
                     restclient
                     restclient-helm
                     ob-restclient
                     ox-reveal
                     ox-gfm
                     ox-tufte
                     shell-switcher
                     slack
                     smartparens
					 use-package
                     web-mode
                     yaml-mode
                     yasnippet
                     ))

(when (not package-archive-contents)
  (package-refresh-contents))

(dolist (package package-list)
  (when (not (package-installed-p package))
    (package-install package)))

(require 'use-package)

;; cd to my home directory on startup 
(cd "~")

;; When using a shell, exec path to set path properly
(when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize))

;; local lisp configs
(let ((default-directory "~/.emacs.d/lisp/"))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path))

(load-library "window-split.el")

;; Shell switcher mode for easier access to shells
(require 'shell-switcher)
(setq shell-switcher-mode t)
(define-key shell-switcher-mode-map (kbd "C-'")
            'shell-switcher-switch-buffer)
(define-key shell-switcher-mode-map (kbd "C-x 4 '")
            'shell-switcher-switch-buffer-other-window)
(define-key shell-switcher-mode-map (kbd "C-M-'")
            'shell-switcher-new-shell)

;; Expand region and embrace
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C-,") #'embrace-commander)
(add-hook 'org-mode-hook #'embrace-org-mode-hook)


;; Setup local snippets
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"))

(yas-global-mode 1)

;; Make sure we have recent files avaialble
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'helm-recentf)

;; Set a nice color theme
(load-theme 'sanityinc-tomorrow-night t)


;; For the GUI use this font and line spacing
(set-face-attribute 'default nil
                    :family "Iosevka Term Slab" :height 130 :weight 'regular)
(setq-default line-spacing 0.20)

;; Pretty mode redisplays some keywords as symbols
(require 'pretty-mode)
(global-pretty-mode 1)

;; Setup Visual line mode
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)

;; restclient 
(require 'restclient)
(require 'restclient-helm)

;; ORG MODE
(require 'org-install)

(setq org-startup-indented t)
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key "\C-cc" 'org-capture)

(setq org-default-notes-file "~/Documents/org/notes.org")

(setq org-agenda-files '("~/Documents/org/projects/"))

(setq org-archive-location "~/Documents/org/archives/%s_archive.org::")

(setq org-refile-targets (quote ((nil :maxlevel . 5)
                                 (org-agenda-files :maxlevel . 5))))

(setq org-refile-use-outline-path 'file)

(setq org-outline-path-complete-in-steps nil)

(setq org-refile-allow-creating-parent-nodes 'confirm)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((ditaa . t)
   (dot . t)
   (plantuml . t)
   (latex . t)
   (python . t)
   (restclient . t)
   (shell . t)))

(setq org-plantuml-jar-path
      (setq plantuml-jar-path (expand-file-name "/usr/local/Cellar/plantuml/1.2018.6/libexec/plantuml.jar")))


(defun my-org-confirm-babel-evaluate (lang body)
  (not (or  (string= lang "ditaa")              ; don't ask for ditaa or dot
         (string= lang "dot")
         (string= lang "plantuml")
         (string= lang "restclient")
         )))                     
(setq org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)

(require 'ox-md)
(require 'ox-odt)
(require 'ox-reveal)
(require 'ox-koma-letter)
(require 'ox-beamer)
(require 'ox-latex)
(require 'ox-tufte)
(require 'ox-gfm)

(setq org-latex-listings 'minted)
(add-to-list 'org-latex-packages-alist '("" "minted"))

(setq org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/Documents/org/notes.org" "Tasks")
             "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree "~/Documents/org/journal.org")
             "* %?\nEntered on %U\n  %i\n  %a")))

(add-to-list 'org-latex-classes
        '("memoir"
          "\\documentclass[9pt,a4paper,extrafontsizes,article]{memoir}"
          ("\\chapter{%s}" . "\\chapter*{%s}")
          ("\\section{%s}" . "\\section*{%s}")
          ("\\subsection{%s}" . "\\subsection*{%s}")       
          ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
          ("\\paragraph{%s}" . "\\paragraph*{%s}")
          ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-latex-classes
        '("tufte"
          "\\documentclass[8pt]{tufte-handout}"
          ("\\section{%s}" . "\\section*{%s}")
          ("\\subsection{%s}" . "\\subsection*{%s}")       
          ("\\paragraph{%s}" . "\\paragraph*{%s}")
          ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
        )

;; Utils
(require 'helm-config)
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(helm-mode 1)

(add-hook 'after-init-hook 'global-company-mode)

;;web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))


;; Python
(elpy-enable)

;; Default Files to open
(find-file "~/Documents/org/notes.org")
(find-file "~/Documents/org/journal.org")
(find-file "~/Documents/org/projects/trialreach.org")

;; Keybindings
(global-set-key (kbd "C-x g") 'magit-status)
(setq smerge-command-prefix "\C-cv")

;; Other config
(add-to-list 'auto-mode-alist '("\\.j2\\'" . jinja2-mode))

(projectile-global-mode)
(require 'helm-projectile)
(helm-projectile-on)

(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(setq neo-smart-open t)
(setq projectile-switch-project-action 'neotree-projectile-action)

(add-to-list 'same-window-buffer-names "*SQL*")
(add-to-list 'same-window-buffer-names "*HTTP Response*")
(add-to-list 'same-window-regexps "\*Slack.*")

(use-package slack
  :commands (slack-start)
  :init
  (setq slack-buffer-emojify t) ;; if you want to enable emoji, default nil
  (setq slack-prefer-current-team t)
  :config
  (slack-register-team
   :name "Antidote"
   :default t
   :client-id ""
   :client-secret ""
   :token ""
   :subscribed-channels '(engineering london-office)
   :full-and-display-names t
   )
)



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#839496" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#002b36"))
 '(custom-safe-themes
   (quote
    ("69e7e7069edb56f9ed08c28ccf0db7af8f30134cab6415d5cf38ec5967348a3c" "a61109d38200252de49997a49d84045c726fa8d0f4dd637fce0b8affaa5c8620" "304c39b190267e9b863c0cf9c989da76dcfbb0649cbcb89592e7c5c08348fce9" "c614d2423075491e6b7f38a4b7ea1c68f31764b9b815e35c9741e9490119efc0" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" default)))
 '(fci-rule-color "#073642")
 '(ns-use-srgb-colorspace t)
 '(package-selected-packages
   (quote
    (slack base16-theme csv-mode embrace expand-region plantuml-mode origami yafolding hl-todo magit-gh-pulls org-jira ox-jira color-theme-sanityinc-tomorrow flymake-lua luarocks fill-column-indicator es-mode kubernetes all-the-icons nginx-mode lua-mode tango-plus-theme sexy-monochrome-theme helm-projectile flymake-json urlenc uuidgen color-theme-solarized pyenv-mode dockerfile-mode projectile neotree jinja2-mode terraform-mode yaml-mode web-mode smartparens shell-switcher restclient-helm rainbow-delimiters pretty-mode pandoc-mode ox-tufte ox-reveal ox-gfm org-tree-slide org-plus-contrib ob-restclient markdown-mode magit json-mode helm-ag exec-path-from-shell elpy cyberpunk-theme color-theme-sanityinc-solarized ag)))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#cb4b16")
     (60 . "#b58900")
     (80 . "#859900")
     (100 . "#2aa198")
     (120 . "#268bd2")
     (140 . "#d33682")
     (160 . "#6c71c4")
     (180 . "#dc322f")
     (200 . "#cb4b16")
     (220 . "#b58900")
     (240 . "#859900")
     (260 . "#2aa198")
     (280 . "#268bd2")
     (300 . "#d33682")
     (320 . "#6c71c4")
     (340 . "#dc322f")
     (360 . "#cb4b16"))))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)
