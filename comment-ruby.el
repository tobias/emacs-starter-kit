(defun comment-ruby-region-as-block (start end)
  "Comments out the region between START and END with ruby =begin and =end markers.
After executing, the point will be at bol for the line just after or just before
the comment block, depending on whether point is START or END when called."
  (interactive "r")
  (let ((original-point (point))
        (end-line (line-number-at-pos start))
        (start-text "\n=begin\n")
        (end-text "=end\n\n"))
    (save-excursion
      (goto-char end)
      (unless (bolp)
        (forward-line 1))
      (if (= original-point end)
          (setq end-line (+ (line-number-at-pos) 3)))
      (insert end-text)
      (goto-char start)
      (forward-line 0)
      (insert start-text))
    (goto-line end-line)))

(defun marker-regex (marker)
  (concat "^" marker " *$"))

(defun match-and-remove-block-marker (marker)
  (save-excursion
    (if (re-search-forward (marker-regex marker) nil t)
        (progn
          (replace-match "")
          (delete-char 1)
          t)
      nil)))
    
(defun uncomment-ruby-block (beginning-point)
  (save-excursion
    (goto-char beginning-point)
    (and (match-and-remove-block-marker "=begin")
        (match-and-remove-block-marker "=end"))))

(defun point-in-ruby-comment-blockp (point)
  (save-excursion
    (goto-char point)
    (let ((begin-point (re-search-backward (marker-regex "=begin") nil t))
           (end-point (re-search-forward (marker-regex "=end") nil t)))
      (and begin-point
           end-point
           (> point begin-point)
           (< point end-point)
           begin-point))))

(defun goop ()
  (interactive)
  (let ((p (point-in-blockp (point))))
    (message "%s" p)
    (uncomment-ruby-block p)
    )
  )
  

(defun comment-ruby-line ()
  "Comments out the current line with # and returns the number of chars inserted."
  (interactive)
  (save-excursion
    (forward-line 0)
    (insert "# ")
    2))

(defun uncomment-ruby-line ()
  "Uncomments the current line when it has been commented with #"
  (interactive)
  (save-excursion
    (back-to-indentation)
    (if (char-equal (char-after) ?#)
        (progn
          (delete-char 1)
          (ruby-indent-line)
          1)
      0)))

(defun uncomment-ruby-region-each-line (start end)
  "Uncomments each line individually between START and END"
  (interactive "r")
  (comment-operation-on-each-line start end '(uncomment-ruby-line)))

(defun comment-ruby-region-each-line (start end)
  "Comments each line individually between START and END"
  (interactive "r")
  (comment-operation-on-each-line start end '(comment-ruby-line)))

(defun comment-operation-on-each-line (start end op)
  "Runs op on each line between START and END"
  (forward-line (if (= start (point))
                    -1
                  (if (bolp) 0 1)))
  (save-excursion
    (goto-char end)
    (if (bolp)
        (setq end (- end 1)))
    (goto-char start)
    (while (<= (line-number-at-pos) (line-number-at-pos end))
      (setq end (+ end (eval op)))
      (forward-line 1))))

(defun comment-ruby-region (start end)
  "Comments out the region between START and END.
If there are 4 or less lines, each line is commented with a #. Otherwise,
the entire block is commented with =begin/=end."
  (interactive "r")
  (if (> 5
         (- (line-number-at-pos end)
            (line-number-at-pos start)))
      (comment-ruby-region-each-line start end)
    (comment-ruby-region-as-block start end)))

(defun comment-ruby ()
  "Comments out a block of ruby code. If the region is set, the entire region is commented.
Otherwise, the current line is commented."
  (interactive)
  (if (and transient-mark-mode mark-active)
      (comment-ruby-region (region-beginning) (region-end))
    (comment-ruby-line)))

(eval-after-load 'ruby-mode
  '(define-key ruby-mode-map (kbd "C-:") 'comment-ruby))

(provide 'comment-ruby)
