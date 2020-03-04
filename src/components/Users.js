import React, {Component} from 'react';
import User from './User'
import ToggleBox from './ToggleBox'
import CustomizedDialogs  from './CustomizedDialogs'
import axios from 'axios';

class Users extends Component {
  constructor() {
    super();
    this.state = {
      users: [],
      isLoaded: false,
      error: null,
      message: "...Loading..."
    };
  }
  
  callbackFunction = (childData) => {
       this.setState({message: childData})
  }
  
// EITHER fetch
/*
  async getUsers() {
    const response = await fetch('https://jsonplaceholder.typicode.com/users');
    const result = await response.json();
    this.setState({users:result, isLoaded:true});
  } 
  
  componentDidMount() {
 
    this.getUsers();
 
  }
*/
 
//OR XMLHttpRequest
/*

  componentDidMount() {
 
    var xhr = new XMLHttpRequest();
 
    xhr.addEventListener("readystatechange", () => {
        if (xhr.readyState === 4) {
            if (xhr.status === 200) {

                var response = xhr.responseText,
                    json = JSON.parse(response);
 
                this.setState({
                    isLoaded: true,
                    users: json
                });          
            } else {

                this.setState({
                    isLoaded: true,
                    error: xhr.responseText
                });
            }
        }
    });
 
    xhr.open("GET", "https://jsonplaceholder.typicode.com/users", true);
    xhr.send();
 
  }

*/
// OR axios

  async getUsers() {
	await axios.get('https://tennismatchmachine.com/cgi/genc/tmm_api.pl', {responseType: 'json'})
            .then(response => {
                this.setState({ users: response.data, isLoaded: true});//console.log(this.state.users);
            })
            .catch(function (error){
                console.log(error);
            })
  }
   
  componentDidMount() {
	this.getUsers();
  }
  
  onClick = () => {
    this.setState({message:'...Loading...'});
    this.child.handleClickOpen();
  } 

//  
  render() {
    const title = '';
        
    return (
    <div><CustomizedDialogs content={this.state.message} childRef={ref => (this.child = ref)} />
    
    <ul>
      {this.state.users.map(user => (
        <li onClick={this.onClick} key={user._id}><User name={user.name} id={user._id} parentCallback={this.callbackFunction} /><ToggleBox title={title} children={user.email}/>
	</li>
      ))}
    </ul>
    </div>
    );
  }
}

export default Users;

/////////////////////
//Hooks
/*
import React, { useEffect, useState } from 'react';
import User from './User'

const Users = () => {
  const [users, setUsers] = useState([]);
    
  useEffect( () => {getUsers()}, [] );

  async function getUsers() {
    const response = await fetch('https://jsonplaceholder.typicode.com/users');
    const users = await response.json();
    setUsers(users);
  }

  return (
    <ul>
      {users.map(user => (
        <li key={user.id}><User name={user.name} /></li>
      ))}
    </ul>
  );
};
*/
/////////////////////
//no Hooks
/*
import React, {Component} from 'react';
import User from './User'

class Users extends Component {
  constructor() {
    super();
    this.state = {
      users: [],
      isLoaded: false,
      error: null
    };
  }
  
  componentDidMount() {
 
    var xhr = new XMLHttpRequest();
 
    xhr.addEventListener("readystatechange", () => {
        if (xhr.readyState === 4) {
            if (xhr.status === 200) {

                var response = xhr.responseText,
                    json = JSON.parse(response);
 
                this.setState({
                    isLoaded: true,
                    users: json
                });          
            } else {

                this.setState({
                    isLoaded: true,
                    error: xhr.responseText
                });
            }
        }
    });
 
    xhr.open("GET", "https://jsonplaceholder.typicode.com/users", true);
    xhr.send();
 
  }
     
  render() {

    return (
    <ul>
      {this.state.users.map(user => (
        <li key={user.id}><User name={user.name} /></li>
      ))}
    </ul>
    );
  }
}
*/
