//Hooks
///////////////////
/*
import React, { useState } from 'react';

const User = (props) => {

  const [isHovered, setIsHovered] = useState(false);
  
  const toggleHover = () => {
  	setIsHovered(!isHovered);
  }

  return (
        <span className={isHovered ? 'blu' : 'norma'} onMouseEnter={toggleHover} onMouseLeave={toggleHover}>{props.name}</span>
  );
};
*/
// Classes
///////////////////
import React, {Component} from 'react';
import axios from 'axios';
import UserCard from './UserCard'
import { connect } from 'react-redux'

class User extends Component {
  constructor(props) {
    super(props);
    this.state = {
      isHovered : false
    };
    this.toggleHover = this.toggleHover.bind(this);
  }
  
  toggleHover(){
    this.setState(prevState => ({isHovered: !prevState.isHovered}));
  }

//hack ash with credentials :  

  async getUserData(uname) {
	await axios.get('https://tennismatchmachine.com/cgi/genc/tmm_api.pl?name='+uname, {withCredentials: true}, {responseType: 'json'})
	//await axios.get('https://xetr.ru/cgi/genc/tmm_api.pl?name='+uname, {responseType: 'json'})
            .then(response => { var obj = response.data[0];
		this.props.dispatch({
          		type: 'CHECK_AUTH',
          		payload: obj === 'U' ? false : true
        	});
		this.props.parentCallback(<UserCard obj={obj} />);
            })
            .catch(function (error){
                console.log(error);
            })
    
  } 

/*
  getUserData(uname) {
    fetch('https://tennismatchmachine.com/cgi/genc/tmm_api.pl?name='+uname, {credentials: 'include'})
      .then(response => response.json())
      .then(json => { var obj = json.data[0];//console.log('here obj is '+ obj);
        if (obj === 'Unauthorized') this.props.dispatch({
          type: 'CHECK_AUTH',
          payload: false
        });
	this.props.parentCallback(<UserCard obj={obj} />);
      }) 	
  }
*/  
  render(){
    const btnClass = this.state.isHovered ? 'blu' : 'norma';

    return (<span className={btnClass} onMouseEnter={this.toggleHover} onMouseLeave={this.toggleHover} onClick={(e) => this.getUserData(this.props.name,e)} >{this.props.name}</span>);
  }
};

const mapStateToProps = state => {
  return {auth: state.auth}
}

const mapDispatchToProps = dispatch => {
  return {
    dispatch
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(User)
