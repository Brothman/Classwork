import { RECEIVE_USER, LOGOUT } from '../actions/session_actions.js';
import _ from 'lodash';

const usersReducer = (state={}, action) => {
  switch(action.type) {
    case(RECEIVE_USER):
      return _.merge({}, state, {[action.user.id]: action.user});
    case(LOGOUT):
      return {};
    default:
      return state;
  }
};

export default usersReducer;
