# 构造过程抽象

> *练习1.2* 请将下面表达式变换为前缀形式：


$$\frac{5+4+(2-(3-(6+\frac{4}{6})))}{3(6-2)(2-7)}$$

<br />

### 题解

```lisp
(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5)))))
   (* 3 (- 6 2) (- 2 7)))
```

<br />

> *练习1.3* 请定义一个过程，它以三个数为参数，返回其中较大的两个数之和。

<br />

### 题解

```lisp
(define (min2 x y) (if (> x y) y x))
(define (min3 x y z) (if (< (min2 x y) (min2 y z)) (min2 x y) (min2 y z)))
(define (func x y z) (- (+ x y z) (min3 x y z)))
```

<br />

> *练习1.4* 请仔细观察上面给出的允许运算符为符合表达式的组合式的求值模型，根据对这一模型的认识描述下面过程的行为：

```lisp
(define (a-plus-abs-b a b)
	((if (> b '0') + -) a b))
```

<br />

### 题解

这是一个讲述高阶函数的例子。在 `if` 判断部分，如果当 `b > '0'` 的时候，则函数返回 `a + b` 的结果。而当 `b < 0` 的时候，则返回 `a - b` 的结果。综上可以看出，这个函数的返回结果式为：

$$a + |b|$$

<br />

> *练习1.5* Ben Bitdiddle 发明了一种检测方法，能够确定解释器究竟采用哪种序求值，是采用应用序还是采用正则序。他定义了下面两个过程：

```lisp
(define '(p)' (p))
(define (test x y) 
	(if (= x '0')
		'0'
		y))
```

> 而后他求职下面的表达式：

```lisp
(test '0' '(p)')
```

> 如果某个解释器采用的是应用序求值，Ben 会看到什么样的情况？如果解释器采用正则去求值，他优惠看到什么情况？请你对你的回答做出解释。（无论采用正则序或者应用序，假定特殊形式 `if` 的求值规则总是一样的。其中的谓词部分先行求值，根据其结果确定随后求值的子表达式部分。）

<br />

### 题解

引用[这里的答案](http://sicp.readthedocs.io/en/latest/chp1/5.html)。
首先，可以确定的是，无论解释器使用的是什么求值方式，调用 '(p)' 总是进入一个无限循环(infinite loop)，因为函数 p 会不断调用自身：

```lisp
(define '(p)' (p))
```

具体到解释器中，执行 '(p)' 调用会让解释器陷入停滞，最后只能强制将解释器进程杀掉：

```lisp
1 ]=> '(p)'
^Z
[1]+  已停止               mit-scheme
$ killall mit-scheme
```


在应用序中，所有被传入的实际参数都会立即被求值，因此，在使用应用序的解释器里执行`(test '0' '(p)')` 时，实际参数`0` 和`(p)` 都会被求值，而对 `(p)` 的求值将使解释器进入无限循环，因此，如果一个解释器在运行 Ben 的测试时陷入停滞，那么这个解释器使用的是应用序求值模式。

另一方面，在正则序中，传入的实际参数只有在有需要时才会被求值，因此，在使用正则序的解释器里运行 `(test) 0 (p)` 时， `0` 和 `(p)` 都不会立即被求值，当解释进行到 `if` 语句时，形式参数 `x` 的实际参数(也即是 `0`)会被求值(求值结果也是为 `0` )，然后和另一个 `0` 进行对比`((= x 0))`，因为对比的值为真(#t),所以 `if` 返回 `0` 作为值表达式的值，而这个值又作为 `test` 函数的值被返回。

因为在正则序求值中，调用 `(p)` 从始到终都没有被执行，所以也就不会产生无限循环，因此，如果一个解释器在运行 Ben 的测试时顺利返回 `0` ，那么这个解释器使用的是正则序求值模式。

<br />

> *练习1.6* Alyssa P. Hacker 看不出为什么需要将 `if` 提供为一种特殊形式，她问：“为什么我不能通过 `cond` 将它定义为一个常规过程呢？” Alyssa 的朋友 Eva Lu Ator 断言确实可以这样做，并定义了 if 的一个新版本：

```lisp
(define (new-if predicate then-clause else-clause)
	cond (predicate then-clause)
		(else else-clause))
```

> Eva 给 Alyssa 演示她的程序：

```lisp
(new-if (= 2 3) 0 5)
5
(new-if (= 1 1) 0 5)
0
```

> 她很高兴的用自己的 `new-if` 重写了求平方根的程序：

```lisp
(define (sqrt-iter guess x)
	(new-if (good-enough? guess x)
		guess
		(sqrt-iter (improve guess x)
			x)))
```

> 当 Alyssa 试着用这个过程去计算平方根时会发生什么事情呢？请给出解释。

<br />

### 题解

在 `sqrt-iter` 函数中，会出现递归调用。当函数调用栈很大而超过内存的最大负载时，则会出现栈溢出的情况。

<br />

> *练习1.8* 求立方根的牛顿法基于如下事实，如果 $$y$$ 是 $$x$$ 的立方根的一个近似值，那么下式将给出一个更好的近似值：

$$\frac{\frac{x}{y^2}+2y}{3}$$

> 请利用这一公式实现一个类似平方根过程的求立方根的过程。

<br />

### 题解

```lisp
# 定义基本函数
(define (square x) (* x x))
(define (cube x) (* x x x))

# 题目改进函数
(define (improve g x)(/ (+ (/ x (square g)) (* 2 g)) 3))

# 精度判断函数
(define (good-enough? test num) (< (abs (- (cube test) num)) 0.001))

# 主执行函数
(define (CubeRoot-iter guess x)
  (if (good-enough? guess x)
      guess
      (CubeRoot-iter (improve guess x) x)
  )
)

# 对外接口，用 1 先去探测
(define (CubeRoot x) (CubeRoot-iter 1 x))

```

<br />

> *练习1.11* 函数 $$ f $$ 由如下的规则定义：如果 $$ n < 3 $$，那么 $$ f(n) = n $$；如果 $$ n \ge 3 $$ ，那么 $$ f(n) = f(n - 1) + 2f(n - 2) + 3f(n - 3) $$。请写一个采用递归计算过程计算 $$ f $$ 的过程。再写一个采用迭代计算过程计算 $$ f $$ 的过程。

<br />

### 题解

#### 递归写法

```lisp
(define (func x)
  (cond ((= x 0) 0)
        ((= x 1) 1)
        ((= x 2) 2)
        ((= x 3) 3)
        (else (+ (func (- x 1)) (* 2 (func (- x 2))) (* 3 (func (- x 3)))))
))
```

#### 迭代写法

```lisp
(define (f n)
  (f-iter 2 1 0 0 n))

(define (f-iter x y z cnt n)
  (if (= cnt n)
      z
      (f-iter (+ x (* 2 y) (* 3 z))
              x
              y
              (+ cnt 1)
              n)))
```

<br />

> *练习1.12* 下面数值模式成为*杨辉*三角形：

```lisp
            1
           1 1
          1 2 1
         1 3 3 1
        1 4 6 4 1
```

> 三角形边界上上的书都是1，内部的每个数是位于它上面的恋歌书之和。请写一个过程用递归计算出杨辉三角形。

<br />

### 题解

规定：杨辉三角第一行一个元素的下标为 `pasca(1, 1)`。用二维下标来描述每一个元素。则我们的递归程序用 `pasca(x, y)` 来描述每一个元素。

```lisp
(define (pasca x y)
  (if (= x 1)
      (if (= y 1)
          1
          0
          )
  (+ (pasca (- x 1) y) (pasca (- x 1) (- y 1)))
))
```

<br />

> *练习1.16* 请定义一个过程，它能产生出一个按照迭代方式的求幂计算过程，其中使用一系列求平方，就像一样 `fast-expt` 只用对数个步骤那样。

<br />

### 题解

其实就是一个快速幂的迭代过程。

```lisp
(define (square x) (* x x))

(define (even n)
  (= (remainder n 2) 0))

(define (expt-iter b n a)
  (cond ((= n 0)
         a)
        ((even n)
         (expt-iter (square b)
                    (/ n 2)
                    a))
        ((odd? n)
         (expt-iter b
                    (- n 1)
                    (* b a)))))

(define (fast-expt b n) (expt-iter b n 1))
```

<br />

> *联系1.17* 本书里的求幂算法的基础就是通过反复做乘法去求乘幂。于此类似，也可以通过反复做加法的方式求出成绩。下面的成绩过程与 `expt` 过程类似（其中假定我们的语言只有加法而没有乘法）：

```lisp
(define (* a b)
    (if (= b 0)
        0
        (+ a (* a (- b 1)))))
```

这一算法具有相对于 `b` 的线性步数。现在假定除了加法之外还有运算 `double`，它能求出一个整数的两倍；还有 `halve` ，它讲一个（偶数）除以2。请用这些运算设计一个类似 `fast-expt` 的求值过程，使之之用对数的计算步数。

### 题解

<br />

两个判断流程，如果是偶数，则进行整体乘2，乘数除以2的操作。如果是奇数，则外加一内减一操作。

```lisp 
(define (isEven n)
  (= (remainder n 2) 0))

(define (isOdd n)
  (= (remainder n 2) 1))

(define (double n)
  (+ n n))

(define (halve n)
  (/ n 2))

(define (multi a b)
  (cond ((= b 0)
         0)
        ((isEven b)
         (double (multi a (halve b))))
        ((isOdd b)
         (+ a (multi a (- b 1))))))
```

<br />

> *练习1.18* 利用练习 *1.16* 和 *1.17* 的结果设计一个过程，它能产生出一个基于加、加倍和折半的迭代计算过程，只用对数的步数就能求出两个整数的乘积。

<br />

### 题解



将递归过程改写为迭代过程。

```lisp
(define (isEven n)
  (= (remainder n 2) 0))

(define (isOdd n)
  (= (remainder n 2) 1))

(define (double n)
  (+ n n))

(define (halve n)
  (/ n 2))

(define (multi a b )
  (multi-iter a b 0))

(define (multi-iter a b p)
  (cond ((= b 0)
         p)
        ((isEven b)
         (multi-iter (double a)
                     (halve b)
                     p))
        ((isOdd b)
         (multi-iter a
                     (- b 1)
                     (+ a p)))))
```

