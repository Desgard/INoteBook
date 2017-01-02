# 高度与宽度

组件的高度和宽度决定了其在屏幕上显示的尺寸。

## 指定宽高

最简单的给组件设定尺寸的方式就是在样式中指定固定的 `width` 和 `height` 。React Native 中的尺寸都是无单位的，表示的是与设备像素密度无关的逻辑像素点。

```js
export default class HelloWorld extends Component {
  render() {
    return (
      <View>
        <View style={{width: 50, height: 50, backgroundColor: 'powerblue'}} />
        <View style={{width: 100, height: 100, backgroundColor: 'skyblue'}} />
        <View style={{width: 150, height: 150, backgroundColor: 'steelblue'}} />
      </View>
    );
  }
}
```

![](http://ocp5vadja.bkt.clouddn.com/RN-content6-1.png)

## Flex 宽高

在组件样式中使用 `flex` 可以使其在可利用的空间中动态得扩张或收缩。一般而言我们会使用 `flex:1` 来指定某个组件扩张以撑慢所有剩余的空间。如果有多个并列的子组件使用了 `flex:1` ，则这些子组件会评分父容器中剩余的空间。如果这些并列的子组件的 `flex` 值不一样，则谁的值更大，谁占剩余空间的比例就更大（即占据剩余空间的比等于并列组件间 `flex` 值的比）。

> 组件能够盛满剩余空间的前提是其父容器的尺寸不为零。如果父容器既没有固定的 `width` 和 `height`，也没有设定 `flex` ，则父容器的尺寸为零。其子组件如果使用了 `flex`，也是无法显示的。

```js
export default class HelloWorld extends Component {
  render() {
    return (
      <View style={{flex: 2}} >
        <View style={{flex: 1, backgroundColor: 'powderblue'}} />
        <View style={{flex: 2, backgroundColor: 'skyblue'}} />
        <View style={{flex: 3, backgroundColor: 'steelblue'}} />
      </View>
    );
  }
}
```

![](http://ocp5vadja.bkt.clouddn.com/RN-content6-2.png)



