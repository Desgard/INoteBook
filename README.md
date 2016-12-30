# INoteBook

![](https://img.shields.io/travis/USER/REPO.svg)
![](https://img.shields.io/badge/gitbook-v3.2.2-green.svg)
![](https://img.shields.io/aur/license/yaourt.svg)

![](http://7xwh85.com1.z0.glb.clouddn.com/INoteBook.png)

## Description

基于 Gitbook 的个人笔记自动化发布 pages 的 **shell脚本**。

## Usage

利用 `start.sh` 和 `update.sh` 动态更新 Gitbook 项目的简单操作。

在上传至 Github 之前，先使用 `start.sh` 进行 Gitbook 生成静态页代码检查.

```shell
bash start.sh
```
会在上层目录 (`./..`) 生成一个 `NG-gitbook` 目录，里面存有 `gitbook build` 的所有静态页。
然后更新 `gh-pages` 的分支，直接运行以下命令：

```shell
bash update.sh
```
修改远程仓库的 git 地址，请修改 `start.sh` 中的 `CONFIG_REMOTE_URL` 参数即可。

## GNU GENERAL PUBLIC LICENSE

Version 3, 29 June 2007

Copyright (C) 2007 Free Software Foundation, Inc. <http://fsf.org/> 
Everyone is permitted to copy and distribute verbatim copies of this license document, but changing it is not allowed.
