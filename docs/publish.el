(require 'find-lisp)

(defun kannan/publish (file output-dir)
  "Export org file to markdown and write to ../_posts. This should be run from the root of the Jekyll folder.

Adapted from jethro/publish: https://github.com/jethrokuan/braindump/blob/master/publish.el"
  (print "STEP 1: Generate Markdown from Org")
  (print file)

  (setq exported-file-name '"")
  (setq exported-file-base-dir '"")

  (with-current-buffer (find-file-noselect file)
	(projectile-mode -1)
	(setq exported-file-base-dir (string-chop-newline (shell-command-to-string '"pwd")))
	(setq exported-file-name (org-blackfriday-export-to-markdown)))

  (setq exported-file-path (concat exported-file-base-dir '"/" exported-file-name))

  (with-current-buffer (find-file-noselect exported-file-path)
	(projectile-mode -1)

	(setq blog-folder-path (expand-file-name ".."))
	(print blog-folder-path)

	(goto-char 0)
	(print "STEP 2: Fixing image and file links by removing the current path of the blog folder")
	(while (search-forward blog-folder-path nil t)
	  (replace-match '"" nil t))

	(goto-char 0)
	(print "STEP 3: Fixing image and file links by removing file:///... prefix")
	(while (search-forward "file://" nil t)
	  (replace-match '"" nil t))

	(goto-char 0)
	(print "STEP 4: Fixing footnotes by removing fn: prefix")
	(while (search-forward '"[^fn:" nil t)
	  (replace-match '"[^" nil t))

	(goto-char 0)
	(print "STEP 5: Fixing links to other blog posts by replacing [http://localhost:[0-9]+/ prefix with /")
	(while (search-forward-regexp "\(http://localhost:\[0-9\]+/" nil t)
	  (replace-match '"(/" nil t))

	(save-buffer))

  ;; exported file is in exported-file-name
  (message '"STEP 6: Moving file to required directory")
  (setq output-file-path (concat output-dir '"/" exported-file-name))
  (if (file-equal-p output-file-path exported-file-path)
	  (message '"Moving files is not required because both paths are the same.")
	(message '"Moving: %s => %s" exported-file-path output-file-path)
	(if (file-exists-p output-file-path)
		(delete-file output-file-path))
	(if (file-exists-p output-file-path)
		(message '"File could not be deleted!"))
	(rename-file exported-file-path output-file-path)))

	  ;; (lambda ()
	  ;; 	(message '"Deleting %s" output-file-path)
