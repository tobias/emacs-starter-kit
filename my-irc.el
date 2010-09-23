(require 'erc)
(require 'todochiku)
(require 'erc-highlight-nicknames)

(defun irc-connect-redhat ()
  (interactive)
  (erc :server "irc-2.devel.redhat.com" :port 6667 :nick "tcrawley" :full-name "Tobias Crawley"))
(defun irc-connect-freenode ()
  (interactive)
  (erc :server "irc.freenode.net" :port 6667 :nick "tcrawley" :password my-freenode-password :full-name "Tobias Crawley"))
(defun irc-connect-all ()
  (interactive)
  (irc-connect-redhat)
  (irc-connect-freenode))

(defun growl-when-mentioned (match-type nick message)
  "Shows a growl notification, when user's nick was mentioned."
  (unless (posix-string-match "^\\** *Users on #" message)
    (growl
     (concat "<" (substring nick 0 (string-match "!" nick)) "> on " (buffer-name (current-buffer)))
     message
     )))
(add-hook 'erc-text-matched-hook 'growl-when-mentioned)

(define-key erc-mode-map (kbd "C-c q")
  (lambda (nick)
    (interactive (list (completing-read "Query nick: " erc-channel-users)))
    (erc-cmd-QUERY nick)))

(define-key erc-mode-map (kbd "C-c l") (lambda () (interactive) (erc-cmd-LIST)))

(define-key erc-mode-map (kbd "C-c y") `yank-to-gist)

(setq erc-prompt
      (lambda ()
        (if (and (boundp 'erc-default-recipients) (erc-default-target))
            (erc-propertize (concat (erc-default-target) ">") 'read-only t 'rear-nonsticky t 'front-nonsticky t)
          (erc-propertize (concat "ERC>") 'read-only t 'rear-nonsticky t 'front-nonsticky t))))

;(defun log-it (msg)
;  ""
;  (save-excursion
;    (message msg)))
;
;(defun log-it2 ()
;  ""
;   (message (concat (buffer-name) (buffer-substring (point-min) (point-max)))))

;(add-hook 'erc-insert-pre-hook 'log-it)
;(add-hook 'erc-insert-pre-hook 'log-it2)

