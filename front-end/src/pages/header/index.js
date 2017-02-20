import React, { Component } from 'react';
import IconFont from '../../js/shared_components/icon_font';

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
      <header>
        <div className="header body-container">
          <span className="left logo">
            <img src={require('../../img/logo-white.png')} />
          </span>
          <nav className="middle nav">
            <Tab label="資訊" href="/" active={true}/>
            <Tab label="視頻" href="/videos" />
            <Tab label="活動" href="//events.geekpark.net" />
            <Tab label="極客加速" href="//geeks.vc" />
          </nav>
          <span className="right">
            <IconFont icon="icon-search" />
            <span className="login-btn">
              <a class="signin" href="/users/auth/geekpark">登入/注册</a>
            </span>
          </span>
        </div>
      </header>
    );
  }
}