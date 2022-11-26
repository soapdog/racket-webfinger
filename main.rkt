#lang racket/base

(module+ test
  (require rackunit))

;; Notice
;; To install (from within the package directory):
;;   $ raco pkg install
;; To install (once uploaded to pkgs.racket-lang.org):
;;   $ raco pkg install <<name>>
;; To uninstall:
;;   $ raco pkg remove <<name>>
;; To view documentation:
;;   $ raco docs <<name>>
;;
;; For your convenience, we have included LICENSE-MIT and LICENSE-APACHE files.
;; If you would prefer to use a different license, replace those files with the
;; desired license.
;;
;; Some users like to add a `private/` directory, place auxiliary files there,
;; and require them in `main.rkt`.
;;
;; See the current version of the racket style guide here:
;; http://docs.racket-lang.org/style/index.html

;; Code here

(require "private/client.rkt")

(provide webfinger)

(module+ test
  ;; Any code in this `test` submodule runs when this file is run using DrRacket
  ;; or with `raco test`. The code here does not run when this file is
  ;; required by another module.
  (require json)

  (define account-json #<<here-string-delimiter
{"aliases":["https://wandering.shop/@AndreShouldBeWriting","https://wandering.shop/users/AndreShouldBeWriting"],"links":[{"href":"https://wandering.shop/@AndreShouldBeWriting","rel":"http://webfinger.net/rel/profile-page","type":"text/html"},{"href":"https://wandering.shop/users/AndreShouldBeWriting","rel":"self","type":"application/activity+json"},{"rel":"http://ostatus.org/schema/1.0/subscribe","template":"https://wandering.shop/authorize_interaction?uri={uri}"}],"subject":"acct:AndreShouldBeWriting@wandering.shop"}
here-string-delimiter
    )
  (define a1 (string->jsexpr account-json))
  (define a2 (webfinger "andreshouldbewriting@wandering.shop"))
  (check-equal? a1 a2))


(module+ main
  ;; (Optional) main submodule. Put code here if you need it to be executed when
  ;; this file is run using DrRacket or the `racket` executable.  The code here
  ;; does not run when this file is required by another module. Documentation:
  ;; http://docs.racket-lang.org/guide/Module_Syntax.html#%28part._main-and-test%29

  (require racket/cmdline
           json)
  (define address (box "soapdog@toot.cafe"))
  (define verbose-mode (make-parameter #f))
  (define get-links (make-parameter #f))
  (command-line
   #:program "webfinger"
   #:once-each
   [("-v" "--verbose") "Run with verbose messages"
                       (verbose-mode #t)]
   #:once-each
   [("-l" "--links") "Get links"
                     (get-links #t)]
   #:args (address)
   (begin0
     (when (verbose-mode)
       (printf "Finding WebFinger information for ~a...\n" address))
     (cond [(get-links) (printf "~a" (jsexpr->string (webfinger/link-for-rel-and-type address)))]
           [else 
            (printf "~a" (jsexpr->string (webfinger address)))]))))
