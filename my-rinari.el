;; load rinari
;; to install rinari:
;; git clone git://github.com/eschulte/rinari.git ~/.emacs.d/vendor/rinari
;; cd ~/.emacs.d/vendor/rinari
;; git submodule init
;; git submodule update
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

(require 'rinari-extensions)
