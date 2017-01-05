# 导航器初步

## Navigator

React Native 目前有几个内置的导航器组件，一般来说首推 `Navigator`。它使用 `JavaScript` 实现了一个导航栈，因此可以跨平台工作，同时也便于定制。

![](http://reactnative.cn/static/docs/0.39/img/NavigationStack-Navigator.gif)

## 场景(Scene)

将一系列摆放在一个而屏幕中的组件，构成一个**场景**。

场景简单的来说时一个全屏的 `React` 组件。与之相对的是单个 `Text` 、`Image` 又或者是你自定义的什么组件，仅仅占据页面中的一部分。你其实已经不知不觉地接触到了场景。

夏目定义一个仅显示一些文本的简单场景。创建一个名为 `MyScene.js` 的文件。

```js
import React, { Component } from 'react';
import { View, Text } from 'react-native';

export default class MyScene extends Component {
  static defaultProps = {
    title: 'MyScene'
  };

  render() {
    return (
      <View>
        <Text>Hi! My name is {this.props.title}.</Text>
      </View>
    )
  }
}
```

我们在 `index.ios.js` 中可以 import 引入该场景。

```js
import React, { Component } from 'react';
import { AppRegistry } from 'react-native';

// ./MyScene表示的是当前目录下的MyScene.js文件，也就是我们刚刚创建的文件
// 注意即便当前文件和MyScene.js在同一个目录中，"./"两个符号也是不能省略的！
// 但是.js后缀是可以省略的

import MyScene from './MyScene';

class YoDawgApp extends Component {
  render() {
    return (
      <MyScene />
    )
  }
}

AppRegistry.registerComponent('YoDawgApp', () => YoDawgApp);
```

其中 `MyScene` 同时也是一个可复用 React 组件的例子。

## 使用 Navigator

渲染 `Navigator` 组件，可尝试导航场景跳转。然后通过该组件的 `renderScene` 属性方法来渲染其他场景。

```js
export default class HelloWorld extends Component {
  render() {
    return (
      <Navigator
        initialRoute={{ title: 'My Initial Scene', index: 0 }}
        renderScene={(route, navigator) =>
          <MyScene
            title={route.title}

            // 进入 +1 的场景           
            onForward={ () => {    
              const nextIndex = route.index + 1;
              navigator.push({
                title: 'Scene ' + nextIndex,
                index: nextIndex,
              });
            }}

            // 进入上一场景
            onBack={() => {
              if (route.index > 0) {
                navigator.pop();
              }
            }}
          />
        }
      />
    )
  }
 }
```

对应的 `MyScene.js` 代码如下：

```js
import React, { Component, PropTypes } from 'react';
import { View, Text, TouchableHighlight } from 'react-native';

export default class MyScene extends Component {
  static propTypes = {
    title: PropTypes.string.isRequired,
    onForward: PropTypes.func.isRequired,
    onBack: PropTypes.func.isRequired,
  }
  render() {
    return (
      <View>
        <Text>Current Scene: { this.props.title }</Text>
        <TouchableHighlight onPress={this.props.onForward}>
          <Text>点我进入下一场景</Text>
        </TouchableHighlight>
        <TouchableHighlight onPress={this.props.onBack}>
          <Text>点我返回上一场景</Text>
        </TouchableHighlight>    
      </View>
    )
  }
}
```

例中，`MyScene` 通过 `title` 属性接受了路由对象中的 title 值。它包含了两个可点击的组件 `TouchableHighligth` ，会在点击时调用 `props` 传入的 `onForward` 或 `onBack` 方法，而这两个方法也分别调用了各自的 `navigator.push()` 和 `navigator.pop()`，从而实现了场景的变换。

  
