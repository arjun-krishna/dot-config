(after! tramp
  (setq tramp-use-ssh-controlmaster-options nil)
  (setq remote-file-name-inhibit-cache nil)
  (setq tramp-verbose 1)
  (setq tramp-terminal-type "dumb"))
