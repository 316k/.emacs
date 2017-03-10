(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

(package-initialize)

(setq load-path
      (cons "~/.emacs.d/my-stuff"
            (cons "~/g4/share/emacs/site-lisp"
                  load-path)))

(setq scheme-program-name "~/g4/bin/gsi -:d-")
(setq gambit-repl-command-prefix "\e")
(require 'gambit)

(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist '(("." . "~/.emacs-saves"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("f9574c9ede3f64d57b3aa9b9cef621d54e2e503f4d75d8613cbcc4ca1c962c21" "9ab634dcc9131f79016c96c4955298409649f6538908c743a8a9d2c6bc8321ef" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "1a53efc62256480d5632c057d9e726b2e64714d871e23e43816735e1b85c144c" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" default)))
 '(ede-project-directories (quote ("/home/k/src/tf")))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (julia-shell lua-mode dark-souls flappymacs zone-nyan zone-matrix graphviz-dot-mode xbm-life ducpel nodejs-repl gnuplot gnuplot-mode erc-image php-mode zone-rainbow wolfram-mode web-mode watch-buffer undo-tree take-off tabbar sublimity solarized-theme snippet smooth-scrolling smooth-scroll rings racket-mode paredit nyan-mode nlinum markdown-preview-mode magit lorem-ipsum linear-undo less-css-mode kooten-theme json-mode jasmin helm ham-mode flylisp fireplace fill-column-indicator erc-nick-notify emstar darkokai-theme color-theme-cobalt brainfuck-mode bison-mode auto-shell-command auto-complete-nxml apache-mode ac-php ac-js2 ac-html-bootstrap abyss-theme 2048-game)))
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

(setq browse-url-browser-function 'eww-browse-url)

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
(global-set-key (kbd "C-<prior>") 'previous-buffer)
(global-set-key (kbd "C-<next>") 'next-buffer)
;; Eval stuff
(global-set-key (kbd "C-c C-e") 'eval-buffer)

(eval-after-load "python"
  '(progn
     (define-key python-mode-map [(control c) (kbd "RET")] 'python-shell-send-region)
     (define-key python-mode-map (kbd "C-<") 'python-indent-shift-left)
     (define-key python-mode-map (kbd "C->") 'python-indent-shift-right)))

(defun my-c-initialization-hook ()
  (define-key c-mode-base-map [(control c) (control c)] 'comment-dwim))
(add-hook 'c-initialization-hook 'my-c-initialization-hook)

(eval-after-load "sql"
  '(define-key sql-mode-map [(control c) (kbd "RET")] 'sql-send-region))

;; Funky stuff
(global-set-key (kbd "C-d")
                (lambda ()
                  (interactive)
                  (move-beginning-of-line 1)
                  (kill-line)))

(global-set-key (kbd "C-=")
                (lambda () (interactive) 
                  (align-regexp (region-beginning) (region-end) "\\(\\s-*\\)=>?")))

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(define-key input-decode-map [?\C-i] [C-i])
(global-set-key (kbd "<C-i>") 'goto-line)

(cua-mode t)
(setq org-support-shift-select 1)
(setq org-startup-indented t)
(global-visual-line-mode t)

;;(global-set-key  'move-text-up)

(defun move-text-internal (arg)
   (cond
    ((and mark-active transient-mark-mode)
     (if (> (point) (mark))
            (exchange-point-and-mark))
     (let ((column (current-column))
              (text (delete-and-extract-region (point) (mark))))
       (forward-line arg)
       (move-to-column column t)
       (set-mark (point))
       (insert text)
       (exchange-point-and-mark)
       (setq deactivate-mark nil)))
    (t
     (beginning-of-line)
     (when (or (> arg 0) (not (bobp)))
       (forward-line)
       (when (or (< arg 0) (not (eobp)))
         (transpose-lines arg))
       (when (< arg 0)
         (forward-line -1))
       (when (> arg 0)
         (forward-line -1))))))

(defun move-text-down (arg)
   "Move region (transient-mark-mode active) or current line arg lines down."
   (interactive "*p")
   (move-text-internal arg))

(defun move-text-up (arg)
   "Move region (transient-mark-mode active) or current line arg lines up."
   (interactive "*p")
   (move-text-internal (- arg)))

(global-set-key (kbd "M-<up>") 'move-text-up)
(global-set-key (kbd "M-<down>") 'move-text-down)

(column-number-mode t)
(global-linum-mode)
;(set-face-background hl-line-face "gray13")
;(global-hl-line-mode t)

(setq-default c-default-style "linux"
              c-basic-offset 4
              tab-width 4
              indent-tabs-mode nil)

(c-set-offset (quote cpp-macro) 0 nil)

(setq web-mode-style-padding 4)
(setq web-mode-script-padding 4)

(setq web-mode-extra-snippets
      '(("php" . (("load" . "document.addEventListener('DOMContentLoaded', function() {\n    |\n});\n")
                  ("init" . "document.addEventListener('DOMContentLoaded', function() {\n    |\n});\n")
                  ("need" . "if(!$|->loaded())\n    throw new HTTP_Exception_403();")))
        ("html" . (("load" . "document.addEventListener('DOMContentLoaded', function() {\n    |\n});\n")
                  ("init" . "document.addEventListener('DOMContentLoaded', function() {\n    |\n});\n")))
        ("js" . (("load" . "document.addEventListener('DOMContentLoaded', function() {\n    |\n});\n")
                 ("init" . "document.addEventListener('DOMContentLoaded', function() {\n    |\n});\n")))))

(ac-config-default)

;(add-to-list 'ac-dictionnary-directories "~/.emacs.d/elpa/auto-complete-20160107.8/dict")
(global-auto-complete-mode t)
(setq ac-ignore-case 0)

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
           ((or (string-match-p "/var/www/html/" dir)
                (string-match-p "/home/k/www/" dir))
            (list "web"))
           ((string-match-p "/home/k/src/" dir)
            (list "src"))
           ((string-match-p "/home/k/université/" dir)
            (list "uni"))
           ((string-match-p "/home/k/" dir)
            (list "misc"))
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


(load-file "~/.emacs.d/my-stuff/special-chars.el")
(global-set-key (kbd "C-c C-M-c") 'word-to-special-char)
(global-set-key (kbd "s-v") 'word-to-special-char)

(setq-default markdown-preview-style "http://localhost/md-style.css")

(add-hook 'html-mode-hook
          (lambda ()
            ;; Default indentation is usually 2 spaces, changing to 4.
            (set (make-local-variable 'sgml-basic-offset) 4)))

(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)

(define-key global-map (kbd "<XF86Back>") nil)
(define-key global-map (kbd "<XF86Forward>") nil)

;; C-return to eval
(define-key cua-global-keymap [(control return)] nil)
(define-key cua--region-keymap [(control return)] nil)

(add-hook 'gnuplot-mode-hook
          (lambda ()
            (define-key gnuplot-mode-map [(control return)] 'gnuplot-send-line-to-gnuplot)))
(add-hook 'python-mode-hook
          (lambda ()
            (define-key python-mode-map [(control return)] 'python-shell-send-region)))

;; scroll one line at a time (less "jumpy" than defaults)

(setq mouse-wheel-scroll-amount '(3 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mu\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

(load-theme 'abyss)
(set-face-attribute 'font-lock-string-face nil :foreground "#9944FD")
(set-face-attribute 'font-lock-variable-name-face nil :foreground "#0BAB6E")

(tool-bar-mode -1)
(put 'downcase-region 'disabled nil)


(add-hook 'erc (lambda ()
                 (add-to-list 'erc-modules 'notifications)))


(defun delete-word (arg)
  "Delete characters forward until encountering the end of a word.
With argument, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))

(defun backward-delete-word (arg)
  "Delete characters backward until encountering the end of a word.
With argument, do this that many times."
  (interactive "p")
  (delete-word (- arg)))

(global-set-key (kbd "<C-backspace>") 'backward-delete-word)

;; Hmm
(dolist (cmd '(delete-word backward-delete-word))
  (put cmd 'CUA 'move))

(read-kbd-macro "<C-backspace>")

(global-set-key (kbd "M-DEL") 'backward-delete-word)

;;   ;; Hmm
;;   (dolist (cmd '(delete-word backward-delete-word))
;;     (put cmd 'CUA 'move))

;;   (read-kbd-macro "<M-DEL>"))

;; (add-hook 'web-mode-hook
;;           'ctrl-back-deletes)

(defun keyboard-escape-quit ()
  "Exit the current \"mode\" (in a generalized sense of the word).
This command can exit an interactive command such as `query-replace',
can clear out a prefix argument or a region,
can get out of the minibuffer or other recursive edit,
cancel the use of the current buffer (for special-purpose buffers),
or go back to just one window (by deleting all but the selected window)."
  (interactive)
  (cond ((eq last-command 'mode-exited) nil)
	((region-active-p)
	 (deactivate-mark))
	((> (minibuffer-depth) 0)
	 (abort-recursive-edit))
	(current-prefix-arg
	 nil)
	((> (recursion-depth) 0)
	 (exit-recursive-edit))
	(buffer-quit-function
	 (funcall buffer-quit-function))
	((string-match "^ \\*" (buffer-name (current-buffer)))
	 (bury-buffer))))

(defadvice kill-buffer (around gabc/kill-scracth activate)
  (let ((buffer-to-kill (ad-get-arg 0)))
    (if (equal buffer-to-kill "*scratch*")
        ;; (bury-buffer)
        (error "Can't kill scratch")
      ad-do-it)))

;; (find-file "~/todo.org")

(setq flyspell-issue-welcome-flag nil) ;; fix flyspell problem

(defadvice show-paren-function
    (after show-matching-paren-offscreen activate)
  "If the matching paren is offscreen, show the matching line in the
        echo area. Has no effect if the character before point is not of
        the syntax class ')'."
  (interactive)
  (let* ((cb (char-before (point)))
         (matching-text (and cb
                             (char-equal (char-syntax cb) ?\) )
                             (blink-matching-open))))
    (when matching-text (message matching-text))))

;; ---------- Python Session Transcript ----------
;; (setq inferior-python-transcript-file nil)

;; (add-hook 'inferior-python-mode-hook
;;           (lambda ()
;;             (setq inferior-python-transcript-file (concat "~/transcript-" (format-time-string "%s.%6N.py")))

;;             (append-to-file
;;              (concat
;;               "# -*- coding: utf-8 -*-\n"
;;               "from time import sleep as __PYTHON_EL_sleep\n"
;;               "from sys import argv as __PYTHON_EL_argv\n"
;;               "__PYTHON_EL_start = " (format-time-string "%s.%6N") "\n"
;;               "__PYTHON_EL_max_delay = float(__PYTHON_EL_argv[-1]) if '--max-delay' in __PYTHON_EL_argv else None\n"
;;               "__PYTHON_EL_real_time = '--real-time' in __PYTHON_EL_argv\n"
;;               "\n"
;;               "def __PYTHON_EL_transcript_sleep__(n):\n"
;;               "    global __PYTHON_EL_start\n"
;;               "    t = n - __PYTHON_EL_start\n"
;;               "    if __PYTHON_EL_real_time:\n"
;;               "        __PYTHON_EL_sleep(t)\n"
;;               "    elif __PYTHON_EL_max_delay:\n"
;;               "        __PYTHON_EL_sleep(min(t, __PYTHON_EL_max_delay))\n"
;;               "    # else : no sleep\n\n"
;;               "    __PYTHON_EL_start = n\n"
;;               "\n")
;;              nil inferior-python-transcript-file)
            
;;             (defun python-shell-send-string (string &optional process msg)
;;               "Send STRING to inferior Python PROCESS.
;; When optional argument MSG is non-nil, forces display of a
;; user-friendly message if there's no process running; defaults to
;; t when called interactively."
;;               (interactive
;;                (list (read-string "Python command: ") nil t))
              
;;               (when (and (not (string-prefix-p "import codecs, os;__pyfile = codecs.open" string))
;;                          (not (string-prefix-p "def __PYDOC_get_help(obj):" string))
;;                          (not (string-prefix-p "\ndef __PYTHON_EL_native_completion_setup():" string)))
                
;;                 (let* ((real-str (string-remove-prefix "# -*- coding: utf-8 -*-\n" string))
;;                        (indent-len (string-match "[[:graph:]]" (string-trim real-str))))

;;                   (when indent-len
;;                     (append-to-file (concat
;;                                      (make-string indent-len ? ) "__PYTHON_EL_transcript_sleep__(" (format-time-string "%s.%6N") ")\n"
;;                                      real-str
;;                                      "\n")
;;                                     nil inferior-python-transcript-file))))
              
;;               (let ((process (or process (python-shell-get-process-or-error msg))))
;;                 (if (string-match ".\n+." string)   ;Multiline.
;;                     (let* ((temp-file-name (python-shell--save-temp-file string))
;;                            (file-name (or (buffer-file-name) temp-file-name)))
;;                       (python-shell-send-file file-name process temp-file-name t))
;;                   (comint-send-string process string)
;;                   (when (or (not (string-match "\n\\'" string))
;;                             (string-match "\n[ \t].*\n?\\'" string))
;;                     (comint-send-string process "\n")))))))

;; (setq comint-input-filter-functions
;;       (list
;;        (lambda (str)
;;          (when (and (string-equal major-mode "inferior-python-mode")
;;                     (string-trim-left str))
;;            (let ((indent-len (string-match "[[:graph:]]" (string-trim str))))
;;              (when indent-len
;;                (append-to-file (concat
;;                                 (make-string indent-len ? ) "__PYTHON_EL_transcript_sleep__(" (format-time-string "%s.%6N") ")\n"
;;                                 str
;;                                 "\n")
;;                                nil inferior-python-transcript-file))))
;;          str)
;;        ))
