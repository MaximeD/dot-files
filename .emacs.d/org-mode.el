(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

;; Calendar integration
;;(setq org-agenda-include-diary t)

;; your files goes here
(setq org-agenda-files (list "org-file1"
			     "org-file2"
                             ))
