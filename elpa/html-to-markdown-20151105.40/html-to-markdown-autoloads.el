;;; html-to-markdown-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (html-to-markdown-this-buffer html-to-markdown-string
;;;;;;  html-to-markdown) "html-to-markdown" "html-to-markdown.el"
;;;;;;  (22193 10857 412657 1000))
;;; Generated autoloads from html-to-markdown.el

(autoload 'html-to-markdown "html-to-markdown" "\
Convert contents of current buffer from html to markdown.

This is meant for interactive use. For lisp code, use:
    (html-to-markdown-string (buffer-string))

If the prefix argument ERASE-UNKNOWN is non-nil, tags which can't
be converted to markdown will be erased (default is to keep them
as-is).
Further behavior is controlled by two variables,
`htm-do-fill-paragraph' and `htm-output-buffer-name'.

Understands the following html tags: p, br, ol, ul, li, h[1-9],
b, it, strong, em, blockquote, pre, code.

\(fn &optional ERASE-UNKNOWN)" t nil)

(autoload 'html-to-markdown-string "html-to-markdown" "\
Convert contents of string SOURCE from html to markdown.

Returns a string with the result.

If ERASE-UNKNOWN is non-nil, tags which can't be converted to
markdown will be erased (default is to keep them as-is).
Further behavior is controlled by two variables,
`htm-do-fill-paragraph' and `htm-output-buffer-name'.

Understands the following html tags: p, br, ol, ul, li, h[1-9],
b, it, strong, em, blockquote, pre, code.

\(fn SOURCE &optional ERASE-UNKNOWN)" t nil)

(autoload 'html-to-markdown-this-buffer "html-to-markdown" "\
Like `html-to-markdown', except ERASES the current buffer and inserts the result.

\(fn &optional ERASE-UNKNOWN)" t nil)

;;;***

;;;### (autoloads nil nil ("html-to-markdown-pkg.el") (22193 10857
;;;;;;  513741 643000))

;;;***

(provide 'html-to-markdown-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; html-to-markdown-autoloads.el ends here
