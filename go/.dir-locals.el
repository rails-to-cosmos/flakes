;;; Directory Local Variables            -*- no-byte-compile: t -*-
;;; For more information see (info "(emacs) Directory Variables")

;; go install golang.org/x/tools/cmd/goimports@latest
;; go install golang.org/x/tools/gopls@latest

((nil . ((eval . (let* ((project-root (->> ".dir-locals.el" (locate-dominating-file default-directory) (file-truename)))
                        (gopath (concat project-root ".go"))
                        (path (->> (or (getenv "PATH") "") (s-split ":")
                                   (append (list (f-join gopath "bin")) exec-path) (seq-uniq))))
                   (setenv "GOPATH" gopath) (setenv "PATH" (s-join ":" path))
                   (setq exec-path path)))))
 (go-mode . ((eval . (progn
                       (eglot-ensure)
                       (setq-local company-backends '(company-capf company-files)
                                   gofmt-command "goimports")
                       (company-mode)
                       (indent-tabs-mode -1)
                       (yas-minor-mode)
                       (setq-local tab-width 4)
                       (go-guru-hl-identifier-mode)
                       (smartparens-strict-mode)
                       (company-quickhelp-mode)
                       (company-statistics-mode)
                       (add-hook 'before-save-hook #'gofmt-before-save 0 t)

                       (local-set-key (kbd "M-.") #'godef-jump)
                       (local-set-key (kbd "M-*") #'pop-tag-mark))))))
