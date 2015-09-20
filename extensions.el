(setq stack-ide-pre-extensions '())

(setq stack-ide-post-extensions '(stack-mode company-stack-ide))

(defun stack-ide/init-stack-mode ()
  (use-package stack-mode
    :config
    (progn
      (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
      (add-hook 'haskell-mode-hook 'stack-mode)
      (add-hook 'stack-mode-hook (lambda () (setq flycheck-checkers '(stack-ide))))
      ;; FIXME: this likely affects all flycheck users
      (setq flycheck-check-syntax-automatically '(mode-enabled save))
      (evil-leader/set-key-for-mode 'haskell-mode
        "mg" 'stack-mode-goto
        "mt" 'stack-mode-type
        "mi" 'stack-mode-info
        "msc" 'stack-mode-clear
        )
      ;; Put progress in the powerline
      (defvar last-progress-step nil)
      (defvar last-progress-total nil)
      (defun stack-mode-progress-message (step total msg)
        (if (boundp 'flycheck-mode)
            (progn
              (setq last-progress-step step)
              (setq last-progress-total total))
              ;; FIXME: this is ugly - this is the code that currently defines the
              ;; version of stack-mode-progress-message that this is overriding.
              ;; There's likely a better way to do this.
              (message "[%s/%s] %s"
                                (propertize (number-to-string step) 'face 'compilation-line-number)
                                (propertize (number-to-string total) 'face 'compilation-line-number)
                                msg)))

      ;; Copy-modified from syntax-checking layer
      (defmacro spacemacs|custom-flycheck-lighter (error)
        "Return a formatted string for the given ERROR (error, warning, info)."
        `(let* ((error-counts (flycheck-count-errors
                               flycheck-current-errors))
                (errorp (flycheck-has-current-errors-p ',error))
                (err (or (cdr (assq ',error error-counts)) "?"))
                (running (eq 'running flycheck-last-status-change))
                (using-stack (bound-and-true-p stack-mode)))
           ;; This is a hack to get compilation progress into the same location
           ;; that error / warning / info counts are given. When compilation is
           ;; running and we're in stack-mode, only display the portion with the
           ;; info face, and provide the progress there.
           (if (and running using-stack)
               (if (eq ',error 'info)
                   (if (and last-progress-step last-progress-total)
                       (format "%s/%s" last-progress-step last-progress-total)
                       "0/?"))
               (if (or errorp running)
                   (format "•%s " err)))))
      )))

(defun stack-ide/init-company-stack-ide ()
  (use-package company-stack-ide
    :config
    (progn
      (add-to-list 'company-backends 'company-stack-ide)
      (add-hook 'stack-mode-hook 'company-mode))))
