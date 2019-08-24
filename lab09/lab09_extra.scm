;; Extra Scheme Questions ;;

; Q5
(define lst
  (list (list 1) 2 '(3 . 4) 5)
)

; Q6
(define (composed f g)
  'YOUR-CODE-HERE
  (lambda (x) (f (g x)))
)

; Q7
(define (remove item lst)
  'YOUR-CODE-HERE
  (if (null? lst)
      (list)
      (filter (lambda (x) (not(= item x))) lst)
  )
)


;;; Tests
(remove 3 nil)
; expect ()
(remove 3 '(1 3 5))
; expect (1 5)
(remove 5 '(5 3 5 5 1 4 5 4))
; expect (3 1 4 4)

; Q8
(define (max a b) (if (> a b) a b))
(define (min a b) (if (> a b) b a))
(define (gcd a b)
  'YOUR-CODE-HERE
  (if (= (min a b) 0)
      (max a b)
      (if (= (/ (max a b) (min a b)) 0)
          (min a b)
          (gcd b (modulo a b))
      )
  )
)

;;; Tests
(gcd 24 60)
; expect 12
(gcd 1071 462)
; expect 21

; Q9
(define (no-repeats s)
  'YOUR-CODE-HERE
  (if (null? s)
      s
      (cons (car s) (no-repeats (remove (car s) s)))
  )
)

; Q10
(define (substitute s old new)
  'YOUR-CODE-HERE
  (if (null? s)
      s
      (if (pair? (car s))
          (cons (substitute (car s) old new) (substitute (cdr s) old new))
          (if (eq? old (car s))
              (cons new (substitute (cdr s) old new))
              (cons (car s) (substitute (cdr s) old new))
          )
      )
  )
)

; Q11
(define (sub-all s olds news)
  'YOUR-CODE-HERE
  (if (null? s)
      s
      (if (null? olds)
          s
          (sub-all (substitute s (car olds) (car news)) (cdr olds) (cdr news))
      )
  )
)
