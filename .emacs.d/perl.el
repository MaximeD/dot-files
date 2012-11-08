(mapc
 (lambda (pair)
   (if (eq (cdr pair) 'perl-mode)
       (setcdr pair 'cperl-mode)))
 (append auto-mode-alist interpreter-mode-alist))

;; linum-mode
(add-hook 'cperl-mode-hook
  (lambda() (linum-mode 1)))

;; always highlight scalars
(setq cperl-highlight-variables-indiscriminately t)
