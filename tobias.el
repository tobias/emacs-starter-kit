;; goto line function C-c C-g
(global-set-key [ (control c) (control g) ] 'goto-line)

(setq column-number-mode t)
(setq confirm-kill-emacs (quote y-or-n-p))
(setq show-paren-mode t)
(setq transient-mark-mode t)
(setq blink-cursor-mode t)

;; set keys for comment/uncomment region
;(global-set-key [ (control c) (control c) ] 'comment-region)
;(global-set-key [ (control c) (control u) ] 'uncomment-region)

;; map alt to meta
(setq mac-option-modifier 'meta)

;(set-face-font `default "-apple-envy code r-medium-r-normal--14-0-72-72-m-0-iso10646-1")
;; moved to system specific files
;(when window-system (set-face-font `default "-apple-inconsolata-medium-r-normal--14-0-72-72-m-0-iso10646-1"))


;;(set-background-color "grey12")
;;(set-foreground-color "white")

;; Never iconify...
(global-unset-key [(control z)])
(global-unset-key [(control x) (control z)])

;; Don't F'ing load gnus, since it hangs for quite a while trying to
;; find an nntp server
(global-unset-key (kbd "C-c g"))

;; Ctrl-Tab switches buffers
;(global-set-key [(ctrl tab)] 'bury-buffer)

(global-set-key (kbd "M-RET") 'hippie-expand)

(make-hippie-expand-function
 '(try-expand-dabbrev-visible
   try-expand-dabbrev-from-kill
   try-expand-dabbrev-all-buffers
   try-complete-file-name-partially
   try-complete-file-name))

;; load rinari
;; to install rinari:
;; git clone git://github.com/eschulte/rinari.git ~/.emacs.d/vendor/rinari
;; cd ~/.emacs.d/vendor/rinari
;; git submodule init
;; git submodule update
(require 'ruby-electric)
(add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode)))

(add-to-list 'load-path (concat dotfiles-dir "./vendor/rinari"))
(require 'rinari)

(setq rinari-tags-file-name "TAGS")

;; make the rinari navigation a bit shorter
(global-set-key "\C-cfc" 'rinari-find-controller)
(global-set-key "\C-cfe" 'rinari-find-environment)
(global-set-key "\C-cff" 'rinari-find-file-in-project)
(global-set-key "\C-cfh" 'rinari-find-helper)
(global-set-key "\C-cfi" 'rinari-find-migration)
(global-set-key "\C-cfj" 'rinari-find-javascript)
(global-set-key "\C-cfm" 'rinari-find-model)
(global-set-key "\C-cfn" 'rinari-find-configuration)
(global-set-key "\C-cfs" 'rinari-find-stylesheet)
(global-set-key "\C-cft" 'rinari-find-test)
(global-set-key "\C-cfv" 'rinari-find-view)
(global-set-key "\C-cfa" 'ack-in-project)

(add-to-list 'load-path (concat dotfiles-dir "vendor"))

;; txmt links
(require `textmate-links)

;(require 'viper)
;; for git
(require 'vc-git)
(when (featurep 'vc-git) (add-to-list 'vc-handled-backends 'GIT))
(require 'git)
(autoload 'git-blame-mode "git-blame"
           "Minor mode for incremental blame for Git." t)
(require 'gitsum)

;; haml and sass modes
(require 'haml-mode nil 't)
(add-to-list 'auto-mode-alist '("\\.haml$" . haml-mode))

(require 'sass-mode nil 't)
(add-to-list 'auto-mode-alist '("\\.sass$" . sass-mode))


;; always highlight the current line
(when window-system (global-hl-line-mode t))
;      (custom-set-faces `(hl-line ((t (:inherit highlight :background "grey30"))))))
;                    (set-face-background 'hl-line "yellow"))
;;(set-face-foreground 'hl-line 'inherit)

;; textile mode
(require `textile-mode)

;; highlight current column
;(require 'vline)
;(require 'col-highlight)
;(toggle-highlight-column-when-idle 1)
;(setq col-highlight-vline-face-flag t)
;(col-highlight-set-interval 2)

(require 'ack-emacs)

(global-set-key (kbd "C-c C-c t") '(lambda ()
                                    (interactive)
                                    (set-buffer-modified-p 1)
                                    (save-buffer)))

(add-to-list 'load-path (concat dotfiles-dir "vendor/color-theme"))
(require 'color-theme)
(color-theme-initialize)

(load (concat dotfiles-dir "topfunky-theme.el"))
(color-theme-topfunky)

;; make ido list files vertically
(setq ido-decorations
      (quote
       ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))

(require 'linum)

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

;; from http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun swap-windows ()
  "If you have 2 windows, it swaps them."
  (interactive)
  (cond ((not (= (count-windows) 2))
         (message "You need exactly 2 windows to do this."))
        (t
         (let* ((w1 (first (window-list)))
                (w2 (second (window-list)))
                (b1 (window-buffer w1))
                (b2 (window-buffer w2))
                (s1 (window-start w1))
                (s2 (window-start w2)))
           (set-window-buffer w1 b2)
           (set-window-buffer w2 b1)
           (set-window-start w1 s2)
           (set-window-start w2 s1)))))

(global-set-key "\C-cs" 'swap-windows)

(require 'comment-ruby)
(require 'rinari-extensions)

(load (concat dotfiles-dir "yasnippet-init.el"))

(when window-system (set-face-font `default "-apple-inconsolata-medium-r-normal--14-0-72-72-m-0-iso10646-1"))

(defun byte-recompile-home ()
  (interactive)
  (byte-recompile-directory "~/.emacs.d" 0))

;; from http://emacs.wordpress.com/2007/01/16/quick-and-dirty-code-folding/
(defun toggle-selective-display (column)
  (interactive "P")
  (set-selective-display
   (if selective-display nil (or column 3))))

(global-set-key "\C-ct" 'toggle-selective-display)

(global-set-key "\C-cgs" '(lambda ()
                            (interactive)
                            (git-status ".")))

(server-start)

(defun open-trace-and-file (tracefile file linenum)
  "Open visit TRACEFILE in one window (in compilation mode), and visit FILE at LINENUM in another"
  (find-file-other-window tracefile)
  (compilation-mode)
  (goto-line 2)
  (find-file-other-window file)
  (goto-line linenum))

(load (concat dotfiles-dir "echo-area-bell.el"))

(setq exec-path '("/Users/tobias/bin"
                  "/opt/local/bin"
                  "/opt/local/sbin"
                  "/usr/bin"
                  "/sbin"
                  "/usr/local/bin"))
(setenv "PATH" (mapconcat 'identity exec-path ":"))

(setq-default ispell-program-name "aspell")
