#lang pollen
◊define-meta[title]{My attempt at explaining closures}
◊define-meta[date]{2019-05-15T18:16:51}
◊define-meta[category]{Trying to explain}
◊define-meta[language]{en}

A closure is a function associated with a local, persistent, environment. It is a language feature — some languages attach local environments to functions, some languages don’t.

This lets functions keep a persistent state without using global variables.

To define a function that has persistent local variables in a language that supports this, create it in a local environment where you’d define these local variables. In Lisp family languages, this means a ◊code{lambda} wrapped inside a ◊code{let}: the local binding of that let will become part of the lambda’s environment.

◊(tabbed
  (list "Scheme" ◊highlight['scheme]{
◊;#+BEGIN_SRC scheme
(define a-closure
  (let ((x 10))
    ;; function created in environment where x = 10
    (lambda (y)
      (set! x (+ x y))
      x)))
◊;#+END_SRC
})

  (list "Emacs Lisp" ◊highlight['elisp]{
◊;#+BEGIN_SRC elisp
;;; -*- lexical-binding: t; -*-
(defalias 'a-closure
  (let ((x 10))
    ;; function created in environment where x = 10
    (lambda (y)
      (setq x (+ x y))
      x)))
◊;#+END_SRC
})

  (list "JavaScript" ◊highlight['javascript]{
◊;#+BEGIN_SRC javascript
{
  let x = 10;
  // function created in environment where x = 10
  function a_closure(y) {
    x += y;
    return x;
  }
}
◊;#+END_SRC
}))

As far as ◊code{a_closure} is concerned, ◊code{x} might as well be a global variable. It is a persistent variable outside of the function that happens to only be accessible to the function.