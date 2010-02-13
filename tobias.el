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
