#lang scribble/manual
@(require racket/sandbox
          racket/runtime-path
          scribble/example
          webfinger
          @(for-label racket/base))

@(begin
   (define-syntax-rule (interaction e ...) (examples #:label #f e ...))
   (define-runtime-path log-file "network-interaction-log.rktd")
   (define log-mode (if (getenv "NETWORK_INTERACTION_RECORD") 'record 'replay))
   (define (make-he-eval log-file)
     (define ev (make-log-based-eval log-file log-mode))
     (begin0 ev
       (ev '(require racket/contract webfinger "private/client.rkt"))))
   (define he-eval (make-he-eval log-file)))

@title{webfinger}
@author[(author+email "Andre Alves Garzia" "andre@andregarzia.com")]

@defmodule[webfinger]

WebFinger is a way to attach information to an email address, or other online resource. WebFinger is standardised in @hyperlink["https://www.rfc-editor.org/rfc/rfc7565"]{RFC 7565} and @hyperlink["https://www.rfc-editor.org/rfc/rfc7033"]{RFC 7033}.


Getting started is as easy as requiring the @tt{webfinger} module:

@interaction[
#:eval he-eval
(require webfinger)
]

@defproc[(webfinger [address string?]) (or/c hash? #f)]{
 Returns a hash with the WebFinger information for the given address or @racket[#f].
}

@interaction[#:eval he-eval
          (webfinger "andreshouldbewriting@wandering.shop")]

@defproc[(webfinger/link-for-rel-and-type [address string?] [#:rel rel string?] [#:type type string?]) (or/c hash? #f)]{
 Returns a @tt["link"] that matches the given @racket[rel] and @racket[type] or @racket[#f].
}

@interaction[#:eval he-eval
          (webfinger/link-for-rel-and-type "andreshouldbewriting@wandering.shop" #:type "application/activity+json")]

