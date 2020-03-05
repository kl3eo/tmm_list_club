import React from 'react'
import './App.css'
import Tableau from './components/Tableau'
import { connect } from 'react-redux'

class App extends React.Component {

  componentDidMount() {
    fetch('/cgi/genc/tmm_api.pl')
      .then(response => response.json())
      .then(json => {
        this.props.dispatch({
          type: 'LOAD_USERS',
          payload: json
        });
      })  
  }

  render() {
    return (
      <div className="App">
        <header className="App-header">
		<Tableau />
        </header>
      </div>
    )
  }
}

const mapStateToProps = state => {
  return { users: state.users}
}

export default connect(
  mapStateToProps
)(App)
