(ispell-change-dictionary "francais")

(defun ispell-check ()
  (interactive)
  (if mark-active
      (if (< (mark) (point))
	  (ispell-region (mark) (point))
	(ispell-region (point) (mark)))
    (ispell-buffer)))
(global-set-key [(control $)] `ispell-check)
(global-set-key [(meta $)] `ispell-word)
(global-set-key [(control meta $)] `ispell-change-dictionary)

;; use aspell instead of ispell
(setq-default ispell-program-name "aspell" )
(setq ispell-local-dictionary "francais" ) 

;; auto-replace
(setq abbrev-file-name
      "~/.emacs.d/abbrev_defs")
(quietly-read-abbrev-file)
(setq default-abbrev-mode t)
