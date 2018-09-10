import sessionErrorsReducer from './session_errors_reducer.js';
import { combineReducers } from 'redux';

const errorsReducer = combineReducers({
  session: sessionErrorsReducer,
});

export default sessionErrorsReducer;
