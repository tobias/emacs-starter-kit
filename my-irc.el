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


;; I'd like to be notified when:
;; - I'm mentioned anywhere
;; - messages are posted to specific rooms
;; I'd like to play a sound when messages are posted to specific rooms
;; after a idle period
;; Mentions should be sticky, along with any dcc
;; (defun growl-when-mentioned (match-type nick message)
;;   "Shows a growl notification, when user's nick was mentioned."
;;   (unless (posix-string-match "^\\*\\*\\*" message)
;;     (todochiku-message
;;      (concat "<" (substring nick 0 (string-match "!" nick)) "> on " (buffer-name (current-buffer)))
;;      (escape-html message)
;;      ""
;;      (posix-string-match (erc-current-nick) message)
;;      )))
;; (add-hook 'erc-text-matched-hook 'growl-when-mentioned)

(defvar irc-channels-for-alerting
  '("#steamcannon" "#projectodd")
  "IRC channels to watch for alerting.")

(defun irc-growl (channel message)
  "Displays an irc message to growl/libnotify via todochiku.
Notice will be sticky if the message is a mention."
  (let ((split-message (irc-split-nick-and-message message)))
    (if split-message
        (todochiku-message
         (concat "<" (nth 0 split-message) "> on " channel)
         (escape-html (nth 1 split-message))
     ""
     (string-match (erc-current-nick) (nth 1 split-message)) ;; be sticky if it's a mention
     ))))

(defun irc-split-nick-and-message (msg)
  "Splits an irc message into nick and the rest of the message.
Assumes message is either of two forms: '* nick does something' or '<nick> says something'"
  (if (string-match "^[<\\*] ?\\(.*?\\)>? \\(.*\\)$" msg)
      (cons (match-string 1 msg)
            (cons (match-string 2 msg)
                  ()))
    ()))

(defun irc-alert-on-message (channel msg)
  "Plays a sound and growl notifies a message."
  (and (string-match "^[*<][^*]" msg)
       (> (length msg) 0)
       (or (member channel irc-channels-for-alerting)
           (not (string-match "^#" channel)) ;;DCC
           (string-match (erc-current-nick) msg)) 
       (progn
         (play-irc-alert-sound)
         (irc-growl channel msg))))

(defun irc-alert ()
  (save-excursion
    (irc-alert-on-message (buffer-name) (buffer-substring (point-min) (point-max)))))

(add-hook 'erc-insert-post-hook 'irc-alert)

(defun play-irc-alert-sound ()
  (start-process-shell-command "alert-sound" nil "mplayer /usr/share/sounds/purple/alert.wav"))

(defun escape-html (str)
  "Escapes [<>&\n] from a string with html escape codes."
  (and str
       (replace-regexp-in-string "<" "&lt;"
        (replace-regexp-in-string ">" "&gt;"
         (replace-regexp-in-string "&" "&amp;"
          (replace-regexp-in-string "\n" "" str))))))

(define-key erc-mode-map (kbd "C-c q")
  (lambda (nick)
    (interactive (list (completing-read "Query nick: " erc-channel-users)))
    (erc-cmd-QUERY nick)))

(define-key erc-mode-map (kbd "C-c y") `yank-to-gist)

(setq erc-prompt
      (lambda ()
        (if (and (boundp 'erc-default-recipients) (erc-default-target))
            (erc-propertize (concat (erc-default-target) ">") 'read-only t 'rear-nonsticky t 'front-nonsticky t)
          (erc-propertize (concat "ERC>") 'read-only t 'rear-nonsticky t 'front-nonsticky t))))


(require 'erc-summarize)
(erc-summarize-add-hooks)
