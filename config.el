;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "David Yates"
      user-mail-address "d@vidyat.es")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; font
(setq doom-font (font-spec :family "DejaVu Sans Mono" :size 14 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "DejaVu Sans") ; inherits `doom-font''s :size
      doom-unicode-font (font-spec :family "DejaVu Sans Mono" :size 14)
      doom-big-font (font-spec :family "DejaVu Sans Mono" :size 16))

;; split windows
(map!   :n ",w" (cmd! (split-window-horizontally) (evil-window-right 1))
        :n ",z" (cmd! (split-window-vertically) (evil-window-down 1)))

;; navigate windows
(map!   :n "C-h" #'evil-window-left
        :n "C-j" #'evil-window-down
        :n "C-k" #'evil-window-up
        :n "C-l" #'evil-window-right)

;; buffers
(map!   :n ",," 'previous-buffer
        :n ",." 'next-buffer)

;; mouse
(map! :n [mouse-8] 'better-jumper-jump-backward)

;; kill quit confirmation message
(setq confirm-kill-emacs nil)

;; word count
(map! :n [f9] (cmd! (evil-ex "w !wc -w")))

;; restore s behaviour
(after! evil-snipe (evil-snipe-mode -1))

;; suppress line numbers in writeroom-mode (https://www.reddit.com/r/emacs/comments/glpl67/questions_about_writeroommode/fqz4vsc/)
(defun dy/toggle-minor-mode (mode)
  (if (symbol-value mode) (funcall (symbol-function mode) 0) (funcall (symbol-function mode) 1)))

 (defun dy/writeroom-mode-hook ()
  (dy/toggle-minor-mode 'hl-line-mode)
  (dy/toggle-minor-mode 'display-line-numbers-mode))

(add-hook 'writeroom-mode-hook #'dy/writeroom-mode-hook)

;; don't zoom in so much in writeroom
(setq +zen-text-scale 0.6)

;; edit vimwiki files like markdown
(add-to-list 'auto-mode-alist '("\\.wiki\\'" . markdown-mode))
