(require 'twittering-mode)
(setq twittering-username "tcrawley")
(setq twittering-use-master-password t)
(setq twittering-allow-insecure-server-cert t)

(twittering-icon-mode 1)
(add-hook 'twittering-mode-hook
(lambda ()
(setq twittering-fill-column (min 100 (window-width)))))


