import React, {Component} from 'react';
import axios from 'axios';
import UserCard from './UserCard'
import { connect } from 'react-redux'
import baseURL from '../BaseURL'

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

  async getUserData(uname) {
	await axios.get(baseURL + '/cgi/genc/tmm_api.pl?name='+uname, {withCredentials: true}, {responseType: 'json'})
            .then(response => { var obj = response.data[0];
		this.props.dispatch({
          		type: 'CHECK_AUTH',
          		payload: obj === 'U' ? false : true
        	});
		this.props.parentCallback(<UserCard obj={obj} parentCallback={this.props.parentCallback}/>);
            })
            .catch(function (error){
                console.log(error);
            })
    
  } 
  
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
