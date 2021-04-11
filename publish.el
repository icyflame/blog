(require 'find-lisp)

(defun kannan/publish (file)
  "Export org file to markdown and write to ../_posts. This should be run from the root of the Jekyll folder.

Adapted from jethro/publish: https://github.com/jethrokuan/braindump/blob/master/publish.el"
	   (print "STEP 1: Generate Markdown from Org")
	   (print file)
	   (with-current-buffer (find-file-noselect file)
		 (projectile-mode -1)
		 (setq base-dir (shell-command-to-string '"pwd"))
		 (setq exported-file-name (org-blackfriday-export-to-markdown))
		 (setq output-file-name (concat "../_posts/" exported-file-name))
		 (delete-file output-file-name t)
		 (rename-file exported-file-name output-file-name)

		 (with-current-buffer (find-file-noselect output-file-name)
		   (setq file-stub-path (concat '"file://" (expand-file-name "..")))
		   (print file-stub-path)

		   (print "STEP 2: Fixing image and file links by removing file:///... prefix")
		   (while (search-forward file-stub-path nil t)
			 (replace-match '"" nil t))

		   (print "STEP 3: Fixing footnotes by removing fn: prefix")
		   (while (search-forward '"[^fn:" nil t)
			 (replace-match '"[^" nil t))
		   (save-buffer))))
