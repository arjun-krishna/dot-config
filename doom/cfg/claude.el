;;; claude.el --- Claude Code integration for Doom Emacs -*- lexical-binding: t; -*-

;;; Commentary:
;; This file configures claude-code.el — an Emacs interface for the Claude Code
;; CLI. The goal is seamless interaction with Claude without leaving Emacs,
;; especially within an evil/doom workflow where the leader key (SPC) drives
;; everything. All bindings live under SPC c q ("code → claude").

;;; Code:
;; =============================================================================
;; Font fallback for Claude's Unicode box-drawing characters
;; =============================================================================
;; Claude's TUI renders its UI with Unicode box-drawing and symbol characters
;; (e.g., ─ │ ╭ ╰ ● ◆). Most programming fonts only cover a subset of these.
;; Without fallbacks, Emacs shows hollow rectangles for missing glyphs.
;;
;; `use-default-font-for-symbols nil' tells Emacs to consult the fontset
;; instead of always falling back to the default face font for symbol ranges.
;; DejaVu Sans Mono ships with most Linux distros and has broad Unicode coverage.
(setq use-default-font-for-symbols nil)
(set-fontset-font t 'symbol "DejaVu Sans Mono" nil 'prepend)

;; =============================================================================
;; Package configuration
;; =============================================================================
(use-package! claude-code
  ;; `:defer t' means the package is not loaded at startup — it's loaded on
  ;; first use. The keybindings below are registered immediately (they live in
  ;; `:init') but the package code itself loads lazily when a command is called.
  :defer t

  ;; ---------------------------------------------------------------------------
  ;; Keybindings (:init runs before the package loads, which is correct for
  ;; `map!' since Doom registers bindings independently of package load state)
  ;; ---------------------------------------------------------------------------
  :init
  (map! :leader
        (:prefix-map ("c" . "code")
                     (:prefix ("q" . "claude")

                      ;; -- Discovery -------------------------------------------------------
                      ;; The transient menu shows every available command with descriptions.
                      ;; Good starting point if you forget a binding.
                      :desc "Claude transient"        "m" #'claude-code-transient

                      ;; -- Session lifecycle -----------------------------------------------
                      ;; `claude-code' starts a new instance rooted at the current project.
                      ;; With C-u it also switches focus to the Claude buffer after creation.
                      :desc "Claude start"            "c" #'claude-code

                      ;; `claude-code-continue' resumes the most recent conversation for
                      ;; this project — equivalent to `claude --continue' on the CLI.
                      :desc "Claude continue"         "C" #'claude-code-continue

                      ;; `claude-code-resume' shows an interactive list of past sessions so
                      ;; you can jump to a specific one — useful after working on many tasks.
                      :desc "Claude resume"           "R" #'claude-code-resume

                      ;; `claude-code-new-instance' always prompts for an instance name,
                      ;; letting you run multiple parallel Claude sessions in one project
                      ;; (e.g., one for feature work, one for writing tests).
                      :desc "Claude new instance"     "i" #'claude-code-new-instance

                      ;; `claude-code-start-in-directory' prompts for an arbitrary directory
                      ;; instead of inferring the project root — handy for monorepos or when
                      ;; you want Claude scoped to a subdirectory.
                      :desc "Claude in directory"     "d" #'claude-code-start-in-directory

                      ;; `claude-code-kill' terminates the current instance and closes its
                      ;; window. `claude-code-kill-all' nukes every running instance at once.
                      :desc "Claude kill"             "k" #'claude-code-kill
                      :desc "Claude kill all"         "K" #'claude-code-kill-all

                      ;; `claude-code-fork' sends escape-escape to Claude, which jumps the
                      ;; conversation back to a previous checkpoint — useful for exploring
                      ;; an alternative approach without losing your current context.
                      :desc "Claude fork"             "f" #'claude-code-fork

                      ;; -- Sending context to Claude ---------------------------------------
                      ;; Plain send: opens the minibuffer, you type a prompt, Claude receives it.
                      :desc "Claude send command"     "s" #'claude-code-send-command

                      ;; Sends the active visual selection (or whole buffer) into the
                      ;; Claude input line WITHOUT submitting — focus moves to the Claude
                      ;; buffer so you can append more before pressing RET yourself.
                      ;; With C-u, prompts for instructions to prepend first.
                      :desc "Claude send region"      "r" #'my-claude-send-region-no-submit

                      ;; Same as above but also prepends the current file path and line
                      ;; number to the prompt. Use this when asking "what does this code do?"
                      ;; or "fix the bug here" so Claude knows exactly where you are.
                      :desc "Claude send w/ context"  "x" #'claude-code-send-command-with-context

                      ;; Sends the file associated with the current buffer (saves first).
                      ;; With C-u prompts for instructions; with C-u C-u also switches focus.
                      :desc "Claude send buffer file" "o" #'claude-code-send-buffer-file

                      ;; Reads the flycheck/flymake diagnostic at point and asks Claude to
                      ;; fix it. No need to describe the error — Claude sees the full message.
                      :desc "Claude fix error"        "e" #'claude-code-fix-error-at-point

                      ;; -- Window management ----------------------------------------------
                      ;; Toggle shows/hides the Claude window without switching focus.
                      ;; Useful for glancing at Claude's output and returning to your code.
                      :desc "Claude toggle"           "t" #'claude-code-toggle

                      ;; Switch moves your cursor into the Claude buffer (opens it if hidden).
                      ;; With C-u shows all instances across all projects for multi-instance selection.
                      :desc "Claude switch"           "b" #'claude-code-switch-to-buffer

                      ;; Select always shows all running Claude instances across all projects,
                      ;; useful when you have several active and want to pick one explicitly.
                      :desc "Claude select buffer"    "B" #'claude-code-select-buffer

                      ;; Slash commands are Claude's built-in meta-commands (/clear, /help,
                      ;; /compact, etc.). This opens an interactive menu for them.
                      :desc "Claude slash commands"   "/" #'claude-code-slash-commands

                      ;; Read-only mode lets you use normal Emacs/evil motion and yank
                      ;; commands inside the Claude buffer to copy output. Toggle again to
                      ;; return to interactive terminal mode.
                      :desc "Claude read-only toggle" "z" #'claude-code-toggle-read-only-mode

                      ;; Cycles Claude between its three modes:
                      ;;   default → auto-accept edits → plan (no writes, just proposals)
                      ;; The repeat-map below means after the first invocation you can keep
                      ;; pressing M alone to keep cycling.
                      :desc "Claude cycle mode"       "M" #'claude-code-cycle-mode

                      ;; -- Quick responses (answer Claude without switching buffers) -------
                      ;; These send a single keystroke to Claude so you never have to leave
                      ;; your code buffer when Claude asks a yes/no or numbered question.
                      ;;
                      ;; send-return → "Yes" / confirm
                      :desc "Claude yes (return)"     "y" #'claude-code-send-return
                      ;; send-escape → "No" / cancel the running action
                      :desc "Claude no (escape)"      "n" #'claude-code-send-escape
                      ;; send-1/2/3 → pick from a numbered menu Claude presents
                      :desc "Claude send 1"           "1" #'claude-code-send-1
                      :desc "Claude send 2"           "2" #'claude-code-send-2
                      :desc "Claude send 3"           "3" #'claude-code-send-3)))

  ;; ---------------------------------------------------------------------------
  ;; Configuration (:config runs after the package is loaded)
  ;; ---------------------------------------------------------------------------
  :config

  ;; -- Terminal backend -------------------------------------------------------
  ;; claude-code.el supports two terminal emulators: `eat' (default) and `vterm'.
  ;; vterm is already enabled in this Doom config (see init.el :term vterm) and
  ;; tends to have better rendering compatibility on Linux.
  (setq claude-code-terminal-backend 'vterm)

  ;; -- Window behaviour -------------------------------------------------------
  ;; Prevent `delete-other-windows' (C-w o / SPC w m) from closing the Claude
  ;; window accidentally. The Claude buffer stays visible alongside your code.
  (setq claude-code-no-delete-other-windows t)

  ;; When toggling the Claude window open, keep focus in the current code buffer.
  ;; Set to t if you prefer the cursor to jump into Claude on toggle.
  (setq claude-code-toggle-auto-select nil)

  ;; -- Vterm scrollback -------------------------------------------------------
  ;; Vterm's default scrollback is only 1000 lines — a long Claude session
  ;; (code generation, explanations, refactors) will easily overflow this.
  ;; We set it per-buffer in a hook so other vterm buffers are unaffected.
  (add-hook 'claude-code-start-hook
            (lambda ()
              (when (eq claude-code-terminal-backend 'vterm)
                (setq-local vterm-max-scrollback 100000))))

  ;; -- Evil state in Claude buffer --------------------------------------------
  ;; Evil defaults to normal state in new buffers. In a terminal buffer you
  ;; almost always want to type immediately, so we force insert state when
  ;; Claude starts. You can still hit ESC to go to normal state for navigation.
  (add-hook 'claude-code-start-hook #'evil-insert-state)

  ;; -- Desktop notifications --------------------------------------------------
  ;; The default notification only pulses the modeline. On Linux we use
  ;; `notify-send' (part of libnotify, available on GNOME/KDE/etc.) to pop
  ;; a native desktop notification so you know Claude is ready even when Emacs
  ;; is not the focused window.
  ;;
  ;; The function signature must be (title message) — both are strings.
  (defun my-claude-notify (title message)
    "Send a desktop notification via notify-send if available.
Falls back to a minibuffer message when notify-send is not installed."
    (if (executable-find "notify-send")
        (call-process "notify-send" nil nil nil title message)
      (message "%s: %s" title message)))

  (setq claude-code-notification-function #'my-claude-notify)

  ;; -- Send region without auto-submit ----------------------------------------
  ;; Unlike `claude-code-send-region', this does NOT send RET after pasting the
  ;; text. Focus moves to the Claude buffer so you can review/append the prompt
  ;; and press RET yourself when ready.
  (defun my-claude-send-region-no-submit (&optional arg)
    "Send region to Claude input without submitting.
With prefix ARG, prompt for instructions to prepend."
    (interactive "P")
    (let* ((text (if (use-region-p)
                     (buffer-substring-no-properties (region-beginning) (region-end))
                   (if (> (buffer-size) claude-code-large-buffer-threshold)
                       (when (yes-or-no-p "Buffer is large.  Send anyway? ")
                         (buffer-substring-no-properties (point-min) (point-max)))
                     (buffer-substring-no-properties (point-min) (point-max)))))
           (prompt (when (equal arg '(4))
                     (read-string "Instructions for Claude: ")))
           (full-text (if prompt (format "%s\n\n%s" prompt text) text)))
      (when full-text
        (if-let ((buf (claude-code--get-or-prompt-for-buffer)))
            (progn
              (with-current-buffer buf
                (claude-code--term-send-string claude-code-terminal-backend full-text))
              (pop-to-buffer buf))
          (claude-code--show-not-running-message)))))

  ;; -- Mode cycling repeat map ------------------------------------------------
  ;; After invoking `claude-code-cycle-mode' (SPC c q M) once, subsequent
  ;; presses of M alone continue cycling without re-entering the full prefix.
  ;; This uses Emacs' built-in repeat-map mechanism (available since 28.1).
  (defvar my-claude-cycle-repeat-map
    (let ((map (make-sparse-keymap)))
      (define-key map "M" #'claude-code-cycle-mode)
      map)
    "Repeat map for `claude-code-cycle-mode'.
After the first SPC c q M, pressing M alone keeps cycling modes.")
  (put 'claude-code-cycle-mode 'repeat-map 'my-claude-cycle-repeat-map)

  ;; -- Enable the global minor mode -------------------------------------------
  ;; `claude-code-mode' activates the package globally: it sets up process
  ;; tracking, window management hooks, and the notification system.
  ;; Must be called after all the setq configuration above.
  (claude-code-mode 1))

;;; claude.el ends here
