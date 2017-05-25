import React, { Component } from 'react';
import './index.scss';

import Recommendations from './recommendations'
import AdBanner from './ad_banner'
import Contents from './contents'
import SideBar from './side_bar'

export default class Main extends Component {
  render() {
    return (
      <div className="main">
        <Recommendations />
        <AdBanner />
        <div>
          <Contents />
          <SideBar />
        </div>
      </div>
    );
  }
}
