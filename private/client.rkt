#lang racket

;; MINIMAL WEBFINGER CLIENT
;;
;; This is a minimal WebFinger client as defined in
;; RFC7033 and RFC7565
;;
;; URLs for the specs:
;;
;; https://www.rfc-editor.org/rfc/rfc7565
;;
;; https://www.rfc-editor.org/rfc/rfc7033
;;
;; This library doesn't cover the full specification.
;; Just the minimal set of features to be useful in an
;; ActivityPub / Mastodon context.


(require racket/contract
         net/url-string
         net/http-easy
         "types.rkt")

(provide webfinger
         webfinger/link-for-rel-and-type)

(define/contract (webfinger address)
  (string? . -> . (or/c boolean? hash?))
  (define uri-scheme "acct")
  (define split-address (regexp-split #rx"@" address))
  (define host (cadr split-address))
  (define account (car split-address))
  (define account-url (string-append "https://" host "/.well-known/webfinger?resource=" address))
  (define res (get account-url))
  (cond [(not (equal? (response-status-code res) 200)) #f]
        [(member (response-headers-ref res 'content-type) WebFinger-Types/JSON) (response-json res)]
        [(member (response-headers-ref res 'content-type) WebFinger-Types/XML) (response-xexpr res)]
        [else (response-body res)]))

  
(define/contract (webfinger/link-for-rel-and-type address #:rel [rel #f] #:type [type #f])
  ((string?) (#:rel string? #:type string?) . ->* . (or/c boolean? string?))
  (define acct (webfinger address))
  (define (search-predicate a)
    (let ([r (hash-ref a 'rel #f)]
          [t (hash-ref a 'type #f)])
      (cond [(and (string? rel) (false? type)) (equal? r rel)]
            [(and (false? rel) (string? type)) (equal? t type)]
            [(and (string? rel) (string? type)) (and (equal? r rel) (equal? t type))]
            [else #f])))
  (define m (findf search-predicate (hash-ref acct 'links)))
  (if (hash? m)
      (hash-ref m 'href)
      #f))
  

(module+ main
  (webfinger "andre@toot.cafe")
  (webfinger/link-for-rel-and-type "andre@toot.cafe" #:rel "self"))