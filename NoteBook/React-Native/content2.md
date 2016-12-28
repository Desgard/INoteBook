# 上手实例准备开发

本例是 *React-Native* 官方文档中的实例应用，将获取电影的数据，并在 `ListView` 中展现出来。

## 代码示例

```js
/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  Image,
  ListView,
} from 'react-native';

// 给出接口的 url 地址
var REQUEST_URL = 'https://raw.githubusercontent.com/facebook/react-native/master/docs/MoviesExample.json';

export default class HelloWorld extends Component {
  constructor(props) {
    super(props);
    this.state = {
      dataSource: new ListView.DataSource({
        rowHasChanged: (row1, row2) => row1 !== row2,
      }),
      loaded: false,
    };
    // 在ES6中，如果在自定义的函数里使用了this关键字，则需要对其进行“绑定”操作，否则this的指向会变为空
    // 像下面这行代码一样，在constructor中使用bind是其中一种做法（还有一些其他做法，如使用箭头函数等）
    this.fetchData = this.fetchData.bind(this); 
  }

  componentDidMount() {
    this.fetchData();
  }

  fetchData() {
    fetch(REQUEST_URL)
      .then((response) => response.json())
      .then((responseData) => {
        // 注意，这里使用了this关键字，为了保证this在调用时仍然指向当前组件，我们需要对其进行“绑定”操作
        this.setState({
          dataSource: this.state.dataSource.cloneWithRows(responseData.movies),
          loaded: true,
        });
      });
  }

  render() {
    if (!this.state.loaded) {
      return this.renderLoadingView();
    }

    return (
      <ListView
        dataSource={this.state.dataSource}
        renderRow={this.renderMovie}
        style={styles.listView}
      />
    );
  }

  renderLoadingView() {
    return (
      <View style={styles.container}>
        <Text>
          Loading movies...
        </Text>
      </View>
    );
  }

  renderMovie(movie) {
    return (
      <View style={styles.container}>
        <Image
          source={{uri: movie.posters.thumbnail}}
          style={styles.thumbnail}
        />
        <View style={styles.rightContainer}>
          <Text style={styles.title}>{movie.title}</Text>
          <Text style={styles.year}>{movie.year}</Text>
        </View>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  listView: {
    paddingTop: 20,
    backgroundColor: '#F5FCFF',
  },
  container: {
    flex: 1,
    flexDirection: 'row',
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  thumbnail: {
    width: 53,
    height: 81,
  },
  rightContainer: {
    flex: 1,
  },
  title: {
    fontSize: 20,
    marginBottom: 8,
    textAlign: 'center',
  },
  year: {
    textAlign: 'center',
  },
});

AppRegistry.registerComponent('HelloWorld', () => HelloWorld);

```

## 示例解释

在页面加载之前先创建一个初始的 `null` 状态，这样可以通过 `this.state.movies = null` 来判断我们是不是已经被抓取到了。在服务器响应返回的时候执行 `this.setState({movies: moviesData})` 来改变状态。

在组件加载完毕后，就可以向服务器请求数据。`componentDidMount` 是 `React` 组件的一个生命周期方法，它会在组件刚加载完成的时候调用一次，以后不再调用。

`fetchData()` 函数用来处理得到数据后的回调方法。在 `Promise` 调用链结束后执行 `this.setState({movies:data})`。在 React 工作机制下，`setState` 会进入重新渲染流程，`render` 函数被触发，找到 `this.state.movies` 中的新数据。




