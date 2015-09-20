(setq stack-ide-packages
  '(
    cmm-mode
    haskell-mode
    ;; TODO
    ;; haskell-snippets
    ;; hindent
    ;; shm
    ))

(defun stack-ide/init-haskell-mode ()
  (use-package haskell-mode
    :defer t
    :config
    (progn
      ;; Copied from the haskell layer
      (evil-leader/set-key-for-mode 'haskell-cabal-mode
       ;; "m="  'haskell-cabal-subsection-arrange-lines ;; Does a bad job, 'gg=G' works better
       "md" 'haskell-cabal-add-dependency
       "mb" 'haskell-cabal-goto-benchmark-section
       "me" 'haskell-cabal-goto-executable-section
       "mt" 'haskell-cabal-goto-test-suite-section
       "mm" 'haskell-cabal-goto-exposed-modules
       "ml" 'haskell-cabal-goto-library-section
       "mn" 'haskell-cabal-next-subsection
       "mp" 'haskell-cabal-previous-subsection
       "mN" 'haskell-cabal-next-section
       "mP" 'haskell-cabal-previous-section
       "mf" 'haskell-cabal-find-or-create-source-file))))

(defun stack-ide/init-cmm-mode ()
  (use-package cmm-mode
    :defer t))
