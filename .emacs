;
;; startup file for GNU Emacs 
;; Author Joerg Erdmenger
;;
;;* $Id: .emacs,v 1.0 1998/10/05 14:55:03 erde Exp erde $ "Erdmenger"
;                    -*- emacs-lisp -*-
;;*=======================================================
;;*                SYSTEM
;;*=======================================================
;;{{{ Emacs versions, private variables.

;;; TODO: Remove `my-emacs-type'.  Maybe add a new variable with
;;; the semantics that we are running under Emacs 19 or XEmacs, and

;;;---------------------------------------------------------------------
;;; Temporary constant, my-emacs-type

(defconst my-emacs-type
  (cond
   ((boundp 'epoch::version)		       'emacs-epoch)
   ((string-match "Lucid" emacs-version)       'emacs-lucid)
   ((string-match "^19" emacs-version)         'emacs-19)
   ((string-match "^18" emacs-version)         'emacs-18)
   (t                                          'emacs-19)))

;;;---------------------------------------------------------------------
;;; More temporary constants:
;;;
;;;  my-emacs-lucid-p  - if we run under lucid or XEmacs.  
;;;  my-emacs-xemacs-p - if we run under XEmacs.  
;;;  my-emacs-19-p     - if used under Emacs 19, not XEmacs
;;;  my-emacs-19-n-p   - if we run _at_least_ version 19.n of Emacs.
;;;


(defvar my-emacs-lucid-p (eq my-emacs-type 'emacs-lucid))
(defvar my-emacs-xemacs-p (string-match "XEmacs" emacs-version))
(defvar my-emacs-19-p (eq my-emacs-type 'emacs-19))
(defvar my-emacs-19-28-p (and (eq my-emacs-type 'emacs-19)
			      (>= emacs-minor-version 28)))
(defvar my-emacs-19-29-p (and (eq my-emacs-type 'emacs-19)
			      (>= emacs-minor-version 29)))
(defvar my-emacs-19-30-p (and (eq my-emacs-type 'emacs-19)
 			      (>= emacs-minor-version 30)))


;;*========================================================
;;*                 START EMACS SETTINGS
;;*========================================================

;; Change this to use somebody else's init-files
(setq home-directory (expand-file-name "~"))
;; load system specific file
(setq emacs-base (concat home-directory "/lib/emacs"))
(if (not (file-exists-p emacs-base))
    (setq emacs-base (concat home-directory "/local/lib/emacs")) )
(load (concat emacs-base "/system.el"))


;;*=====================================================
;;*============       MAJOR MODES       ================
;;*=====================================================
(setq auto-mode-alist
      (append '(("\\.app$"   . c++-mode)
                ("\\.bat$"   . rexx-mode)   ; to edit batchfiles
                ("\\.bib$"   . bibtex-mode) ;
                ("\\.btm$"   . rexx-mode)
                ("\\.C$"     . c++-mode)
                ("\\.cc$"    . c++-mode)
                ("\\.cpp$"   . c++-mode)
                ("\\.go$"    . go-mode)
                ("\\.H$"     . c++-mode)
                ("\\.h$"     . c++-mode)
                ("\\.hi$"    . c++-mode)
                ("\\.hpp$"   . c++-mode)
                ("\\.idl$"   . c++-mode)
                ("\\.c$"     . c++-mode)    ; to edit C code
                ("\\.sqc$"   . c-mode)    ; NON-Preprocessed C with DB/2 SQL
                ("\\.rc$"    . c-mode)     ; Files from rc are also smth like c
                ("\\.rci$"   . c-mode)     ; Files from rc are also smth like c
                ("\\.rcx$"   . c-mode)     ; Files from rc are also smth like c
                ("\\.cmd$"   . rexx-mode)   ; to edit REXX-Skripte
                ("\\.c?ps$"  . postscript-mode) ; Fuer postscript-files
                ("\\.tex$"   . latex-mode)  ; tbd
                ("\\.sm$"    . latex-mode)  ;
                ("\\.sty$"   . latex-mode)  ;
                ("\\.mak$"   . makefile-mode)
                ("makefile$" . makefile-mode)
                ("\\.java$"  . java-mode)
                ("\\.jav$"   . java-mode)
                ("\\.js$"    . js-mode)
                ("\\.org\\'" . org-mode)
                ("\\.py$"    . python-mode)
                ("\\.xh$"    . c++-mode)
                ("\\.xih$"   . c++-mode)
                ("\\.ide$"   . sgml-mode)
                ) auto-mode-alist))


;; (autoload 'postscript-mode "postscript.el" "PS-Mode" t)
(autoload 'rexx-mode "rexx-mode" "REXX EditMode" t)
(autoload 'python-mode "python-mode" "Python editing mode." t)

;; compile-command
;(setq compile-command '("make "))
;; am: binde commandos an Tastaur
;;(global-set-key "\C-cd" 'opac-debug)
(global-set-key "\C-co" 'compile)
(global-set-key "\C-cr" 'run-cmd)
(global-set-key "\C-ce" 'next-error)

(defun revert-buffer-no-question ()
  "Reverts the buffer without asking."
  (interactive)
  (revert-buffer nil t t)
)
;;(global-set-key [(f12)] '(revert-buffer nil t) )
(global-set-key [(f12)] 'revert-buffer-no-question )


;; To always save modified buffers before displaying the file in a browser:
(setq browse-url-save-file t)
;; Use Netscape
(setq browse-url-netscape-command "d:\\app\\NETSCAPE\\Communicator\\PROGRAM\\netscape.exe")
;(setq browse-url-

;; Für shelex.exe
(defun shell-execute-url (url &optional new-window)
"Invoke the shell-execute-helper program to call ShellExecute and launch
or re-direct a web browser on the specified url."
  (interactive "sURL: ")
  (call-process shell-execute-helper nil nil nil url)
)

; basic indendation offset for C, C++, JAva etc.
; e 19.34 gehts nicht, sonder direkt gepatcht für Java in cc-styles.el
; (setq c-basic-offset 2)
; Für C 2 Zeichen indent geht so:
;(c-set-style "gnu")
;(setq c-basic-offset 4)
(defun my-c-mode-common-hook ()
  ;; my customizations for all of c-mode and related modes
  (c-set-offset 'substatement-open 0)
  ;; other customizations can go here
  (setq c-basic-offset 4)
  )
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)


;;*=====================================================================
;;*============                   M I S C                  =============
;;*=====================================================================
;;*



;;*=====================================================================
;;*============             G E N E R A L                  =============
;;*=====================================================================
;;*

;; Enable 8-bit input.  set-input-mode must be called when running
;; Emacs -- calling it before dumping doesn't work.
(set-input-mode nil nil 1)
;; auto save every x characters typed
(setq auto-save-interval 100)
(setq auto-save-default t)
;; Eval-Tiefe erhoehen
(set-variable 'max-lisp-eval-depth 1500)
;; Keine Backup-Files
(setq make-backup-files nil)
;; Nie tabs, sondern immer spaces einfuegen (nil)
;(setq-default indent-tabs-mode t)
(setq-default indent-tabs-mode nil)
;; Side-Scroll nil = off
(setq-default truncate-lines nil)


;;*=====================================================================
;;*========                 A P P E R E A N C E                 ========
;;*=====================================================================
;;*

;; Don't beep use visible bell
(setq visible-bell t)

;; show line of file in status line
(setq line-number-mode t)
;; display the column of point in mode line
(setq column-number-mode t)

;; If the variable truncate-lines is non-nil,
;; then each line of text gets just one screen line for displayl
(setq truncate-lines nil)

; Enables the outline minor mode ; Prefix: C-c @ ..
; (cond ((not my-emacs-xemacs-p) (pc-selection-mode) ))
;(setq delete-selection-mode t)
;(setq transient-mark-mode t)

;; regions stay highlited
;;(setq transient-mark-mode t)

;;  no default-directory in fileoperations inserted to mini-buffer
;; (setq insert-default-directory nil)

;; highlight search matches
(setq search-highlight t)
;; prompt for initial comment for register
(setq vc-initial-comment t)
;; Kurze TABS und kleine Tabstops
(setq-default tab-width 8)
(setq-default tab-stop-list '(4 8 12 16 20 24 28 32 36 40 48 56 64 72 80 88 96 104 112 120) )

;;Use special symbols (which are not displayed as-is when
;;occurring in a buffer) for truncated screen lines, continued
;;lines, for displaying control characters, and for separating
;;side-by-side windows

(cond ((not my-emacs-xemacs-p)
       (set-display-table-slot standard-display-table 'truncation      16)
       (set-display-table-slot standard-display-table 'wrap            31)
       (set-display-table-slot standard-display-table 'control         24)
       (set-display-table-slot standard-display-table 'vertical-border 186)))

;; categories for the buffermenu from the beginning
(setq mouse-buffer-menu-mode-mult 0)

;;*=====================================================================
;;*========                   U T I L I I E S                   ========
;;*=====================================================================
;;*

;;     Org Mode
;;
;(setq auto-mode-alist
;      (append '(("\\.app$"   . c++-mode)
;                ("\\.bat$"   . rexx-mode)   ; to edit batchfiles
; (setq org-agenda-files (concat "~/base/main-agenda.org"))

(setq org-directory "~/base")
(setq org-default-notes-file (concat org-directory "/notes.org"))
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/base/gtd.org" "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree "~/base/journal.org")
         "* %?\nEntered on %U\n  %i\n  %a")
        ("n" "Note" entry (file+datetree "~/base/notes.org")
         "* %?\nEntered on %U\n  %i\n  %a")))


(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)


;;     CALC
;;
;;; Commands added by calc-private-autoloads on Wed Oct 06 17:24:06 1999.
(autoload 'calc-dispatch	   "calc" "Calculator Options" t)
(autoload 'full-calc		   "calc" "Full-screen Calculator" t)
(autoload 'full-calc-keypad	   "calc" "Full-screen X Calculator" t)
(autoload 'calc-eval		   "calc" "Use Calculator from Lisp")
(autoload 'defmath		   "calc" nil t t)
(autoload 'calc			   "calc" "Calculator Mode" t)
(autoload 'quick-calc		   "calc" "Quick Calculator" t)
(autoload 'calc-keypad		   "calc" "X windows Calculator" t)
(autoload 'calc-embedded	   "calc" "Use Calc inside any buffer" t)
(autoload 'calc-embedded-activate  "calc" "Activate =>'s in buffer" t)
(autoload 'calc-grab-region	   "calc" "Grab region of Calc data" t)
(autoload 'calc-grab-rectangle	   "calc" "Grab rectangle of data" t)
(global-set-key "\e#" 'calc-dispatch)
;;; End of Calc autoloads.

;; GNUS -- the GNU news reader
;;(setq gnus-select-method '(nntp "news.software.ibm.com"))
;;(setq gnus-select-method '(nntp "news.de.ibm.com"))
;;(setq gnus-select-method '(nntp "news.zurich.ibm.com"))
(setq gnus-select-method '(nntp "forums.ibm.com"))
;;(setq gnus-select-method '(nntp "mdnews.btv.ibm.com"))
(setq user-full-name "Joerg Erdmenger")
(setq user-mail-address "erde@de.ibm.com")

(setq gnus-posting-styles
      '((".*"
         (signature-file "~/.signature")
         (name "Joerg Erdmenger")
;         ("X-Home-Page" (getenv "WWW_HOME"))
         (organization ""))
        ))


;;*=====================================================================
;;*========                        K E Y S                      ========
;;*=====================================================================
;;*

;; Specials für die Keyboardsteuerung unter NT:
;;
(global-set-key [home] 'beginning-of-line)
(global-set-key [end] 'end-of-line)

;; leaving emacs without saving current buffer
(defun save-and-killbuf ()
  "save current buffer and quit"
  (interactive)
  ( if ( not buffer-read-only )
          (save-buffer) )
  (kill-this-buffer))
(global-set-key "\C-x\C-y" 'save-and-killbuf)

;; Rebind Cx-# to also leave the buffer
(defun client-notify-and-killbuf ()
  "Say OK to the emacsclient and kill the buffer"
  (interactive)
  (server-edit)
  ( if ( not buffer-read-only )
          (save-buffer) )
  (kill-this-buffer))
(global-set-key "\C-x\#" 'client-notify-and-killbuf)

;;
;; Goto-Line also M-g
(global-set-key "\M-g" 'goto-line)

;; The following bindings are from Pete Forman and RMS.
;; I have disabled them because I prefer to map my own
;; function keys and I don't like M-bs to undo.  ++KFS
;;  (global-set-key [f1] 'help)             ; KHelp         F1
;;  (global-set-key [f6] 'other-window)     ; KNextPane     F6
;;  (global-set-key [delete] 'delete-char)  ; KDelete       Del
;;  (global-set-key [M-backspace] 'undo)    ; KUndo         aBS

;(global-set-key [(f4)] 'speedbar-get-focus)

;(global-set-key "\eM" 'remove-control-M)
;(global-set-key "\eN" 'umlaute-weg)

;;*========================
;;* VI-style matching parenthesis
;;  From Eric Hendrickson edh @ med.umn.edu
(defun match-paren (arg)
  "Go to the matching parenthesis if on parenthesis otherwise insert %."
  (interactive "p")
  (cond ((looking-at "[([{]") (forward-sexp 1) (backward-char))
        ((looking-at "[])}]") (forward-char) (backward-sexp 1))))
(global-set-key "\C-cp" 'match-paren)
;;Stolen from Robin Socha's .emacs (http://www.socha.net/XEmacs/).

;;
;; Walk between the windows
;;

(defun my-previous-window ()
  "Previous window"
  (interactive) 
  (other-window -1))
(global-set-key "\C-xp" 'my-previous-window)

(global-set-key "\C-xn" 'other-window)


;;
;; Buffer cycling functions
;;

(defun my-unbury-buffer (&optional buf)
  "Select buffer BUF, or the last one in the buffer list.
This function is the opposite of `bury-buffer'."
  (interactive)
  (or buf (setq buf (car (reverse (buffer-list)))))
  (switch-to-buffer buf))


;;*=====================================================================
;;*========            F A C E S   A N D   C O L O R S          ========
;;*=====================================================================
;;*
;;* frame background
;(cond ((not my-emacs-xemacs-p)
;	   (set-background-color "grey80")
;	   (set-foreground-color "black")))

; (setq default-frame-alist
;       (nconc '((foreground-color . "black")
;                (background-color . "grey80"))
;              default-frame-alist))
; 
; ;;; Maybe we want dark backround some day
; ;(if ( (nil))
; ;(setq default-frame-alist
; ;      (nconc '((foreground-color . "grey80")
; ;               (cursor-color . "grey70")
; ;               (background-color . "black")
; ;               (background-mode . dark))
; ;             default-frame-alist)) 
; ;)
; 
; 
; 
; ;; modeline
; (set-face-background 'modeline "grey70")
; (set-face-foreground 'modeline "black")
;; additional settings

(make-face 'info-node)
(copy-face 'bold 'info-node)

;; FONTLOCK zum Syntax-Hiliting
;(cond ((fboundp 'global-font-lock-mode)
;             ;; Turn on font-lock in all modes that support it
;             (global-font-lock-mode t)))
;;;; oder:
 (cond ((not my-emacs-xemacs-p)
        (set-face-background 'font-lock-warning-face "Red")
        (set-face-foreground 'font-lock-warning-face "Yellow")
        (set-face-foreground 'font-lock-keyword-face "MediumBlue")
        (set-face-foreground 'font-lock-variable-name-face "MidnightBlue")
        (set-face-foreground 'font-lock-comment-face "Firebrick")
        (set-face-foreground 'font-lock-string-face "Sienna")))
 
 (cond ((fboundp 'global-font-lock-mode)
        ;; Customize face attributes
        (setq font-lock-face-attributes
              ;; Symbol-for-Face Foreground Background Bold Italic Underline
              '(
                (font-lock-comment-face       "Sienna")
                (font-lock-string-face        "DarkRed")
                (font-lock-function-name-face "Navy")
                (font-lock-variable-name-face "DarkBlue")     ;; "DarkYellow" not found
                (font-lock-type-face          "DarkGreen")
                (font-lock-keyword-face       "Blue")
                (font-lock-reference-face     "DarkRed")
                (font-lock-warning-face       "Red")
                ))
        ;; Load the font-lock package.
        (require 'font-lock)
        ;; Turn on font-lock in all modes that support it
        (global-font-lock-mode t)))

(add-hook 'java-mode-hook 'my-java-mode-hook)
(defun my-java-mode-hook ()
  (cond (window-system
         (require 'andersl-java-font-lock)
         (turn-on-font-lock))))
;; Maximum colors
(setq font-lock-maximum-decoration t)

;;*
;;*=====================================================================
;;*========     E N D   F A C E S   A N D   C O L O R S         ========
;;*=====================================================================
;;*

;;*=============================
;;* Temporary things
;(require 'gnuserv)
;(gnuserv-start)
;(require 'git)

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(setq kill-whole-line t)
(setq diff-switches nil)
(cond ((not my-emacs-xemacs-p)
       (show-paren-mode t)))
;;; Mode settings stored by Calc on Fri Jul 16 13:08:51 1999
;;; End of mode settings
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(case-fold-search t)
 '(column-number-mode t)
 '(current-language-environment "German")
 '(default-input-method "german-postfix")
 '(ldap-host-parameters-alist (quote (("ldap.bluepages.webahead.ibm.com" base "c=de,ou=bluepages,o=ibm.com"))))
 '(org-agenda-files (quote ("z:/doc/dC397/pers/PBC/pbc-2015.org" "z:/doc/dC397/pers/dc397-pers-agenda.org" "z:/doc/dC397/pers/PBC/pbc.org" "~/proj/SCO/SCO 2.4 - Decibel/AC-DC/sco-next-acdc.org" "~/base/patent/patent-agenda.org" "~/proj/SCO/sco-agenda.org" "~/base/education/FFP/ffp-agenda.org" "~/base/journal.org" "~/base/gtd.org" "~/base/education/education-agenda.org" "~/base/main-agenda.org")))
 '(show-paren-mode t)
 '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))
 '(todo-show-priorities 3)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "grey80" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 98 :width normal :foundry "outline" :family "Courier New")))))
