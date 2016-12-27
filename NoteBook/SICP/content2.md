# 构造数据抽象

## 序对

为了在具体的表面上实现这一数据抽象，*scheme* 提供了一种称为 **序对** 的复合结构，这种结构可以通过 `cons` 构造出来。过程 `cons` 取两个参数，返回一个包含这两个参数作为其成分的符合数据对象。其实个人理解就是二维数据描述，可以抽象的理解成平面点。

给出一个序对，可以用基本过程 `car` 和 `cdr` 方式取出。

```lisp
(define x (cons 1 2))

(car x)
1

(cdr x)
2
```

从序对构造起来的数据对象称为 **表结构** 数据。

## 有理数表示

序对为完成有理数系统提供了一种自然方式，可以将有理数简单表示为两个整数（分子和分母）的序对。这样就很容易做出以下实现：

```lisp
(define (make-rat n d) (cons n d))
(define (numer x) (car x))
(define (denom x) (cdr x))
(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))
```

任何一个有理数都可以被分数从数值上表示，所以只要模拟分数的运算，我们就可以描述有理数集。

定义分数的四则运算法则：

```lisp
(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (sub-rat x y)
  (make-rat (- (* (numer x) (numer y))
               (* (numer y) (numer x)))
            ( * (denom x) (denom y))))

(define (mul-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))

(define (div-rat x y)
  (make-rat (* (numer x) (denom y))
            (* (denom x) (numer y))))

(define (equal-rat x y)
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))
```

对于分数还需要将分子分母化简为最简形式，所谓分数中的约分操作。这里只要使用 *GCD* 算法，找出分子分母的最大公约数即可。

```lisp
(define (gcd a b) 
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (make-rat-sim n d)
  (let ((g (gcd n d)))
    (cons (/ n g) (/ d g))))
```

> **练习2.1** 请定义出 `make-rat` 的一个更好的版本，使之可以正确处理正数和负数。当有理数为正时，`make-rat` 应当将其规范化，使它的分子和分母都是正的。如果有理数为负，那么就应只让分子为负。

就是一个简单的判断。

```lisp
(define (make-rat-sig n d)
    (if (< d 0)
        (cons (- n) (- d))
        (cons n d)))
```