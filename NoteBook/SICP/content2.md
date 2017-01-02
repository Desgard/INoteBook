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

## 抽象屏障

数据抽象的基本思想：**为每一类数据标识出一组操作，使得对这类数据对象的所有操作都可以基于它们描述，而且在操作这些数据对象事业只能使用它们**。

数据抽象的思想其实就是一种面向对象的封装性，只对外提供可操作的主动暴露的接口，从而保证并维护原数据的安全性和稳定性。**抽象屏障**就是如此，通过接口通道限制性的控制内部数据。这时一种高度封装的典型描述。

> **练习2.2** 请考虑平面上线段的表示问题。一个线段用一对点表示，它们分别时线段的起点和终点。请定义构造函数 `make-segment` 和选择函数 `start-segment` 、 `end-segment` ，它们基于点定义线段的表示，序对的两个成分分别表示点的 x 坐标和 y 坐标。请据此进一步给出构造 `make-segment` 和选择函数 `x-point` 、 `y-point`，用它们定义出点的这种表示。最后请基于所定义的构造函数和选择函数，定义出过程 `midpoint-segment`，它以一个线段为参数，返回线段的中点。

打印点的方式：

```lisp
(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))
```

先对点进行描述性定义：

```lisp
(define (make-point x y)
    (cons x y))

(define (x-point p)
    (car p))

(define (y-point p)
    (cdr p))
```

完成对线段的定义：

```lisp
(define (make-segment start-point end-point)
  (cons start-point end-point))

(define (start-segment seg)
    (car seg))

(define (end-segment seg)
    (cdr seg))
```

完成线段中点描述定义：

```lisp
(define (midpoint-segment seg)
    (let ((start (start-segment seg))
          (end (end-segment seg)))
        (make-point (average (x-point start)
                             (x-point end))
                    (average (y-point start)
                             (y-point end)))))

(define (average x y)
    (/ (+ x y)
       2.0))
```

> **练习2.3** 请实现一种平面矩形的表示（提示：你有可能用练习2.2的结果）。基于你的构造函数和选择函数定义几个过程，计算给定矩形的周长和面积等。现在请再为矩形实现另一种表示方式。你应该怎样设计系统，使之能提供适当的抽象屏障，使同一个周长或者面积过程对两种不同表示都能工作？

很显然可以把一个矩形使用 4 个线段进行描述：

```lisp
(define (make-rectangle l1 l2 w1 w2)
  (cons (cons l1 l2)
        (cons w1 w2)))

(define (l1-rectangle r)
  (car (car r)))

(define (l2-rectangle r)
  (cdr (car r)))

(define (w1-rectangle r)
  (car (cdr r)))

(define (w2-rectangle r)
  (cdr (cdr r)))
```

这里的 `l1`, `l2`, `w1`, `w2` 为上一题的点描述，用一个 $$2\times2\times2$$ 的嵌套序对可描述四个线段。

对信息进行输出格式化：

```lisp
(define (print-rectangle r)
    (let ((l1 (length-1-rectangle r))
          (l2 (length-2-rectangle r))
          (w1 (width-1-rectangle r))
          (w2 (width-2-rectangle r)))

        (newline)
        (display "Length 1:")
        (print-point (start-segment l1))
        (print-point (end-segment l1))

        (newline)
        (display "Length 2:")
        (print-point (start-segment l2))
        (print-point (end-segment l2))

        (newline)
        (display "Width 1:")
        (print-point (start-segment w1))
        (print-point (end-segment w1))

        (newline)
        (display "Width 2:")
        (print-point (start-segment w2))
        (print-point (end-segment w2))))
```

测试输出结果：

```lisp
(print-rectangle
(make-rectangle
 (make-segment (make-point 1 4)
               (make-point 4 4))
 (make-segment (make-point 1 2)
               (make-point 4 2))
 (make-segment (make-point 1 2)
               (make-point 1 4))
 (make-segment (make-point 4 2)
               (make-point 4 4)))
)
> Length 1:
(1,4)
(4,4)
Length 2:
(1,2)
(4,2)
Width 1:
(1,2)
(1,4)
Width 2:
(4,2)
(4,4)
```


## 数据意味着什么

从一般意义上讲，数据即是由给定的构造函数和选择函数所实现的东西。从高度数据模型的抽象角度来说，表示复合数据的能力，其实时一种过程。在程序设计风格中通常将复合数据的抽象过程称之为 **消息传递**。

> **练习2.4** 下面时序对的另一种过程性表示方式。请针对这一表示验证，对于任意的 x 和 y，`(car (cons x y))` 都将产生出 x。

```lisp
(define (cons x y)
  (lambda (m) (m x y)))

(define (car z)
  (z (lambda (p q) p)))
```

> 对应的 `cdr` 应该如何定义？

表达式 ` (car (cons 1 2))` 的展开序列：

```lisp
(car (cons 1 2))

(car (lambda (m) (m 1 2)))          ; 展开 cons

((lambda (z) (z (lambda (p q) p)))  ; 展开 car ，代换 z
    (lambda (m) (m 1 2)))

((lambda (m) (m 1 2))               ; 代换 m
    (lambda (p q) p))

((lambda (p q) p)                   ; 代换 p
```


根据 car 的定义，以及上面的展开序列给出的线索，我们可以写出对应的 cdr 函数：

```lisp
(define (cdr z)
    (z (lambda (p q) q)))
```

> **练习2.5** 请证明，如果 a 和 b 的序对表示为乘积 $$2^a$$ $$3^b$$ 对应的整数，我们就可以只用非负整数和算数运算表示序对。请给出对应的过程 cons、car 和 cdr 的定义。

根据题意，构造序对为两个乘幂之间的乘积：

```lisp
(define (cons x y)
    (* (expt 2 x)
       (expt 3 y)))
```

由于我们将一个数 x 描述成：$$x = 2 \times 2 \times ... \times 2 \times 3 \times ... \times 3$$，2 和 3 是两个互质数，那么就可以直接对序对结果反复除以 2 或者 3 来描述取前值和后值操作。

```lisp

(define (car z)
    (if (= 0 (remainder z 2))
        (+ 1 (car (/ z 2)))
        0))


(define (cdr z)
    (if (= 0 (remainder z 3))
        (+ 1 (cdr (/ z 3)))
        0))
``` 

> **练习2.6** 请考虑在一个可以对过程做各种操作的语言里，我们完全可以没有数（至少在考虑非负整数的情况下），可以将 0 和加一操作实现为：

```lisp
(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))
```

> 这一表示形式称为 *Church* 计数，名字来源于其发明人数理逻辑学家 *Alonzo Church*，$$\lambda$$是他发明的。
> 请直接定义 one 和 two （提示：利用代换去求值）。请给出加法过程+的一个直接定义。

对于 one 的定义可以用 zero 来替换 add-one 中的参数。

```lisp
(add-1 zero)

(add-1 (lambda (f)
           (lambda (x)
               x)))

((lambda (n)                    ; add-1
     (lambda (f)
         (lambda (x)
             (f ((n f) x)))))
 (lambda (f)                    ; zero
     (lambda (x)
         x)))

(lambda (f)
    (lambda (x)
        (f (
            ((lambda (f)        ; zero
                 (lambda (x)
                     x))
             f)
            x))))

(lambda (f)
    (lambda (x)
        (f ((lambda (x) x)
            x))))

(lambda (f)
    (lambda (x)
        (f x)))
```

反向展开可以得出 one 的定义。

```lisp
(define one
    (lambda (f)
        (lambda (x)
            (f x))))
```

同理将 one 当做参数传入 add-one：

```lisp
(define two
    (lambda (f)
        (lambda (x)
            (f (f x)))))
```


## 扩展练习：区间算数

将数据从单个变成序对的区间运算。并且给出了基本的运算规则描述：

```lisp
(define (add-interval x y)  
  (make-interval (+ (lower-bound x) (lower-bound y))  
         (+ (upper-bound x) (upper-bound y))))  

(define (mul-interval x y)
  let ((p1 (* (lower-bound x) (lower-bound y)))
       (p2 (* (lower-bound x) (upper-bound y)))
       (p3 (* (lower-bound x) (lower-bound y)))
       (p4 (* (lower-bound x) (upper-bound y))))
  (make-interval (min p1 p2 p3 p4)
                 (max p1 p2 p3 p4)))

(define (div-interval x y)
  (mul-interval x
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))
```

> **练习2.7** *Alyssa* 的程序是不完整的，因为她还没有确定区间抽象的实现。这里是区间构成符的定义：

```lisp
(define (make-interval a b) (cons a b))
```

> 请定义选择符 `upper-bound` 和 `lower-bound` ，完成这一实现。

```lisp
(define (lower-bound x)  
  (car x))  
  
(define (upper-bound x)  
  (cdr x))  
```


