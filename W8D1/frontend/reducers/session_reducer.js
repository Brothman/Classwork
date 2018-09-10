import { RECEIVE_USER, LOGOUT } from '../actions/session_actions.js';

const nullUser = {
  id: null
};
const sessionReducer = (state = nullUser, action) => {
  switch(action.type) {
    case(RECEIVE_USER):
      return {id: action.user.id};
    case(LOGOUT):
      return nullUser;
    default:
      return state;
  }
};

export default sessionReducer;
