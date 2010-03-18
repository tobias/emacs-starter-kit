(defun bstats ()
  "calculate stats for blog summary in buffer of the form <month> (<post count>)\n"
  (interactive)
  (let ((sum 0)
        (lines (count-lines 1 (point-max))))
    (save-excursion
      (beginning-of-buffer)
      (while (re-search-forward "(\\([0-9]+\\))" nil t)
        (setq sum (+ sum (string-to-number (match-string 1)))))
      (message "%s posts over %s months - per month avg: %s" sum lines (/ sum lines)))))

