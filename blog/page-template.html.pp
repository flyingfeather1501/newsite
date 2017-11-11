#lang pollen
◊; This file is fed through pollen first. This `require`s eg. ->html for use as a preprocessor.
◊(require pollen/template)

@;{ This is a frog template comment. }

@;{ attr->string : (List Attr Value) -> String }
@(define (attr->string attr)
   (string-append
    (symbol->string (first attr))
    "="
    "\"" (second attr) "\""))

@;{(define rest-headline
   (cond [(string-ci=? uri-path "/index.html") " / Blog"]
         [else ""]))}

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
    <!-- Font -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Fira+Sans|Fira+Sans+Condensed|Overpass">

    <!-- CSS -->
    <link rel="stylesheet" type="text/css" href="@|uri-prefix|/css/normalize.css">
    <link rel="stylesheet" type="text/css" href="@|uri-prefix|/css/skeleton.css">
    <link rel="stylesheet" type="text/css" href="@|uri-prefix|/css/monokai.css">
    <link rel="stylesheet" type="text/css" href="@|uri-prefix|/css/scribble.css">
    <link rel="stylesheet" type="text/css" href="@|uri-prefix|/css/custom.css">
    <!-- Feeds -->
    <link rel="alternate" type="application/atom+xml"
          href="@|atom-feed-uri|" title="Atom Feed">
    <!-- JS -->
    <script src="https://use.fontawesome.com/f9f3cd1f14.js"></script>
    @google-universal-analytics["UA-xxxxx"]
  </head>
  <body>
    <div class="container">
      <header id="topheader" class="ten columns offset-by-one">
        <div class="logo">
          <img src="@|uri-prefix|/images/avatar.png" height="40px"/>
          <a href="/">如月.飛羽</a>
        </div>
        <nav>
          <ul>
            <li><a href="@|uri-prefix|/index.html">Blog</a></li>
            <li><a href="@|uri-prefix|/about.html">About</a></li>
            <li><a href="@|uri-prefix|/writing.html">Writing</a></li>
          </ul>
        </nav>
      </header>

      <div class="row">
        <div id="content" class="ten columns offset-by-one">
          @;{ @tag in tag indexes is non-#f }
          @(when tag
            @list{<h1>Tag: <em>@|tag|</em></h1>})
          @|contents|
        </div>
      </div>

      <footer class="ten columns offset-by-one">
        <hr />
        <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/">
           <img alt="Creative Commons License"
                style="border-width:0"
                src="https://i.creativecommons.org/l/by-nc/4.0/88x31.png" />
        </a>
        <br />
        <p>© Kisaragi Hiu 2017. Posts are licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">CC-BY-NC 4.0 International license</a>.</p>
        <div>
          <a href="@|atom-feed-uri|">
            ◊font-awesome["fa-rss-square"]
          </a>
          ◊twitter["flyin1501"]{
            ◊font-awesome["fa-twitter-square" #:txexpr #t]
          }
        </div>
        ◊(->html ◊p{Site generated by ◊a[#:href "https://github.com/greghendershott/frog"]{Frog}, the ◊strong{fr}ozen bl◊strong{og} tool.})
        ◊(->html ◊p{Preprocessed with ◊a[#:href "http://pollenpub.com"]{Pollen}, the programmable publishing system.})
      </footer>
    </div>
  </body>
</html>
