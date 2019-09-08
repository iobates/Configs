(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(btc-ticker-mode t)
 '(elfeed-feeds
   (quote
    ("https://www.youtube.com/feeds/videos.xml?channel_id=UCDEtZ7AKmwS0_GNJog01D2g"
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCDEtZ7AKmwS0_GNJog01D2g")
     ("https://www.youtube.com/feeds/videos.xml?channel_ide=UCxwcmRAmBRzZMNS37dCgmHA"))))
 '(notmuch-saved-searches
   (quote
    ((:name "inbox" :query "tag:inbox" :key "i")
     (:name "unread" :query "tag:unread" :key "u" :sort-order newest-first)
     (:name "flagged" :query "tag:flagged" :key "f")
     (:name "sent" :query "tag:sent" :key "t")
     (:name "drafts" :query "tag:draft" :key "d")
     (:name "all mail" :query "*" :key "a")
     (:name "date-search" :query "date:08.09.19" :sort-order newest-first))))
 '(package-selected-packages
   (quote
    (btc-ticker calender-remind notmuch paredit wanderlust\.el wanderlust deadgrep elfeed-org system-packages w3m ace-window password-store helm-pass forth-mode emms-player-simple-mpv emms emms-mode-line-cycle transmission dmenu exwm-x exwm htmlize ob-bash yasnippet key-chord dired-explorer dired-open dired-ranger org)))
 '(send-mail-function (quote smtpmail-send-it))
 '(transmission-refresh-modes (quote (transmission-mode transmission-info-mode))))
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

(load "smtp.el")
(load "nntp.el")


(paredit-mode t)

(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(if (not (package-installed-p 'use-package))
    (package-install 'use-package))

(load "server")
(unless (server-running-p) (server-start))

;; babel

(defun org-babel-execute:chess (body params)
  "Execute a block of Chess code with org-babel."
  (message "executing Chess source code block")
  (org-babel-eval "/home/kinslayer/Scripts/chess" body)) ; needs a bit of work to do the correct thing.

(setq org-babel-python-command "ipython3 --no-banner --classic --no-confirm-exit")

(defun org-babel-execute:lisp (body params)
  "Execute lisp"
  (message "execute lisp source code block")
  (org-babel-eval "/usr/bin/sbcl" body))

(defun org-babel-execute:forth (body params)
  "Execute lisp"
  (message "execute lisp source code block")
  (org-babel-eval "/usr/bin/gforth" body))


;; org config

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (shell . t)
   (latex . t)
   (lisp . t)))


;; setup slime
(use-package slime
  :ensure t)



;; global keys

(global-unset-key (kbd "<f1>"))
(global-set-key (kbd "<f1>") 'ansi-term)

(global-set-key (kbd "<f5>") 'eval-buffer)

(global-set-key (kbd "C-c n s") 'notmuch-search)
(global-set-key (kbd "C-c n h") 'notmuch)

(global-set-key (kbd "C-c m p") 'emms-previous)
(global-set-key (kbd "C-c m n") 'emms-next)
(global-set-key (kbd "C-c m .") 'emms-pause)
(global-set-key (kbd "C-c m s") 'emms-stop)
(global-set-key (kbd "C-c m f") 'emms-play-file)
(global-set-key (kbd "C-c m b") 'emms)
(global-set-key (kbd "C-c m d") 'emms-add-directory)
(global-set-key (kbd "C-c m a") 'emms-add-file)
(global-set-key (kbd "C-c m r") 'emms-toggle-repeat-playlist)

(global-set-key (kbd "C-c e s") 'eshell)

(global-set-key (kbd "C-c e i") 'ielm)

(global-set-key (kbd "C-c t a") 'transmission-add)
(global-set-key (kbd "C-c t s") 'transmission)

(global-set-key (kbd "<XF86AudioRaiseVolume>") 'emms-volume-raise)
(global-set-key (kbd "<XF86AudioLowerVolume>") 'emms-volume-lower)

(defun show-brave ()
  (interactive)
  (switch-to-buffer "Brave-browser"))

(global-set-key (kbd "C-c b o") 'show-brave)

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

;; setup paredit

(use-package paredit
  :ensure t
  :config
  (paredit-mode t))

(paredit-mode 1)


;; notmuch

(use-package notmuch
  :ensure t)

;; w3m in emacs.

(use-package w3m
  :ensure t)

;; exwm the bestest window manager.

(use-package exwm
  :ensure t
  :config
  (require 'exwm-config)
  (require 'exwm-systemtray)
  (exwm-config-default)
  (exwm-systemtray-enable))

;; ace-window

(use-package ace-window
  :ensure t
  :config
  (global-set-key (kbd "C-c a j") 'ace-window))

;; key-chord

(use-package key-chord
  :ensure t)

;; elfeed

(use-package elfeed
  :commands (elfeed)
  :bind ((:map elfeed-show-mode-map
	       ("p" . browse-url-mpv-open))))

;; forth-mode

(use-package forth-mode
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
  (define-key global-map (kbd "C-.") 'magit-status))


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

;; system-packages

(use-package system-packages
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

;; No toolbar 
(tool-bar-mode 0)

;; keyboard mappings
(define-key global-map (kbd "C-,") 'org-agenda)

(global-set-key (kbd "s-SPC") 'dmenu)
(display-time-mode 1)

;; Unbind C-z to not get a suspended emacs.
(global-unset-key (kbd "C-z"))


;; Just nice for resizing.
(global-set-key (kbd "<C-up>") 'shrink-window)
(global-set-key (kbd "<C-down>") 'enlarge-window)
(global-set-key (kbd "<C-left>") 'shrink-window-horizontally)
(global-set-key (kbd "<C-right>") 'enlarge-window-horizontally)


;; Some setup for emms
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


(global-set-key (kbd "C-c i s") 'erc)

(add-hook 'dired-mode-hook
	  (lambda () (hl-line-mode))) ; the lambda is necessary


(defun yt-download-url ()
  (interactive)
  (let* ((term (read-string "Url: ")))
    (shell-command (shell-quote-argument (concat "sh ~/ytdl.sh " term)))))


(defun show-msg-after-timer ()
  "Show a message after timer expires. Based on run-at-time and can understand time like it can."
  (interactive)
  (let* ((msg-to-show (read-string "Enter msg to show: "))
         (time-duration (read-string "Time? ")))
    (message time-duration)
    (run-at-time time-duration nil #'message-box msg-to-show)))

(global-set-key (kbd "C-c c s") 'show-msg-after-timer)


(defvar yt-search-url "https://www.youtube.com/results?search_query=")

(defun yt-search ()
  (interactive)
  (let* ((st (read-string "Search yt for? ")))
    (w3m (concat yt-search-url st) nil t)))

(define-key w3m-mode-map (kbd "s-y") 'yt-search)

(define-key w3m-mode-map (kbd "s-c") 'w3m-lnum-print-this-url)

(defun browse-url-mpv-open (url &optional ignored)
  "Pass to mpv"
  (interactive (browse-url-interactive-arg "URL: "))
  (call-process "mpv" nil 0 nil url))

(setq browse-url-browser-function 'browse-url-xdg-open)

(define-key global-map (kbd "C-c y d") 'my/yt-download-url)

(setq save-interprogram-paste-before-kill t)
(setq yank-pop-change-selection t)

(defun my/yt-download-url ()
  "Download a link with youtube-dl"
  (interactive)
  (let* ((url (read-string "Url: ")))
    (call-process "~/bin/ytdl.sh" nil 0 nil url)))
