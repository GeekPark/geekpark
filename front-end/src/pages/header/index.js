import React, { Component } from 'react';

import './index.scss';

class Tab extends Component {
  render() {
    return (
      <a href={this.props.href} className={"nav-link " + (this.props.active && 'active')}>
        {this.props.label}
      </a>
    )
  }
}

export default class Header extends Component {
  render() {
    return (
      <header className="header">
        <span className="logo">
          <img src={require('../../img/logo-white.png')} />
        </span>
        <nav className="nav">
          <Tab label="資訊" href="/" active={true}/>
          <Tab label="視頻" href="/videos" />
          <Tab label="活動" href="//events.geekpark.net" />
          <Tab label="極客加速" href="//geeks.vc" />
        </nav>
        <span className="login-btn">登入/注册</span>
      </header>
    );
  }
}