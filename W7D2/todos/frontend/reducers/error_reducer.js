import { CLEAR_ERRORS, RECEIVE_ERRORS } from '../actions/error_actions.js';

const initialState = [];

const errorsReducer = (state = initialState, action) => {
  Object.freeze(state);
  switch (action.type) {
    case (RECEIVE_ERRORS):
      return action.errors;

    case (CLEAR_ERRORS):
      return [];

    default:
      return initialState;
  }
};

export default errorsReducer;
