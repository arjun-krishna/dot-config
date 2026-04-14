(setq org-directory "~/org/")

(after! org
  (map! :map org-mode-map
        "C-c 8" #'org-mark-ring-goto))
