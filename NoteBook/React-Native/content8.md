# 处理文本输入

`TextInput` 是一个允许用户输入文本的基础组件。它有一个名为 `onChangeText` 的属性，次属性接受一个函数，而此函数会在文本变化时被调用。另外还有一个名为 `onSubmitEditing` 的属性，会在文本被提交后（用户按下软键盘上的提交键）调用。

胶乳我们要实现当用户输入时，将其以单词为单位翻译为另一种文字。我们假设这另一种文字是一堆有趣的东西：💩。

```js
export default class HelloWorld extends Component {
  constructor(props) {
    super(props);
    this.state = {text: ''};
  }
  render() {
    return (
      <View style={{padding: 10, backgroundColor: '#f9f2f4'}}>
        <TextInput 
          style={{height: 40}}
          placeholder="Type here to translate"
          onChangeText={(text) => this.setState({text})}
        />
        <Text style={{padding: 10, fontSize: 42}}>
          {this.state.text.split(' ').map((word) => word && '💩').join(' ')}
        </Text>
      </View>   
    );
  }
}
```

![](http://ocp5vadja.bkt.clouddn.com/RN-content8-1.png)

例中我们把 `text` 保存到 state 中，因为它会随着时间变化。



