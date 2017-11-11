#lang at-exp racket/base
(require pollen/core
         pollen/decode
         pollen/tag
         pollen/template
         pollen/unstable/pygments
         racket/date
         racket/dict
         racket/format
         racket/function
         racket/list
         racket/match
         racket/string
         threading
         txexpr
         "_common/ytvidinfo.rkt")

(provide (all-defined-out))

(module setup racket/base
  (provide (all-defined-out))
  (require pollen/setup)
  (define block-tags (append '(subsection subsubsection label img pre) default-block-tags)))

(define (strike . text)
  (->html `(s ,@text)))

; newline-decode : (ListOf String) -> String
(define (newline-decode . text)
  (~> (string-join text "")
      (string-replace _ #rx"\n\n+" "\nREPLACEWITHNEWLINNNNEE")
      (string-replace _ "\n" "<br>\n")
      (string-replace _ "REPLACEWITHNEWLINNNNEE" "\n")))

(define pagebreak (->html '(div ([class "page-break"]))))

(define (year . text)
  (->html `(p ([class "year-in-page"]) ,@text)))

(define (font-awesome fa-icon
                      #:aria [hidden #t]
                      #:txexpr [return-txexpr #f])
  (~>
   `(i ([class ,(string-append "fa "
                               fa-icon)]
        [aria-hidden "true"]))
   ((if return-txexpr
        identity
        ->html) _)))

#| link functions |#

(define (link url #:class [class ""] . text)
  (->html
   `(a ([href ,url]
        [target "_blank"]
        [class ,class])
       ,@text)))

(define (link/date url date . text)
  (->html
   `(p ,(string-append date " ")
       ,(link url (string-join text)))))

(define (L site sub text #:class [class ""])
  (~> (hash 'github "https://github.com/"
            'youtube "https://youtube.com/"
            'pixiv "https://pixiv.net/"
            'niconico "http://www.nicovideo.jp/"
            'osuwiki "http://osu.ppy.sh/help/wiki/"
            'transifex "https://www.transifex.com/user/profile/"
            'noichigo "https://www.no-ichigo.jp/read/book/book_id/"
            'twitter "https://twitter.com/")
      (dict-ref _ site)
      (string-append _ sub)
      (link _ text class)))

; wrapper around L
(define (twitter sub text)
  (L 'twitter
     sub
     text))
(define (github sub text)
  (L 'github
     sub
     text))
(define (youtube sub text)
  (L 'youtube
     sub
     text
     #:class "youtube"))
(define (pixiv sub text)
  (L 'pixiv
     sub
     text
     #:class "pixiv"))
(define (niconico sub text)
  (L 'niconico
     sub
     text
     #:class "niconico"))
(define (osuwiki sub text)
  (L 'osuwiki
     sub
     text
     #:class "osuwiki"))
(define (transifex sub text)
  (L 'transifex
     sub
     text))
(define (noichigo sub text)
  (L 'noichigo
     sub
     text))

(define site-url "http://kisaragi-hiu.com")
(define (youtube/embed video-id)
  (->html
   `(iframe ([id "ytplayer"]
             [type "text/html"]
             [width "640"]
             [height "360"]
             [src ,(string-append
                    "http://www.youtube.com/embed/"
                    video-id
                    "?autoplay=0"
                    "&origin="
                    site-url)]
             [frameborder "0"]))))