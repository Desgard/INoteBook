# Props - 属性

大多数组件在创建时可以使用各种参数来进行定制。用于定制的这些参数就称为 `props` 属性。

以基础组件 `Image` 为例，在创建图片的时候传入一个 `source` 的属性来指定显示图片的 url，使用 `style` 属性来控制尺寸。

```js
import React, { Component } from 'react';
import { AppRegistry, Image } from 'react-native';

class Bananas extends Component {
  render() {
    let pic = {
      uri: 'https://upload.wikimedia.org/wikipedia/commons/d/de/Bananavarieties.jpg'
    };
    return (
      <Image source={pic} style={{width: 193, height: 110}} />
    );
  }
}

AppRegistry.registerComponent('Bananas', () => Bananas);
```

在 `{pic}` 外面有一对花括号，代表将变量嵌入到 *JSX* 语句中。括号的意思是括号内部为一个 *JavaScript* 变量或表达式，需要执行后取值。因此可以将任意合法的 *JavaScript* 表达式通过括号嵌入到 *JSX* 语句中。括号的意思是括号内部为一个 *JavaScript* 变量或表达式，需要执行后取值。所以可以把合法的 *JavaScript* 表达式通过括号嵌入到 *JSX* 语句中。

自定义组件也可以使用 `props` 属性。定制属性可提高复用。`this.props` 可以获取组件的 `props`。

```js
import React, { Component } from 'react';
import { AppRegistry, Text, View } from 'react-native';

class Greeting extends Component {
  render() {
    return (
      <Text>Hello {this.props.name}!</Text>
    );
  }
}

class LotsOfGreetings extends Component {
  render() {
    return (
      <View style={{alignItems: 'center'}}>
        <Greeting name='Rexxar' />
        <Greeting name='Jaina' />
        <Greeting name='Valeera' />
      </View>
    );
  }
}

AppRegistry.registerComponent('LotsOfGreetings', () => LotsOfGreetings);
```