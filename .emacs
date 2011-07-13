;;=================================
;; Apparence :
;;=================================
(require 'color-theme)
(setq color-theme-load-all-themes nil)

(require 'color-theme-tangotango)
;; select theme - first list element is for windowing system, second is for console/terminal
;; Source : http://www.emacswiki.org/emacs/ColorTheme#toc9
(setq color-theme-choices 
      '(color-theme-tangotango color-theme-tangotango))

;; default-start
(funcall (lambda (cols)
    	   (let ((color-theme-is-global nil))
    	     (eval 
    	      (append '(if (window-system))
    		      (mapcar (lambda (x) (cons x nil)) 
    			      cols)))))
    	 color-theme-choices)

;; test for each additional frame or console
(require 'cl)
(fset 'test-win-sys 
      (funcall (lambda (cols)
    		 (lexical-let ((cols cols))
    		   (lambda (frame)
    		     (let ((color-theme-is-global nil))
		       ;; must be current for local ctheme
		       (select-frame frame)
		       ;; test winsystem
		       (eval 
			(append '(if (window-system frame)) 
				(mapcar (lambda (x) (cons x nil)) 
					cols)))))))
    	       color-theme-choices ))
;; hook on after-make-frame-functions
(add-hook 'after-make-frame-functions 'test-win-sys)

(color-theme-tangotango)
 
(global-hl-line-mode 1)
(set-background-color "#2e3434")
(set-face-background 'hl-line "#330") 
(setq linum-format "%d ") ;; ajoute un espace pour la numérotation des lignes


;;=================================
;; LaTeX :
;;=================================

(setq-default TeX-master nil)
(setq TeX-PDF-mode t)     ;;  Active le mode pdflatex par défaut

;; programmes par défaut
(setq TeX-output-view-style 
      (quote (("^dvi$" "." "acroread -openinNewInstance %o") 
	      ("^pdf$" "." "acroread -openInNewInstance %o") 
	      ("^html?$" "." "firefox %o"))))

;; Supprimer les fichiers log, aux, etc, remarque ça ne marche pas...
(add-hook 'LaTeX-mode-hook
	  (function
	   (lambda ()
	     (add-to-list 'TeX-command-list
			  (list "Clean" "rm %s.log %s.aux %s.out %s.idx"
				'TeX-run-command nil t)))))

(add-hook 'reftex-load-hook 'imenu-add-menubar-index)
(add-hook 'reftex-mode-hook 'imenu-add-menubar-index)
(global-set-key [down-mouse-3] 'imenu)

;; Pour le fold
(add-hook 'LaTeX-mode-hook (lambda ()
                             (TeX-fold-mode 1)))


;; To have AUCTeX parse your file
;; (useful for the Ref mode and for multiple .tex files inclusion
;; in a master .tex file):
(setq TeX-auto-save t) 
(setq TeX-parse-self t)
(setq-default TeX-master nil)

(add-hook 'TeX-language-dk-hook
	  (lambda () (ispell-change-dictionary "francais"))) ; ajouter "\usepackage[francais]{babel}" dans le.tex pour l'activer

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
 '(global-font-lock-mode t nil (font-lock)))

(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)

;; set XeTeX mode in tex/latex
(add-hook 'LaTeX-mode-hook
	  (lambda()
	    (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
	    (setq TeX-command-default "XeLaTeX")
	    (setq TeX-save-query nil)
	    (setq TeX-show-compilation t)))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Correction orthographique :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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

;; Pour utiliser aspell au lieu de ispell
(setq-default ispell-program-name "aspell" )
(setq ispell-local-dictionary "francais" ) 

;; remplacement automatique :
(setq abbrev-file-name             ;; dit à emacs où se trouve
      "~/.emacs.d/abbrev_defs")    ;; le fichier d'abbréviations
(quietly-read-abbrev-file)         ;; lit le fichier d'abbréviations au démarrage
(setq default-abbrev-mode t)       ;; active le mode abbréviations



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Autres :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; fichiers lisp persos
(add-to-list 'load-path "~/.emacs.d/site-lisp/") ; ne marche pas

;; pas d'autosave (ces fichus ~)
(setq make-backup-files nil) 

;; Correspondance des parenthèses :
(show-paren-mode 1)
 
;; Utiliser UTF-8 comme codage de caractères par défaut.
(set-language-environment 'utf-8)
(prefer-coding-system 'utf-8)

;; pouvoir faire du copier coller de texte avec caractères accentués
(setq selection-coding-system 'compound-text-with-extensions)
(set-selection-coding-system 'utf-8)

;; Afficher les numéros de lignes dans la mode-line
(line-number-mode t)
(column-number-mode t)
 
;; Faire clignoter l'écran au lieu de faire « beep ».
(setq visible-bell t)
 
;; N'afficher ni le message d'accueil ni le splash
(setq inhibit-startup-message t)
(setq inhibit-splash-screen t)

;; Des raccourcis claviers et une selection comme sous Windows
;; (C-c/C-x/C-v pour copier coller, ...)
(cua-mode 1)

;; Changer le comportement de la selection de fichiers (C-x C-f)
(ido-mode 1)
 
;; Dans la même série : changer le comportement de la complétion.
(icomplete-mode)
 
;; Définir des touches pour se déplacer rapidement :
;; Aller à la parenthèse ouvrante correspondante :
(global-set-key [M-right] 'forward-sexp) 
;; Aller à la parenthèse fermante correspondante :
(global-set-key [M-left] 'backward-sexp) 

;; (global-font-lock-mode 1) ;; réactiver si pas de font lock

(if window-system
    (require 'font-latex))

;; Répondre 'y' plutôt que 'yes'.
(defalias 'yes-or-no-p 'y-or-n-p)

;; coloration des fichiers gentoo
(require 'site-gentoo)

;; numérotation des lignes
;;(add-hook 'text-mode-hook 'turn-on-setnu-mode) ; en global non..

;; lecture des .rtf
(autoload 'rtf-mode "rtf-mode" "RTF mode" t)
(add-to-list 'auto-mode-alist
  '("\\.rtf$" . rtf-mode))

;; mutt
(defun axels-mail-mode-hook ()
  (turn-on-auto-fill) ;;; Auto-Fill is necessary for mails
  (turn-on-font-lock) ;;; Font-Lock is always cool *g*
  (flush-lines "^\\(> \n\\)*> -- \n\\(\n?> .*\\)*") ;;; Kills quoted sigs.
  (not-modified) ;;; We haven't changed the buffer, haven't we? *g*
  (mail-text) ;;; Jumps to the beginning of the mail text
  (setq make-backup-files nil) ;;; No backups necessary. 
  )

(or (assoc "mutt-" auto-mode-alist)
(setq auto-mode-alist (cons '("mutt-" . mail-mode) auto-mode-alist)))
(add-hook 'mail-mode-hook 'axels-mail-mode-hook)

;;(server-start) ;;; For use with emacsclient 
(put 'downcase-region 'disabled nil)


;;;;;;;;;;;;;;;;;;;;;;;;;
;; Utilisation de ruby ;;
;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'ruby-electric) 
(defun my-ruby-mode-hook ()
  (ruby-electric-mode)
  )
(add-hook 'ruby-mode-hook 'my-ruby-mode-hook) 
