import React, {Component} from 'react';
//import Link from '@material-ui/core/Link';
//import store from '../store';

class UserMatches extends Component {

  constructor(props) {
    super(props);
    this.state = {
      isHovered : false,
    };
    this.toggleHover = this.toggleHover.bind(this);
  }
  toggleHover(){
    this.setState(prevState => ({isHovered: !prevState.isHovered}));
  }
  
  render(){
  

    return (
    <div className="outer">
            <div className="inner">

						<h1>Matches TMM</h1>

            </div>
    </div>

    ); //return

  } //render
}; //class

///////////////////
export default UserMatches;
