import { createStore } from 'redux'
//import { createStore, applyMiddleware } from 'redux'
//import { logger } from 'redux-logger';
//import  thunk from 'redux-thunk';

const initialState = {
  users: [],
  auth: false,
  matches_type: 'singles'
}

const reducer = (state = initialState, action) => {


  if (action.type === 'LOAD_USERS') {
    return {
      ...state,
      users: state.users.concat(action.payload)
    }
  }

  if (action.type === 'CHECK_AUTH') {
    return {
      ...state,
      auth: action.payload
    }
  }

  if (action.type === 'SELECT_MATCHES_TYPE') {
    return {
      ...state,
      matches_type: action.payload
    }
  }
        
  return state
}

//const store = createStore(reducer, applyMiddleware(thunk,logger) )
const store = createStore(reducer)

export default store
