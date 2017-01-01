# 样式

在 *React Native* 中，仍然使用 *JavaScript* 写样式。所有的核心组件都接受名为 *style* 的属性。这些样式名基本上遵循了 web 上的 *css* 的命名，只是按照 js 的语法要求使用驼峰式命名，例如 *backgroundColor* 等。

`style` 属性可以是一个普通的 *JavaScript* 对象。这是最简单的用法，因而在实例代码中很常见。你还可以传入一个数组 - 在数组中位置距后的样式对象比居前的优先级更高，这样你可以间接实现样式的继承。

实际开发中组件的样式会越来越复杂，我们建议使用 `StyleSheet.create` 来集中定义组件的样式。比如像以下代码：

```js
import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  Image,
  ListView,
} from 'react-native';

export default class HelloWorld extends Component {
  render() {
    return (
      <View>
        <Text style={styles.red}>just red</Text> 
        <Text style={styles.bigblue}>just bigblue</Text>
        <Text style={[styles.bigblue, styles.red]}>bigblue, then red</Text>
        <Text style={[styles.red, styles.bigblue]}>red, then bigblue</Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  bigblue: {
    color: 'blue',
    fontWeight: 'bold',
    fontSize: 30,
  },
  red: {
    color: 'red',
  },
});

AppRegistry.registerComponent('HelloWorld', () => HelloWorld);
```

