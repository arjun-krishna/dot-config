(setq +latex-viewers '(zathura))

(after! tex
  (setq TeX-source-correlate-mode t
        TeX-source-correlate-method 'synctex
        TeX-source-correlate-start-server t
        TeX-fold-auto-reveal t))

(add-hook 'LaTeX-mode-hook #'outline-minor-mode)
