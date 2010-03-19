(add-to-list 'load-path
             "~/.emacs.d/yasnippet")
(require 'yasnippet)
(require 'dropdown-list)
(yas/initialize)
(yas/load-directory "~/.emacs.d/yasnippet/snippets")
(yas/load-directory "~/.emacs.d/yasnippet/yasnippets-rails/rails-snippets")
(yas/load-directory "~/.emacs.d/yasnippet/yasnippets-shoulda")

