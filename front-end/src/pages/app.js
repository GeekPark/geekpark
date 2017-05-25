// application's entry

import React, { Component } from 'react';
import { render } from 'react-dom';
import { Provider } from 'react-redux';
import { createStore, applyMiddleware } from 'redux';
import thunk from 'redux-thunk';
import { Router, Route, IndexRoute, browserHistory, Link } from 'react-router';
import reducers from 'reducers/index';
import '../css/common.scss';

import Header from './header/index';
import Footer from './footer/index';
// pages
import Main from './main/index';
import Videos from './videos/index';
import Topics from './topics/index';

class Application extends Component {
  render() {
    return (
      <div>
        <Header />
        {this.props.children}
        <Footer />
      </div>
    );
  }
}

const store = createStore(reducers, {}, applyMiddleware(thunk));

render((
  <Provider store={store}>
    <Router history={browserHistory}>
      <Route path="/" component={Application}>
        <IndexRoute component={Main}/>
        <Route path="videos" component={Videos}></Route>
        <Route path="topics" component={Topics}></Route>
      </Route>
    </Router>
  </Provider>
), document.getElementById('app'));