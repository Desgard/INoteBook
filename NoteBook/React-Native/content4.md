# State - 状态

这次使用两种数据来控制一个定制组件： `props` 和 `state`。`props` 是在父组件中指定，而且一经指定，在被指定的组件的生命周期中则不再改变。对于需要改变的数据（即变量）需要引入 `state`。

一般来说，需要在 `constructor` 中初始化 `state`。然后在需要修改时调用 `setState` 方法。

下例是制作一段不断闪烁的文字实例代码，其做法就是定时改变 `<Text>` 中的文字为空字符串，在定时改回。

```js
class Blink extends Component {
  constructor(props) {
    super(props);
    this.state = { showText: true };
    setInterval(() => {
      this.setState({ showText: !this.state.showText });
    }, 1000);
  }

  render() {
    let display = this.state.showText ? this.props.text : ' ';
    return (
      <Text>{display}</Text>
    );
  }
}

export default class HelloWorld extends Component {
  render() {
    return (
      <View>
          <Blink text='I love to blink' />
          <Blink text='Yes blinking is so great' />
          <Blink text='Why did they ever take this out of HTML' />
          <Blink text='Look at me look at me look at me' />
      </View>
    );
  }
}
```

在实际开发中，我们一般会在定时器函数 `setInterval、setTimeout` 等中来操作 `state` 。典型的场景是在就受到服务器返回的新数据，或者在用户输入数据之后。你也可以使用一些 *状态容器* 比如 *Redux* 来统一管理数据流。`state` 的工作原理和 `React.js` 完全一致，所以对于处理 `state` 的深入细节文档中不再详细介绍。