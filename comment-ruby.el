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

(defun comment-ruby-line ()
  "Comments out the current line with # and returns the number of chars inserted."
  (interactive)
  (save-excursion
    (forward-line 0)
    (insert "# ")
    2))

(defun comment-ruby-region-each-line (start end)
  "Comments each line individually between START and END"
  (interactive "r")
  (forward-line (if (= start (point))
                    -1
                  (if (bolp) 0 1)))
  (save-excursion
    (goto-char end)
    (if (bolp)
        (setq end (- end 1)))
    (goto-char start)
    (while (<= (line-number-at-pos) (line-number-at-pos end))
      (setq end (+ end (comment-ruby-line)))
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
