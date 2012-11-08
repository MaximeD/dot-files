;; THIS FILE IS EXPERIMENTAL !
;; using malabar-mode
(require 'cedet)
(setq semantic-default-submodes '(global-semantic-idle-scheduler-mode
                                  global-semanticdb-minor-mode
                                  global-semantic-idle-summary-mode
                                  global-semantic-mru-bookmark-mode))

(add-to-list 'load-path "~/malabar-mode/src/main/lisp")
(require 'malabar-mode)
;;(setq malabar-groovy-lib-dir "/path/to/malabar/")
(add-to-list 'auto-mode-alist '("\\.java\\'" . malabar-mode))
