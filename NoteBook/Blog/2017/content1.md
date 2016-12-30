# Git 中的 ~ 和 ^

> 原文链接：[scarletsky 的 blog](http://scarletsky.github.io/2016/12/29/tilde-and-caret-in-git/?hmsr=toutiao.io&utm_medium=toutiao.io&utm_source=toutiao.io)

## ~ 的作用

在查询 `commit` 编号的时候，一般会执行以下操作：

```git
git log --graph --oneline

* 90055c5 update 2016年12月30日 星期五 18时34分58秒 CST
* 031b9f2 Update README.md
* 71b62a9 Update README.md
* 8f17f7e Update README.md
...
(END)
```

然后选择某个提交，在进行下一步操作。但是如果目的提交为近期提交的话，可以使用 `~` 来直接获得提交记录。例如：

```git
git rev-parse HEAD
90055c5125fe54312c47098f9533ef64a9f5c52b

git rev-parse HEAD~1
031b9f2e6806b9616035dadf5ba9f32c715e5f74

git rev-parse HEAD~
031b9f2e6806b9616035dadf5ba9f32c715e5f74
```

可以看到 `~1` 和 `~` 是等效的，也就是说一个 `~` 符号，代表提交记录前移一位。

但是， git 是存在多分支的，如果本次提交的上一次提交有多个的时候， `~` 只能查找到第一个父提交，录入下图：

```git
$ git log --graph --oneline
* f44239d D
*   7a3fb3d C
|\
| * 07b920c B
|/
* 71bd2cf A
...
```

在这个图中，我们无法通过 `~` 来找到 `07b920c (B)` 这个提交。针对于这种情况，引入了 `^` 标记。找到 `07b920c (B)` 方法是使用 `HEAD~^2`。

`<rev>^<n>` 用来表示一个提交的第 n 个父提交，如果不指定 n，那么默认为 1。和 `~` 不同的是，`HEAD^^^` 等价于 `HEAD^1^1^1` ，而不是 `HEAD^3`。因为没多一个符号，默认的就向父层询问，描述的不是同级关系。

最后给一张好玩的图，来自 *Jon Loeliger* 的 [kernel.org](kernel.or) :

```git
G   H   I   J
 \ /     \ /
  D   E   F
   \  |  / \
    \ | /   |
     \|/    |
      B     C
       \   /
        \ /
         A
A =      = A^0
B = A^   = A^1     = A~1
C = A^2  = A^2
D = A^^  = A^1^1   = A~2
E = B^2  = A^^2
F = B^3  = A^^3
G = A^^^ = A^1^1^1 = A~3
H = D^2  = B^^2    = A^^^2  = A~2^2
I = F^   = B^3^    = A^^3^
J = F^2  = B^3^2   = A^^3^2
```


