(defun erc-summarize-buffer ()
  (save-excursion
    (set-buffer (get-buffer-create "*ERC Summary*"))
    ;(setq buffer-read-only t)
    (current-buffer)))

(defun erc-summarize-message ()
  ""
  (let ((msg (buffer-substring (point-min) (point-max)))
        (buffer-name (buffer-name)))
    (set-buffer (erc-summarize-buffer))
    (goto-char (point-max))
    (and (posix-string-match "^[*<][^*]" msg)
         (insert (erc-summarize-format-message buffer-name msg)))))

(defun erc-summarize-format-message (buffer-name msg)
  (let ((prefix (format "%s [%s] " buffer-name (substring (current-time-string) 11 16)))
        (indent ""))
    (dotimes (number (length prefix))
      (setq indent (concat indent " ")))
    (format "%s%s\n" prefix (replace-regexp-in-string "\n"
                                                      (concat "\n" indent)
                                                      (replace-regexp-in-string "\n$" "" msg)))))

(defun erc-summarize-add-hooks ()
  ""
  (add-hook 'erc-insert-post-hook 'erc-summarize-message)
  (add-hook 'erc-send-post-hook 'erc-summarize-message))

(provide 'erc-summarize)
