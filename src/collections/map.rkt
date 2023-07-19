#lang racket/base

(require (prefix-in List. "../collections/list.rkt")
         "../globals.rkt")

(define (add key value table)
  (hash-set table key value))

(define (change key f table)
  (hash-update table key f))

(define (contains-key key table)
  (hash-has-key? table key))

(define (count table)
  (hash-count table))

(define (empty)
  (hash))

(define (exists predicate table)
  (> (count (filter predicate table)) 0))

(define (map mapping table)
  (hash-map/copy table mapping))

(define (map-filter predicate acc pair)
  (if (predicate pair) (add (car pair) (cdr pair) acc) acc))

(define (filter predicate table)
  (fold (fn (acc pair) (map-filter predicate acc pair)) (empty) table))

(define (find key table)
  (hash-ref table key))

(define (fold folder state table)
  (let loop ([index 0] [folder folder] [state state] [table table])
    (cond
      [(= index (count table)) state]
      [#t (loop (add1 index) folder (folder state (hash-iterate-pair table index)) table)])))

(define (to-list table)
  (hash-map table (fn (key value) (list key value))))

(define (to-array table)
  (List.to-array (hash-map table (fn (key value) (list key value)))))

(provide (all-defined-out)
         (except-out map-filter))

(module+ test
  (require rackunit)
  (define table (hash 1 "one"))
  (define add-table (hash "one" 1 "two" 2 "three" 3))
  (check-equal? (add 2 "two" table) (hash 1 "one" 2 "two"))
  (check-equal? (change 1 (fn (_) "three") table) (hash 1 "three"))
  (check-true (contains-key 1 table))
  (check-eq? (count table) 1)
  (check-equal? (empty) (hash))
  (check-equal? (to-list table) (list (list 1 "one")))
  (check-equal? (to-array table) (vector (list 1 "one")))
  (check-equal? (map (fn (key value) (values (add1 key) value)) table) (hash 2 "one"))
  (check-equal? (fold (fn (acc pair) (+ (cdr pair) acc)) 0 add-table) 6)
  (check-equal? (filter (fn (pair) (> (cdr pair) 1)) add-table) (hash "two" 2 "three" 3))
  (check-true (exists (fn (x) (equal? (car x) "one")) add-table))
  (check-equal? (find "one" add-table) 1))