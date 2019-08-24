(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))

; Some utility functions that you may find useful to implement.

(define (cons-all first rests)
  (map (lambda (second) (append (list first) second)) rests)
  )

(define (zip pairs)
  (define (getfirst pairs)
    (map (lambda (pair) (car pair)) pairs)
    )
  (define (delfirst pairs)
    (map (lambda (pair) (cdr pair)) pairs)
    )
  (define (help pairs ziped)
    (if (null? (car pairs))
        ziped
        (help (delfirst pairs) (append ziped (list (getfirst pairs))))
        )
      )
  (help pairs '())
  )

;; Problem 17
;; Returns a list of two-element lists
(define (enumerate s)
  ; BEGIN PROBLEM 17
  (define (enum-help i s)
      (if (null? s)
          nil
          (cons (cons i (list (car s))) (enum-help (+ i 1) (cdr s)))
          )
      )
  (if (list? s)
      (enum-help 0 s)
      nil
      )
  )
  ; END PROBLEM 17

;; Problem 18
;; List all ways to make change for TOTAL with DENOMS
(define (list-change total denoms)
  ; BEGIN PROBLEM 18
  (define (help total denoms coins)
    (cond
      ((null? denoms) (list))
      ((eq? total 0) (list coins))
      ((< total (car denoms)) (help total (cdr denoms) coins))
      (else (append (help (- total (car denoms)) denoms (append coins (list(car denoms))))
                      (help total (cdr denoms) coins)
                      )
            )
        )
    )
  (help total denoms (list))
  )
  ; END PROBLEM 18

;; Problem 19
;; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define let?    (check-special 'let))

;; Converts all let special forms in EXPR into equivalent forms using lambda
(define (let-to-lambda expr)
  (cond ((atom? expr)
         ; BEGIN PROBLEM 19
         expr
         ; END PROBLEM 19
         )
        ((quoted? expr)
         ; BEGIN PROBLEM 19
         expr
         ; END PROBLEM 19
         )
        ((or (lambda? expr)
             (define? expr))
         (let ((form   (car expr))
               (params (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 19
           (cons form (cons params (map let-to-lambda body)))
           ; END PROBLEM 19
           ))
        ((let? expr)
         (let ((values (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 19
           (append (list (let-to-lambda (list 'lambda (car (zip values)) (car body))))
                 (map let-to-lambda (cadr (zip values))))
           ; END PROBLEM 19
           ))
        (else
         ; BEGIN PROBLEM 19
         (map let-to-lambda expr)
         ; END PROBLEM 19
         )))
