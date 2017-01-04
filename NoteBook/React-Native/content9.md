# 从 ScrollView 到 ListView

## ScrollView 简单运用

`ScrollView` 是一个通用的可滚动容器，你可以在其中放入多个组件，而且这些组件并不粗要是同类型的。`ScrollView` 不仅可以垂直滚动，还可以水平滚动（通过 `horizontal` 属性来设置）。

```js
export default class HelloWorld extends Component {
  render() {
    return (
      <ScrollView>
        <Text style={{fontSize: 40}}>HelloWorld</Text>
        <Text style={{fontSize: 40}}>HelloWorld</Text>
        <Text style={{fontSize: 40}}>HelloWorld</Text>
</ScrollView>
    );
  }
}
```

`ScrollView` 适合用来显示数量不多的滚动元素。放置在 `ScrollView` 中的所有组件都会被渲染，哪怕有些组件因为内容太长被挤出了屏幕外。如果你需要显示较长的滚动列表，那么应该使用功能差不多但性能更好的 `ListView` 组件。

## 如何使用 ListView

`ListView` 组件用于显示一个垂直的滚动列表，其中的元素之间结构相似而仅数据不同。

`ListView` 更适用于长列表数据，且元素个数可以增减。和 `ScrollView` 不同的是，`ListView` 并不立即渲染所有元素，而是有限渲染屏幕上课件的元素。

`ListView` 组件必须的两个属性是 `dataSource` 和 `renderRow` 。`dataSource` 是列表的数据源，而 `renderRow` 则逐个解析数据源中的数据，然而返回一个设定好格式的组件来渲染。

> `rowHasChanged` 函数也是 `ListView` 的必须属性。这里我们只是简单的比较两行数据是否是同一个数据（`===` 符号值比较基本类型数据的值，和引用类型的地址）来判断某航数据是否变化了。

```js
export default class HelloWorld extends Component {
  constructor(props) {
    super(props);
    const ds = new ListView.DataSource({rowHasChanged: (r1, r2) => r1 != r2});
    this.state = {
      dataSource: ds.cloneWithRows([
        'John',
        'Joel',
        'James',
        'Jimmy',
        'Jackson',
        'Jillian',
        'Julie',
        'Devin',
      ])
    };
  }
  render() {
    return (
      <View style={{flex:1, paddingTop:22}}>
        <ListView
          dataSource={this.state.dataSource}
          renderRow={(rowData) => <Text>{rowData}</Text>}
        />
      </View>
    );
  }
}
```

