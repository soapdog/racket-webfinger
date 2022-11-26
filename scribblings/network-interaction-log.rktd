;; This file was created by make-log-based-eval
((require racket/contract webfinger "private/client.rkt")
 ((3) 0 () 0 () () (c values c (void)))
 #""
 #"")
((require webfinger) ((3) 0 () 0 () () (c values c (void))) #"" #"")
((webfinger "andreshouldbewriting@wandering.shop")
 ((3)
  0
  ()
  0
  ()
  ()
  (c
   values
   c
   (h
    -
    ()
    (subject u . "acct:AndreShouldBeWriting@wandering.shop")
    (aliases
     c
     (u . "https://wandering.shop/@AndreShouldBeWriting")
     c
     (u . "https://wandering.shop/users/AndreShouldBeWriting"))
    (links
     c
     (h
      -
      ()
      (href u . "https://wandering.shop/@AndreShouldBeWriting")
      (type u . "text/html")
      (rel u . "http://webfinger.net/rel/profile-page"))
     c
     (h
      -
      ()
      (href u . "https://wandering.shop/users/AndreShouldBeWriting")
      (type u . "application/activity+json")
      (rel u . "self"))
     c
     (h
      -
      ()
      (template u . "https://wandering.shop/authorize_interaction?uri={uri}")
      (rel u . "http://ostatus.org/schema/1.0/subscribe"))))))
 #""
 #"")
((webfinger/link-for-rel-and-type
  "andreshouldbewriting@wandering.shop"
  #:type
  "application/activity+json")
 ((3)
  0
  ()
  0
  ()
  ()
  (c values c (u . "https://wandering.shop/users/AndreShouldBeWriting")))
 #""
 #"")
