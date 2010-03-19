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


