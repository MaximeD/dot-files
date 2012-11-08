(setq-default TeX-master nil)
(setq TeX-PDF-mode t)

;; default programms
(setq TeX-output-view-style 
      (quote (("^dvi$" "." "acroread -openinNewInstance %o") 
	      ("^pdf$" "." "acroread -openInNewInstance %o") 
	      ("^html?$" "." "firefox %o"))))

;; rm aux, log, etc
(add-hook 'LaTeX-mode-hook
	  (function
	   (lambda ()
	     (add-to-list 'TeX-command-list
			  (list "Clean" "rm %s.log %s.aux %s.out %s.idx"
				'TeX-run-command nil t)))))

(add-hook 'reftex-load-hook 'imenu-add-menubar-index)
(add-hook 'reftex-mode-hook 'imenu-add-menubar-index)
(global-set-key [down-mouse-3] 'imenu)

;; folding
(add-hook 'LaTeX-mode-hook (lambda ()
                             (TeX-fold-mode 1)))


;; To have AUCTeX parse your file
;; (useful for the Ref mode and for multiple .tex files inclusion
;; in a master .tex file):
(setq TeX-auto-save t) 
(setq TeX-parse-self t)
(setq-default TeX-master nil)

(add-hook 'TeX-language-dk-hook
	  (lambda () (ispell-change-dictionary "francais")))

;; Activate the Ref mode:
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-reftex)   ; with Emacs latex mode

;; Activate syntax highlighting:
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-command "latex")
 '(TeX-bar-LaTeX-button-alist (quote ((latex :image (lambda nil (if TeX-PDF-mode "pdftex" "tex")) :command (progn (TeX-save-document (TeX-master-file)) (TeX-command "XeLaTeX" (quote TeX-master-file) -1)) :help (lambda (&rest ignored) (TeX-bar-help-from-command-list "LaTeX"))) (pdflatex :image "pdftex" :command (progn (TeX-save-document (TeX-master-file)) (TeX-command "PDFLaTeX" (quote TeX-master-file) -1)) :help (lambda (&rest ignored) (TeX-bar-help-from-command-list "PDFLaTeX"))) (next-error :image "error" :command TeX-next-error :enable (plist-get TeX-error-report-switches (intern (TeX-master-file))) :visible (plist-get TeX-error-report-switches (intern (TeX-master-file)))) (view :image (lambda nil (if TeX-PDF-mode "viewpdf" "viewdvi")) :command (TeX-command "View" (quote TeX-master-file) -1) :help (lambda (&rest ignored) (TeX-bar-help-from-command-list "View"))) (file :image "dvips" :command (TeX-command "File" (quote TeX-master-file) -1) :visible (not TeX-PDF-mode) :help (lambda (&rest ignored) (TeX-bar-help-from-command-list "File"))) (bibtex :image "bibtex" :command (TeX-command "BibTeX" (quote TeX-master-file) -1) :help (lambda (&rest ignored) (TeX-bar-help-from-command-list "BibTeX"))) (clean :image "delete" :command (TeX-command "Clean" (quote TeX-master-file) -1) :help (lambda (&rest ignored) (TeX-bar-help-from-command-list "Clean"))) (latex-symbols-experimental :alias :eval-group LaTeX-symbols-toolbar-switch-contents LaTeX-symbols-toolbar-contents))))
 '(font-latex-match-italic-command-keywords nil)
 '(global-font-lock-mode t nil (font-lock))
 '(send-mail-function (quote mailclient-send-it)))

(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)

;; set XeTeX mode in tex/latex
(add-hook 'LaTeX-mode-hook
	  (lambda()
	    (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex --shell-escape%(mode)%' %t" TeX-run-TeX nil t))
	    (setq TeX-command-default "XeLaTeX")
	    (setq TeX-save-query nil)
	    (setq TeX-show-compilation t)))
