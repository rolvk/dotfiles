(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(deeper-blue))
 '(package-selected-packages
   '(org-bullets helm-swoop doom-modeline doom-themes magit helpful which-key rainbow-delimiters helm use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-source-header ((t (:foreground "#8EC07C")))))
(put 'upcase-region 'disabled nil)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(delete-selection-mode 1)
(setq vc-follow-symlinks t) ;; follow the symlinks without asking
(setq org-support-shift-select t) ;; use shift to select in org-mode
(setq backup-directory-alist '(("." . "~/.emacs-backups"))) ;; set backup files in a specific directory

(global-display-line-numbers-mode t)

(load-theme 'doom-gruvbox t)

(require 'package)

(setq package-archives
      '(("elpa" . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")
	("org" . "https://orgmode.org/elpa/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(require 'use-package)
(setq use-package-always-ensure t)

;; -------------------------------------- init config org-mode

(use-package org)

(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(add-hook 'org-mode-hook 'org-indent-mode)
;; -------------------------------------- finish config org-mode

;; -------------------------------------- init config helm

(use-package helm
  :diminish
  :bind (("C-s" . helm-swoop)
	 ("C-x C-f" . helm-find-files)
	 ("C-x b" . helm-mini)
	 ("M-x" . helm-M-x)
         :map helm-map
         ("TAB" . helm-execute-persistent-action) 
         ("C-j" . helm-next-line)
         ("C-k" . helm-previous-line)
         :map helm-buffer-map
         ("C-k" . helm-previous-line)
         ("C-l" . helm-buffer-switch-other-window)
         ("C-d" . helm-buffer-run-kill-buffers)
         :map helm-find-files-map
         ("C-k" . helm-previous-line)
         ("C-d" . helm-ff-delete-char-backward))
  :init
  (helm-mode 1)
  :config
  (setq helm-M-x-show-short-doc t)
  (helm-autoresize-mode 1)
  (setq helm-autoresize-max-height 30)
  (setq helm-autoresize-min-height 20) 
  (setq helm-candidate-number-limit 500)
  (setq helm-mode-fuzzy-match t)
  (setq helm-completion-in-region-fuzzy-match t))


(defun my-helm-toggle-header-line ()
  "Moves text entry to header."
  (if (with-helm-buffer helm-echo-input-in-header-line)
      (progn
        (setq helm-display-header-line t)
        (setq-local header-line-format
                    '(:eval (concat " " (helm-get-selection)))))
    (setq header-line-format nil)))

(setq helm-echo-input-in-header-line t)

;; -------------------------------------- finish config helm

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :defer 0
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 1))

(use-package helpful
  :ensure t
  :bind
  (("C-h f" . helpful-callable)  ;; Sustituye describe-function
   ("C-h v" . helpful-variable)  ;; Sustituye describe-variable
   ("C-h k" . helpful-key)       ;; Sustituye describe-key
   ("C-c C-d" . helpful-at-point)  ;; Ayuda contextual
   ("C-h F" . helpful-function)  ;; Para funciones puramente funcionales
   ("C-h C" . helpful-command))) ;; Para comandos interactivos


(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

