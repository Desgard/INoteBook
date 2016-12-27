# 开始上手 React-Native

## 创建一个 React-Native 项目

* 安装命令行工具：

```bash
sudo npm install -g react-native=cli
```

* 创建一个 *hello world* 项目

```bash
react-native init HelloWorld
```

* 使用 Simulator 来运行初始化工程

```bash
react-native run-ios
```

## HelloWorld 代码阅读

```js
import React, { Component } from 'react';
import { AppRegistry, Text } from 'react-native';

class HelloWorldApp extends Component {
  render() {
    return (
      <Text>Hello world!</Text>
    );
  }
}

// 注意，这里用引号括起来的'HelloWorldApp'必须和你init创建的项目名一致
AppRegistry.registerComponent('HelloWorldApp', () => HelloWorldApp);
```

在 *react native* 中内置了对 ES6 的语法标准，可以放心使用并且无需担心兼容性问题。

在实例中的 `<Text>Hello world!</Text>` 这一行称作 **JSX** 语法，这是一种在 *JavaScript* 中嵌入 *XML* 结构的语法。很多传统的应用框架会设计自由的模板语法，是的在结构标记中嵌入代码。而 *React* 相反，设计的 *JSX* 语法却是在代码中嵌入结构标记。而该例中的内置的 `<Text>` 组件，专门用来显示文本。

代码中的最后一行：

```js
AppRegistry.registerComponent('HelloWorldApp', () => HelloWorldApp);
```

定义了一个名为 `HelloWorldApp` 的新的**组件（Component）**，并且使用了名为 **AppRegistry** 的内置模块进行 *Register* 操作。在编写 *react-native* 应用时，肯定会写出很多新的组件。而一个 App 的最终界面，其实也是各种组件的组合。组件本身结构可以非常简单，唯一必须的就是在 `render` 方法中返回一个用于渲染结构的 *JSX* 语句。

