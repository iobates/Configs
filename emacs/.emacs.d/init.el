(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (htmlize ob-bash yasnippet key-chord dired-explorer dired-open dired-ranger org))))
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


;; org config

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (shell . t)))

;; global keys

(global-set-key (kbd "M-s") 'save-buffer)
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

(use-package key-chord
  :ensure t)

(key-chord-mode 1)

;; making key-chord play with latex

(defun latex-setup ()
  (interactive)
  (key-chord-define latex-mode-map "ae" "{\\ae}")
  (key-chord-define latex-mode-map "/o" "{\\o}")
  (key-chord-define latex-mode-map "aa" "{\\aa}")
  (key-chord-define latex-mode-map ",t" 'tek-insert-table)
  (key-chord-define latex-mode-map ",c" 'tek-insert-chess))

(add-hook 'latex-mode-hook 'latex-setup)

;; some settings

(setq indent-tabs-mode nil)
(setq custom-tab-width 2)

(setq-default python-indent-offset custom-tab-width)

;; packages

(use-package try
  :ensure t)

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

;; color-theme

(use-package color-theme
  :ensure t)

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
