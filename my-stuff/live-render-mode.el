(make-variable-buffer-local
 (defvar buff nil
   "buffer used by live-render"))

(make-variable-buffer-local
 (defvar command nil))

(defun live-render-set-command ()
  (interactive)
  (setq-local command (read-shell-command "What command should be called ? ")))

(define-minor-mode live-render-mode
  "Outputs the result of a program in a buffer in real time."
  :lighter " live"

  (let ((main-buffer (current-buffer)))
    (when (eq command nil)
      (setq-local command (read-shell-command "What command should be called ? ")))

    (setq buff (get-buffer-create "*live-render*"))
    (switch-to-buffer-other-window buff)
    (switch-to-buffer-other-window main-buffer)

    (add-hook 'after-change-functions
              (lambda (&rest args)
                (shell-command-on-region 1 (buffer-end 1) command buff))
              nil
              t)))

(provide 'live-render-mode)

