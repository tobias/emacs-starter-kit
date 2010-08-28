(when window-system (set-face-font `default "-apple-inconsolata-medium-r-normal--15-0-72-72-m-0-iso10646-1"))

;; emacs 23 breaks the command -> meta mapping. This fixes it.
(setq mac-option-key-is-meta nil
      mac-command-key-is-meta t
      mac-command-modifier 'meta
      mac-option-modifier nil)

;; sets the cursor to a bar. useful on carbon emacs 23, since a block
;; cursor obscures the character below
(setq initial-frame-alist
      (cons '(cursor-type . bar)
            (copy-alist initial-frame-alist)))

(setq default-frame-alist
      (cons '(cursor-type . bar)
            (copy-alist default-frame-alist)))

(setq-default ispell-program-name "aspell")


