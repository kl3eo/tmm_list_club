import { createStore } from 'redux'

const initialState = {
  users: [],
  auth: false
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
    
  return state
}

const store = createStore(reducer)

export default store
