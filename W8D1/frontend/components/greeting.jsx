import React from 'react';
import {Link} from 'react-router-dom';
import Search from './search_container.js';

class Greeting extends React.Component {

  render () {
    let greetingComponents;
    if (this.props.currentUser) {
      greetingComponents = (
        <div>
          <h3>Hello {this.props.currentUser.username}</h3>
          <button onClick={this.props.logout}>Logout</button>
        </div>
      );
    } else {
      greetingComponents = (
        <div className="header">
          <Link to='/signup' className="footer">Sign Up</Link>
          <Link to='/login'>Log In</Link>
          <img className="image" src="https://postmediacanoe.files.wordpress.com/2018/04/blacklab1000.jpg"></img>
          <Search></Search>
        </div>
      );
    }

    return greetingComponents;
  }
}

export default Greeting;
