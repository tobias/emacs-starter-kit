;; not quite there - needs to:
;; * provide ido list of types
;; * use a compilation buffer for the results
(defun rails-generate (type args)
  "runs script/generate"
  (interactive
   (list (read-string "Generate what? ")
         (read-string "Args: ")))
  (setq buffer (get-buffer-create (format "* generate %s output *" type))
        command (format "ruby %sscript/generate %s %s" (rinari-root) type args)
        (message "Running: %s" command))
  (shell-command command buffer)
  (switch-to-buffer-other-window buffer))


(defun count-chars-in-region (start end)
  "thisandthat."
  (interactive "r")
  (message "%d characters" (- end start)))

(defun count-phrase-in-region (start end phrase)
  "thisandthat."
  (interactive (list "r" (read-string "phrase: ")))
  (save-excursion
    (let ((count 0))
      (goto-char start)
      (while (re-search-forward phrase end t)
        (setq count (1+ count)))
      (message "'%s' occurred %d times" phrase count))))
