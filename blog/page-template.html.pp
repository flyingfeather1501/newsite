#lang pollen
◊; This file is fed through pollen first.
◊; This `require`s eg. ->html for use as a preprocessor.
◊(require pollen/template)

@; This needs local-require as it's a template
@(local-require (only-in xml string->xexpr)
                txexpr
                json
                threading
                racket/format
                racket/string
                "tags.rkt"
                "content-processing.rkt")

@(define all-tags (tag-string->tags tags-list-items))

@(define tags.json (build-path (find-system-path 'temp-dir) "tags.json"))
@(unless (file-exists? tags.json)
  (define p (open-output-file tags.json))
  (display (jsexpr->string (tags->jsexpr all-tags)) p)
  (close-output-port p))

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>@|title|</title>
    <meta name="description" content="@|description|">
    <meta name="author"      content="@|author|">
    <meta name="keywords"    content="@|keywords|">
    <meta name="viewport"    content="width=device-width, initial-scale=1">
    <link rel="icon"      href="@|uri-prefix|/favicon.ico">
    <link rel="canonical" href="@|full-uri|">

    @(when rel-next @list{<link rel="next" href="@|rel-next|">})
    @(when rel-prev @list{<link rel="prev" href="@|rel-prev|">})
    ◊; Font
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Fira+Sans|Overpass+Mono|Overpass:400,600">

    ◊; CSS
    <link rel="stylesheet" type="text/css" href="@|uri-prefix|/css/normalize.css">
    <link rel="stylesheet" type="text/css" href="@|uri-prefix|/css/skeleton.css">
    <link rel="stylesheet" type="text/css" href="@|uri-prefix|/css/emacs.css">
    ◊; Feed
    <link rel="alternate" type="application/atom+xml"
          href="@|atom-feed-uri|" title="Atom Feed">
    ◊; JS stuff
    ◊google-universal-analytics["UA-109874076-1"]
  </head>
  <body>
    <div class="container">
      ◊; Header
      <header id="topheader" class="ten columns offset-by-one">
        <div class="logo">
          <a href="/"><img src="/images/text-logo.svg" alt="如月.飛羽"/></a>
          <img src="@|uri-prefix|/images/avatar.png" alt="Icon"/>
        </div>

        <div id="social-links">
          ◊link["@|atom-feed-uri|"]{◊font-awesome["rss"]}
          ◊twitter["flyin1501"]{◊font-awesome["twitter"]}
          ◊github["kisaragi-hiu"]{◊font-awesome["github"]}
          ◊gitlab["kisaragi-hiu"]{◊font-awesome["gitlab"]}
          ◊youtube["channel/UCl_hsqcvdX0XdgBimRQ6R3A"]{◊font-awesome["youtube"]}
        </div>

        <nav>
          <a href="@|uri-prefix|/index.html">Blog</a>
          <a href="@|uri-prefix|/about.html">About</a>
          <a href="@|uri-prefix|/all-tags.html">Tags</a>
          @(tags->link (get-language-tags all-tags))
          ◊; @(get-category-tags all-tags)
          ◊; <li><a href="@|uri-prefix|/categories.html">Categories</a></li>
        </nav>
      </header>

      ◊; Contents
      <div class="row">
        <div id="content" class="ten columns offset-by-one">
          @(cond [(special? tag) @list{<h1>@(string-titlecase (tag-special-prefix tag)): <em>@(strip-tag-special-prefix tag)</em></h1>}]
                 [tag @list{<h1>Tag: <em>@|tag|</em></h1>}])

          @(if (index? contents)
               (map
                 (λ (year)
                    (string-append
                      (xexpr->string `(h2 ([class "index-year"]) ,year))
                      (~> (string->indices contents)
                          (filter (λ (index) (equal? (content-year index) year)) _)
                          (map strip-metadata _)
                          (string-join _ ""))))
                 (get-years-in-indices (string->indices contents)))

               (strip-metadata contents))
        </div>
      </div>

      ◊; Footer
      <footer class="ten columns offset-by-one">
        <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">
           <img alt="Creative Commons License"
                style="border-width:0"
                src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" />
        </a>
        <br />
        <p>© Kisaragi Hiu 2017–2018. Posts are licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">CC-BY-SA 4.0 International license</a>.</p>
        ◊(->html ◊p{Site generated by ◊a[#:href "https://github.com/greghendershott/frog"]{Frog}, the ◊strong{fr}ozen bl◊strong{og} tool.})
        ◊(->html ◊p{Preprocessed with ◊a[#:href "http://pollenpub.com"]{Pollen}, the programmable publishing system.})
        ◊(->html ◊p{Style based on ◊a[#:href "http://getskeleton.com/"]{Skeleton}.})
      </footer>
    </div>
  </body>
</html>
