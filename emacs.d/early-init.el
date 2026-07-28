;; -*- lexical-binding: t; -*-

(setq gc-cons-threshold 100000000) ;; 100 MB

;; Improve performance with language servers.
(setq read-process-output-max (* 1024 1024)) ;; 1 MB
