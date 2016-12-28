# Django 工程基本结构及常用命令集

Django 在初始化后会将网站开发的常用模块已经写好，通过减少重复的代码，Django 可以让开发者专注在 web 应用模块上。

## 工程文件结构

* urls.py

url 入口，关联到对应的 `views.py` 的每一个函数（或者 `generic 类`），访问网址就对应一个函数。

* views.py

处理用户发出的请求，从 `urls.py` 中对应过来，通过渲染 `templates` 中的页面可以将显示内容输出到网页。

* models.py

数据库对应类结构，类似与 Java Bean。存入或读取数据时用到。

* forms.py(op)

表单处理，用户在浏览器上输入数据进行表单提交时，对数据的验证工作以及输入框的生成等工作。

* admin.py

后台，Django 自带的后台管理部分。

* settings.py

Django 的配置文件。例如：`DEBUG` 开关、静态文件位置等等。

* template 目录

`views.py` 中的函数渲染 `templates` 中的 html 模板，得到动态内容的网页,可以用缓存来提高速度。


### 无 app 时候的工程目录

```shell
mysite
├── manage.py
└── mysite
    ├── __init__.py
    ├── settings.py
    ├── urls.py
    └── wsgi.py
```

### 创建名为 learn 的 App 后对应目录

```shell
learn/
├── __init__.py
├── admin.py
├── models.py
├── tests.py
└── views.py
├── migrations
└── apps.py
``` 





