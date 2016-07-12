(defun my-last(lst)
	(if (consp (cdr lst))
		(my-last(cdr lst))
		lst
	)
)

(defun my-but-last(lst)
	(if	(> (length lst) 2)
		(my-but-last (cdr lst))
		lst
	))

(defun my-element(lst num)
	(car (subseq lst (- num 1)))
)

(defun my-length(lst)
	(if	(equal lst nil)
		0
		(+ 1 (my-length (cdr lst)))
	))

(defun my-reverse(lst)
(labels 
((
f (lst)
	(if (consp lst)
		(append (f (cdr lst)) (subseq lst 0 1))
	)))
	(f lst)))

(defun my-palindrome(lst)
(let ((mid (/ (length lst) 2)))
	(if (equal (subseq lst 0 (floor mid)) (reverse (subseq lst (ceiling mid))))
		'PALINDROME
		'NOT-PALINDROME
	)))

(defun my-flatten(lst)
	(if (consp lst)
		(if	(listp (car lst)) 
			(append (my-flatten (car lst)) (my-flatten (cdr lst)))
			(cons (car lst) (my-flatten (cdr lst)))
		)))

(defun my-compress(lst)
	(if (consp lst)
		(if	(equal (car lst) (cadr lst))
			(compress (cdr lst))
			(cons (car lst) (compress (cdr lst)))
		)
		nil))

;---------------------------------------------------------------------------------------
(defun my-pack(lst)
	(if (consp lst)
		(if	(listp (car lst)) 
			(cons (car lst) (my-pack (cdr lst)))
			(my-pack-length (car lst) '() lst)
		)
		lst))			
		
(defun my-pack-length(obj rest lst)
	(if	(equal obj (car lst))
		(my-pack-length obj (cons obj rest) (cdr lst))
		(my-pack (cons rest lst))
	))		
;---------------------------------------------------------------------------------------

(defun my-encode2(lst)
	(do ((i 0 (+ i 1)) (len (length lst)) (my-lst '()) (j 0))
		((>= i len) (reverse my-lst))
		(if	(equal (nth i lst) (nth (+ i 1) lst))
			(incf j)
			(progn
				(push (list (+ j 1) (nth i lst)) my-lst)
				(setf j 0)
			))))

(defun my-encode-modified(lst)
	(do ((i 0 (+ i 1)) (len (length lst)) (my-lst '()) (j 0))
		((>= i len) (reverse my-lst))
		(if	(equal (nth i lst) (nth (+ i 1) lst))
			(incf j)
			(if	(> j 0)
				(progn
					(push (list (+ j 1) (nth i lst)) my-lst)
					(setf j 0)
				)
				(push (nth i lst) my-lst)
			))))

(defun my-decode(lst)
	(do ((i 0 (+ i 1)) (len (length lst)) (my-lst '()))
		((>= i len) (reverse my-lst))
		(if	(listp (nth i lst))
			(do ((j 0 (+ j 1)))
				((>= j (car (nth i lst))))
				(push (cadr (nth i lst)) my-lst)
			)
			(push (nth i lst) my-lst)
		)))

(defun my-dupli(lst)
	(do ((i 0 (+ i 1)) (len (length lst)) (my-lst '()))
		((>= i len) (reverse my-lst))
		(loop repeat 2 do(push (nth i lst) my-lst))
	))

(defun my-repli(lst num)
	(do ((i 0 (+ i 1)) (len (length lst)) (my-lst '()))
		((>= i len) (reverse my-lst))
		(loop repeat num do(push (nth i lst) my-lst))
	))

(defun my-drop(lst num)
(labels 
((f (acc)
	(if	(< (- (* acc num) 1) (length lst))
		(append (subseq lst (- (* acc num) num) (- (* acc num) 1)) (f (1+ acc)))
		(append (subseq lst (- (* acc num) num) (length lst)))
	)
))
	(f 1)))

(defun my-split(lst num)
	(list (subseq lst 0 num) (subseq lst num (length lst)))
)

(defun my-slice(lst num1 num2)
	(if (> num1 0)
		(subseq lst (- num1 1) num2)
		nil
	))
	
(defun my-rotate-x(lst modn)
	(if (> modn 0)
		(cons (car lst) (my-rotate-x (cdr lst) (1- modn)))
	))

(defun my-rotate(lst num)
(if (= num 0)
	lst
	(let* ((modn (mod num (length lst))) (eins (nthcdr modn lst)))	
		(append eins (my-rotate-x lst modn))
	)))	

(defun my-remove-at(lst num)
	(append (subseq lst 0 (- num 1)) (subseq lst num (length lst)))
)

(defun my-insert-at(sym lst num)
	(append (subseq lst 0 (- num 1)) (list sym) (subseq lst (- num 1) (length lst)))
)

(defun my-range(num1 num2)
	(if	(< num1 num2)
		(if (equal num1 num2)
			(cons num1 nil)
			(cons num1 (my-range (+ num1 1) num2))
		)
		(if	(equal num1 num2) 
			(cons num1 nil)
			(cons num1 (my-range (- num1 1) num2))
		)))

(defun my-rnd-select(lst num)
	(if	(> num 1)
		(progn 
			(setf rnd (+ (random (length lst)) 1)) 
			(cons 	(nth (- rnd 1) lst) 
					(my-rnd-select (append (subseq lst 0 (- rnd 1)) (subseq lst rnd (length lst))) (- num 1))
			)
		)
		(cons (nth (random (length lst)) lst) nil)
	))

(defun my-lotto-select(num1 num2)
	(my-rnd-select (my-range 1 num2) num1)
)

(defun my-rnd-permu(lst)
	(my-rnd-select lst (length lst))
)
;---------------------------------------------------------------------------------------
(defun my-combination-y(num lst)
	(if (> num 0)
		(cons (car lst) (my-combination-y (1- num) (cdr lst)))
	))

(defun my-combination-x(num lst len)
	(if	(>= len num)
		(cons (my-combination-y num lst) (my-combination-x num (my-remove-at lst num) (- len 1)))
	))
	
(defun my-combination(num lst)
	(if (consp lst)
		(append (my-combination-x num lst (length lst)) (my-combination num (cdr lst)))
	))	
;---------------------------------------------------------------------------------------
(defun my-lsort(lst)
	(sort lst #'< :key #'length))

(defun my-lfsort-encode(lst rest num)
	(if (consp lst)
		(if (= (length (first lst)) (length (second lst)))
			(my-lfsort-encode (cdr lst) (cons (car lst) rest) (1+ num))
			(cons (cons (car lst) rest) (my-lfsort-encode (cdr lst) '() 0))
		)))
	
(defun my-lfsort(lst)
	(apply #'append (my-lsort (my-lfsort-encode (my-lsort lst) '() 0))))
;---------------------------------------------------------------------------------------
