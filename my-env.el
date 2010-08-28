(add-to-list 'load-path (concat dotfiles-dir "vendor"))
(require 'linum)
(require 'comment-ruby)
(require 'rvm)
(require 'textile-mode)
(require 'ack-emacs)

(load "yasnippet-init.el")
(load "echo-area-bell.el")

;; goto line function C-c C-g
(global-set-key [ (control c) (control g) ] 'goto-line)

;; Never iconify...
(global-unset-key [(control z)])
(global-unset-key [(control x) (control z)])

;; Don't F'ing load gnus, since it hangs for quite a while trying to
;; find an nntp server
(global-unset-key (kbd "C-c g"))

(global-set-key (kbd "M-RET") 'hippie-expand)

(global-set-key "\C-cgs" '(lambda ()
                            (interactive)
                            (git-status ".")))

(make-hippie-expand-function
 '(try-expand-dabbrev-visible
   try-expand-dabbrev-from-kill
   try-expand-dabbrev-all-buffers
   try-complete-file-name-partially
   try-complete-file-name))

(setq column-number-mode t)
(setq confirm-kill-emacs (quote y-or-n-p))
(setq show-paren-mode t)
(setq transient-mark-mode t)
(setq blink-cursor-mode t)

;; always highlight the current line
(when window-system (global-hl-line-mode t))

;; force save buffer (useful for triggering autotest)
(global-set-key (kbd "C-c C-c t") '(lambda ()
                                    (interactive)
                                    (set-buffer-modified-p 1)
                                    (save-buffer)))

;; make ido list files vertically
(setq ido-decorations
      (quote
       ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))

;; right justify line number with a space afterward
(setq linum-format
      (lambda (line)
        (propertize
         (format
          (let ((w (length
                    (number-to-string
                     (count-lines (point-min) (point-max))))))
            (concat "%" (number-to-string w) "d ")) line) 'face 'linum)))

(global-linum-mode 1)

;; disable fringe
(set-fringe-mode 0)

(global-auto-revert-mode t)

(setenv "PATH" (shell-command-to-string "source ~/.path; echo -n $PATH"))
(setq exec-path (append exec-path (split-string (getenv "PATH") ":")))

(mouse-avoidance-mode 'animate)

(server-start)
