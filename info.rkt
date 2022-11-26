#lang info
(define collection "webfinger")
(define deps '("base"
               "http-easy"))
(define build-deps '("scribble-lib" "racket-doc" "rackunit-lib"))
(define scribblings '(("scribblings/webfinger.scrbl" ())))
(define pkg-desc "Minimal Web Finger implementation")
(define version "1.0")
(define pkg-authors '(agarzia))

(define racket-launcher-names '("webfinger"))
(define racket-launcher-libraries '("main.rkt"))

(define license '(MIT))
