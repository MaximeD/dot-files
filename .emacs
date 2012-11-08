(load "~/.emacs.d/appearance")
(load "~/.emacs.d/latex")
(load "~/.emacs.d/perl")
(load "~/.emacs.d/ruby")
(load "~/.emacs.d/org-mode")
(load "~/.emacs.d/java")
(load "~/.emacs.d/ssh")
(load "~/.emacs.d/dictionnary")
(load "~/.emacs.d/mutt")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; various
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; own lisp files
(add-to-list 'load-path "~/.emacs.d/site-lisp/")

;; run conf-mode for files in /etc
(add-to-list 'auto-mode-alist '("/etc/*" . conf-mode))

;; no autosave (files ending with ~)
(setq make-backup-files nil) 
 
;; use UTF-8 as default coding
(set-language-environment 'utf-8)
(prefer-coding-system 'utf-8)

;; enable copy/pasting for text with accents
(setq selection-coding-system 'compound-text-with-extensions)
(set-selection-coding-system 'utf-8)
 
;; windows binding for copy/paste
(cua-mode 1)

;; change file selection behaviour
(ido-mode 1)
 
;; change completion behavious
(icomplete-mode)
 
;; go to next/previous paren
(global-set-key [M-right] 'forward-sexp) 
(global-set-key [M-left] 'backward-sexp) 

;; answer "y" instead of "yes"
(defalias 'yes-or-no-p 'y-or-n-p)


