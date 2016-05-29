(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

(package-initialize)

(setq load-path
      (cons "~/g4/share/emacs/site-lisp"
            load-path))
(setq scheme-program-name "~/g4/bin/gsi -:d-")
(setq gambit-repl-command-prefix "\e")
(require 'gambit)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("f9574c9ede3f64d57b3aa9b9cef621d54e2e503f4d75d8613cbcc4ca1c962c21" "9ab634dcc9131f79016c96c4955298409649f6538908c743a8a9d2c6bc8321ef" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "1a53efc62256480d5632c057d9e726b2e64714d871e23e43816735e1b85c144c" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" default)))
 '(inhibit-startup-screen t)
 '(tabbar-separator (quote (0.5))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; (setq show-trailing-whitespace '(lines trailing))
;; (whitespace-mode t)

(show-paren-mode)
(require 'undo-tree)
(global-undo-tree-mode t)
(defalias 'redo 'undo-tree-redo)

;; Cool keybindings
(global-set-key (kbd "C-S-s") 'isearch-forward)
(global-set-key (kbd "C-s") 'save-buffer)
(global-set-key (kbd "C-a") 'beginning-of-line-text)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-S-z") 'redo)
(global-set-key (kbd "C-y") 'redo)
(global-set-key (kbd "C-w") 'kill-buffer)
(global-set-key (kbd "C-S-o") 'helm-buffers-list)
(global-set-key (kbd "C-o") 'find-file)
(global-set-key (kbd "M-n") 'next-buffer)
(global-set-key (kbd "M-p") 'previous-buffer)
(global-set-key (kbd "C-d")
                (lambda ()
                  (interactive)
                  (move-beginning-of-line 1)
                  (kill-line)))
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(define-key input-decode-map [?\C-i] [C-i])
(global-set-key (kbd "<C-i>") 'goto-line)

(cua-mode t)
(setq org-support-shift-select 1)
(visual-line-mode t)

(column-number-mode t)
(global-linum-mode)
;(set-face-background hl-line-face "gray13")
;(global-hl-line-mode t)

(setq-default c-default-style "linux"
			  c-basic-offset 4
			  tab-width 4
              indent-tabs-mode nil)

(setq web-mode-style-padding 4)
(setq web-mode-script-padding 4)

(ac-config-default)
;(add-to-list 'ac-dictionnary-directories "~/.emacs.d/elpa/auto-complete-20160107.8/dict")
(global-auto-complete-mode t)

(setq fci-rule-column 80)

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)

(require 'tabbar)
(tabbar-mode t)

(setq tabbar-cycle-scope 'tabs)
(setq tabbar-buffer-groups-function
	  (lambda ()
		(let ((dir (expand-file-name default-directory)))
		  (cond
           ((string-match-p "\\*.+\\*" (buffer-name))
            (list "#sys"))
           ((string-match-p "/var/www/html/" dir)
            (list "web"))
           (t
             ;(list "stuff")))))))
             (list dir))))))

;; Tabbar settings
(set-face-attribute
 'tabbar-default nil
 :background "gray20"
 :foreground "gray20"
 :box '(:line-width 1 :color "gray20" :style nil))
(set-face-attribute
 'tabbar-unselected nil
 :background "gray30"
 :foreground "white"
 :box '(:line-width 5 :color "gray30" :style nil))
(set-face-attribute
 'tabbar-selected nil
 :background "gray75"
 :foreground "black"
 :box '(:line-width 5 :color "gray75" :style nil))
(set-face-attribute
 'tabbar-highlight nil
 :background "white"
 :foreground "black"
 :underline nil
 :box '(:line-width 5 :color "white" :style nil))
(set-face-attribute
 'tabbar-button nil
 :box '(:line-width 1 :color "gray20" :style nil))
(set-face-attribute
 'tabbar-separator nil
 :background "gray20"
 :height 0.6)
(set-face-attribute
 'tabbar-modified nil
 :background "gray30"
 :foreground "green"
 :box '(:line-width 5 :color "gray30" :style nil))

;; Change padding of the tabs
;; we also need to set separator to avoid overlapping tabs by highlighted tabs

;; adding spaces
(defun tabbar-buffer-tab-label (tab)
  "Return a label for TAB.
That is, a string used to represent it on the tab bar."
  (let ((label  (if tabbar--buffer-show-groups
                    (format "[%s]  " (tabbar-tab-tabset tab))
                  (format "%s  " (tabbar-tab-value tab)))))
    ;; Unless the tab bar auto scrolls to keep the selected tab
    ;; visible, shorten the tab label to keep as many tabs as possible
    ;; in the visible area of the tab bar.
    (if tabbar-auto-scroll-flag
        label
      (tabbar-shorten
       label (max 1 (/ (window-width)
                       (length (tabbar-view
                                (tabbar-current-tabset)))))))))

(define-key global-map [(alt j)] 'tabbar-backward)
(define-key global-map [(alt k)] 'tabbar-forward)

(global-set-key [M-left] 'tabbar-backward-tab)
(global-set-key [M-right] 'tabbar-forward-tab)


(setq-default markdown-preview-style "http://localhost/md-style.css")

(add-hook 'html-mode-hook
          (lambda ()
            ;; Default indentation is usually 2 spaces, changing to 4.
            (set (make-local-variable 'sgml-basic-offset) 4)))

(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)

;; scroll one line at a time (less "jumpy" than defaults)

(setq mouse-wheel-scroll-amount '(3 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time


(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

(load-theme 'abyss)
(set-face-attribute 'font-lock-string-face nil :foreground "#9944FD")
(set-face-attribute 'font-lock-variable-name-face nil :foreground "#0BAB6E")

(tool-bar-mode -1)
