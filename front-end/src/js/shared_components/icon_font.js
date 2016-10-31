import React, {Component} from 'react';

export default class IconFont extends React.Component {
  clazz() {
    let clazz = "iconfont ";
    clazz += this.props.icon || '';
    clazz += this.props.class || '';
    return clazz;
  }

  render() {
    return <i className={this.clazz()}></i>
  }
}