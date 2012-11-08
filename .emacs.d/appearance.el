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

;; parenthesis matching
(show-paren-mode 1)

;; display line-numbers in mode-line
(line-number-mode t)
(column-number-mode t)

;; blinking screen instead of beep
(setq visible-bell t)
 
;; display no splash nor start screen
(setq inhibit-startup-message t)
(setq inhibit-splash-screen t)

(global-hl-line-mode 1)
(set-background-color "#2e3434")
(set-face-background 'hl-line "#330") 
(setq linum-format "%d ") ;; add space for line numbering

;; gentoo syntax coloring
(require 'site-gentoo)
