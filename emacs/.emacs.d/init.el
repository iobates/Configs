(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (emms-player-simple-mpv emms emms-mode-line-cycle transmission dmenu exwm-x exwm htmlize ob-bash yasnippet key-chord dired-explorer dired-open dired-ranger org))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; comment/uncomment these two lines to enable/disable melpa and melpa stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")


;; babel

(defun org-babel-execute:chess (body params)
  "Execute a block of Chess code with org-babel."
  (message "executing Chess source code block")
  (org-babel-eval "/home/kinslayer/Scripts/chess" body)) ; needs a bit of work to do the correct thing.

;; org config

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (shell . t)
   (latex . t)))

;; global keys


(global-set-key (kbd "<f5>") 'eval-buffer)

;; some functions to make latex simpler to work with, specific for my needs.

 

(defun tek-insert-table ()
  (interactive)
  (insert "\\begin{tabular}{l}
\\\\
\\end{tabular}"))

(defun tek-insert-chess ()
  (interactive)
  (insert "\\newchessgame
\\mainline{

}"))


;; setting up key-chord

(use-package exwm
  :ensure t
  :config
  (require 'exwm-config)
  (require 'exwm-systemtray)
  (exwm-config-default)
  (exwm-systemtray-enable))

(use-package key-chord
  :ensure t)

;; key-chord settings.

(key-chord-mode 1)

(defun config-bash ()
  (interactive)
  (find-file "/home/kinslayer/.bashrc"))

(defun config-emacs ()
  (interactive)
  (find-file "/home/kinslayer/.emacs.d/init.el"))

(key-chord-define global-map ",b" 'config-bash)
(key-chord-define global-map ",e" 'config-emacs)

;; making key-chord play with latex

(defun latex-setup ()
  (interactive)
  (key-chord-define latex-mode-map "ae" "{\\ae}")
  (key-chord-define latex-mode-map "/o" "{\\o}")
  (key-chord-define latex-mode-map "aa" "{\\aa}"))

(add-hook 'latex-mode-hook 'latex-setup)

;; org-agenda

(define-key org-mode-map (kbd "C-c a") 'org-agenda)

;; some settings


(setq indent-tabs-mode nil)
(setq custom-tab-width 2)

(setq-default python-indent-offset custom-tab-width)

;; packages

;; god-mode

(use-package god-mode
  :ensure t
  :config
  (global-set-key (kbd "<escape>") 'god-local-mode)) ; awesome mode.

;; ace-jump-mode

(use-package windmove
  :ensure t
  :init
  (define-key global-map (kbd "<down>") 'windmove-down)
  (define-key global-map (kbd "<left>") 'windmove-left)
  (define-key global-map (kbd "<right>") 'windmove-right)
  (define-key global-map (kbd "<up>") 'windmove-up))

;; mingus

(use-package mingus
  :ensure t)

;; lua-mode

(use-package lua-mode
  :ensure t)

;; undo-tree

(use-package undo-tree
  :ensure t
  :init (global-undo-tree-mode))

;; haskell-mode

(use-package haskell-mode
  :ensure t)
;
;; try

(use-package try
  :ensure t)

;; magit

(use-package magit
  :ensure t
  :config
  (define-key global-map (kbd "C-.") 'magit-status)) ;; Prime key since I use dvorak on my keyboard

;; htmlize

(use-package htmlize
  :ensure t)

;; which key

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; ivy

(use-package ivy
  :ensure t
  :bind (("C-x b" . ivy-switch-buffer))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers 1)
  (setq ivy-display-style 'fancy))

;; counsel

(use-package counsel
  :ensure t
  :config
  (progn
    (global-set-key (kbd "C-x C-f") 'counsel-find-file)
    (global-set-key (kbd "M-x") 'counsel-M-x)))

;; swiper

(use-package swiper
  :ensure t
  :config
  (progn
    (global-set-key (kbd "C-s") 'swiper)))

;; auto-complete

(use-package auto-complete
  :ensure t
  :init
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)))

;; yasnippet

(use-package yasnippet
  :ensure t
  :init
  (progn
    (yas-global-mode 1)))

;; theming
(load-theme 'tsdh-dark)

;; No toolbar 
(tool-bar-mode 0)

;; keyboard mappings
(define-key global-map (kbd "C-,") 'org-agenda)

(global-set-key (kbd "s-SPC") 'dmenu)
(display-time-mode 1)


;; Just nice for resizing.
(global-set-key (kbd "<C-up>") 'shrink-window)
(global-set-key (kbd "<C-down>") 'enlarge-window)
(global-set-key (kbd "<C-left>") 'shrink-window-horizontally)
(global-set-key (kbd "<C-right>") 'enlarge-window-horizontally)



(setq exec-path (append exec-path '("/usr/bin")))
(require 'emms-setup)
(require 'emms-player-mplayer)
(emms-standard)
(emms-default-players)
(define-emms-simple-player mplayer '(file url)
      (regexp-opt '(".ogg" ".mp3" ".wav" ".mpg" ".mpeg" ".wmv" ".wma"
                    ".mov" ".avi" ".divx" ".ogm" ".asf" ".mkv" "http://" "mms://"
                    ".rm" ".rmvb" ".mp4" ".flac" ".vob" ".m4a" ".flv" ".ogv" ".pls"))
      "mplayer" "-slave" "-quiet" "-really-quiet" "-fullscreen")



(defun music-next
(global-set-key (kbd "C-c m p") 'emms-previous)
(global-set-key (kbd "C-c m n") 'emms-next)
(global-set-key (kbd "C-c m .") 'emms-pause)
(global-set-key (kbd "C-c m s") 'emms-stop)
(global-set-key (kbd "C-c m b") 'emms)
