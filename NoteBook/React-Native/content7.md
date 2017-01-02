# 使用 flexbox 布局

在 React Native 中使用 `flexbox` 规则来指定某个组件的子元素的布局。 `flexbox` 可以在不同屏幕尺寸上提供一致的布局结构。

一般来说，使用 `flexDirection`、`alignItems` 和 `justifyContent` 三个样式属性就已经能满足大多数布局需求。

> React Native 中的 flexbox 的工作原理和 web 上的 css 基本一致，当然也有差异。首先是默认值不同：`flexDirection` 的默认值是 `column` 而不是 `row`, 而 `flex` 也只能指定一个数字值。

## flexDirection

```js
flexDirection: row | column
```

在组件的 `style` 中指定 `flexDirection` 可以决定布局的**主轴**。子元素应该是沿着**水平轴(row)**方向排列，还是沿着**竖直轴(column)**方向排列呢？默认值是**数值轴**方向。

```js
export default class HelloWorld extends Component {
  render() {
    return (
      <View style={{flex: 2, flexDirection: 'row', backgroundColor: '#f9f2f4'}} >
        <View style={{flex: 1, backgroundColor: 'powderblue'}} />
        <View style={{flex: 2, backgroundColor: 'skyblue'}} />
        <View style={{flex: 3, backgroundColor: 'steelblue'}} />
      </View>
    );
  }
}
```

![](http://ocp5vadja.bkt.clouddn.com/RN-content7-1.png)

## justifyContent

```js
justifyContent: flex-start | flex-end | center | space-between | space-around
```

在组件的 style 中指定 `justifyContent` 可以决定其子元素沿着**主轴**的**排列方式**。子元素是应该靠近主轴的起始端还是末尾段部分呢？亦或应该均匀分布？对应的这些可选项有：`flex-start`, `center`, `flex-end`, `space-around` 以及 `space-between`。

```js
export default class HelloWorld extends Component {
  render() {
    return (
      <View style={{
        flex: 1,
        justifyContent: 'space-between',
        backgroundColor: '#f9f2f4',
      }} >
        <View style={{width: 50, height: 50, backgroundColor: 'powderblue'}} />
        <View style={{width: 50, height: 50, backgroundColor: 'skyblue'}} />
        <View style={{width: 50, height: 50, backgroundColor: 'steelblue'}} />
      </View>
    );
  }
}
```

![](http://ocp5vadja.bkt.clouddn.com/RN-content7-2.png)

## alignItems

```js
alignItems: flex-start | flex-end | center | stretch
```

在组件的 style 中指定 `alignItems` 可以决定其子元素**沿着次轴**（与主轴垂直，比如主轴方向为 `row`，则次轴方向为 `column` ）的**排列方式**。子元素是应该靠近次轴的起始端还是末尾段分布呢？亦或应该均匀分布？这些问题由这个属性控制。

> 注意：要使 `stretch` 选项生效的话，子元素在次轴方向上不能有固定的尺寸。

```js
export default class HelloWorld extends Component {
  render() {
    return (
      <View style={{
        flex: 1,
        flexDirection: 'column',
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: '#f9f2f4',
      }} >
        <View style={{width: 50, height: 50, backgroundColor: 'powderblue'}} />
        <View style={{width: 50, height: 50, backgroundColor: 'skyblue'}} />
        <View style={{width: 50, height: 50, backgroundColor: 'steelblue'}} />
      </View>
    );
  }
}
```

![](http://ocp5vadja.bkt.clouddn.com/RN-content7-3.png)

## flex

```js
flex: none | flex-grow flex-shrink flex-basis
```

这个属性在 [高度与宽度]() 一节中已经使用，相当于是比例分配。不再举例。


## alignSelf

`alignSelf` 决定了元素在父元素的次轴方向的排列方式（次样式设置在子元素上），其值会覆盖父元素的 `alignItems` 的值。其表现和 css 上的 `align-self` 一致，默认值为 `stretch` 。

```js
export default class HelloWorld extends Component {
  render() {
    return (
      <View style={{
        flex: 1,
        flexDirection: 'column',
        backgroundColor: '#f9f2f4',
      }} >
        <View style={{width: 50, height: 50, backgroundColor: 'powderblue'}} />
        <View style={{width: 50, height: 50, backgroundColor: 'skyblue'}} />
        <View style={{
          width: 50, 
          height: 50, 
          backgroundColor: 'steelblue',
          alignSelf: 'flex-end',
        }} />
      </View>
    );
  }
}
```

![](http://ocp5vadja.bkt.clouddn.com/RN-content7-4.png)
