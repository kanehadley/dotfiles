;; -*- lexical-binding: t; -*-
;; ===================================
;; Instructions
;; ===================================
;; Initialization can be done with the following two commands:
;;   M-x package-refresh-contents RET
;;   M-x package-install RET


;; ===================================
;; Performance Profiling
;; ===================================
;; Measure startup time
;; (defun my/display-startup-time ()
;;   "Display the startup time after Emacs initialization."
;;   (message "Emacs loaded in %s with %d garbage collections."
;;            (format "%.2f seconds"
;;                    (float-time
;;                     (time-subtract after-init-time before-init-time)))
;;            gcs-done))
;; (add-hook 'emacs-startup-hook #'my/display-startup-time)


;; ===================================
;; MELPA Package Support
;; ===================================
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

;; If there are no archived package contents, referesh them
(when (not package-archive-contents)
  (package-refresh-contents))

;; Installs packages
;;
;; myPackages contains a list of package names
(defvar myPackages
  '(
    cider
    clojure-mode
    company
    eat
    lsp-mode
    magit
    paredit
    python-black
    rainbow-delimiters
    ruff-format
    )
  )

;; Scans the list in myPackages
;; If the package listed is not already installed, install it
(mapc #'(lambda (package)
	  (unless (package-installed-p package)
	    (package-install package)))
      myPackages)


;; ===================================
;; Basic Customization
;; ===================================
(setq inhibit-startup-message t) ;; Hide the startup message
(setq tab-always-indent 'complete)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq major-mode-remap-alist
      '((python-mode . python-ts-mode)))
(global-company-mode) ;; Enables autocompletion.
(global-display-fill-column-indicator-mode) ;; Enable column rules.


;; ====================================
;; Development Setup
;; ====================================
(use-package emacs
  :ensure nil
  :init
  (load-theme 'wombat)
  (fido-vertical-mode)
  :custom
  (treesit-language-source-alist
   '((python "https://github.com/tree-sitter/tree-sitter-python"))))
;; After initial installation run:
;;     M-x treesit-install-language-grammar RET python RET y https://github.com/tree-sitter/tree-sitter-python RET default branch RET "src" RET auto-detect RET auto-detect RET ~/.emacs.d/tree-sitter RET

(use-package cider
  :defer t
  :config
  (bind-keys :map cider-mode-map
	     ("C-M-q" . cider-format-defun)))

(use-package lsp-mode
  :ensure t
  :hook
  (python-mode . lsp-deferred)
  :defer t
  :commands lsp
  :config
  (bind-keys :map lsp-mode-map
	     ("M-?" . lsp-find-references))
  )

(use-package python
  :defer t
  :config
  (bind-keys :map python-mode-map
	     ("C-<left>" . windmove-left)
	     ("C-<right>" . windmove-right)
	     ("C-<up>" . windmove-up)
	     ("C-<down>" . windmove-down)))

(use-package python-black
  :defer t
  :after python)

(use-package magit
  :defer t
  ;; :init (setq magit-status-show-untracked-files 'all)
  )

(add-hook 'prog-mode-hook #'display-line-numbers-mode)

(add-hook
 'prog-mode-hook
 (
  lambda ()
	 (interactive)
	 (setq display-fill-column-indicator-column 79))
 ) ;; The line is placed over line 80 in source files

(add-hook 'clojure-mode-hook 'paredit-mode)

;; For `eat-eshell-mode'.
(add-hook 'eshell-load-hook #'eat-eshell-mode)

;; For `eat-eshell-visual-command-mode'.
(add-hook 'eshell-load-hook #'eat-eshell-visual-command-mode)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((shell . t)
   (python . t)))


;; ====================================
;; User Defined functions
;; ====================================
(defun hacky-keys ()
  (bind-key "C-<left>" 'windmove-left)
  (bind-key "C-<right>" 'windmove-right)
  (bind-key "C-<up>" 'windmove-up)
  (bind-key "C-<down>" 'windmove-down)
  (bind-key "C--" 'undo)
  (bind-key "C-M--" 'undo-redo)
  )
(hacky-keys)

;; Local configuration to augment core configuration.
(let ((local-config (expand-file-name "local-config.el" user-emacs-directory)))
  ;; Check if the file exists before attempting to load it.
  (when (file-exists-p local-config)
    (load local-config)))

;; User-Defined init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(cider company eat exec-path-from-shell lsp-mode magit nodejs-repl
           paredit python-black rainbow-delimiters ruff-format
           ts-comint typescript-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

