import { createStore } from 'redux';
import rootReducer from '../reducers/root_reducer.js';
import { applyMiddleware } from 'redux';
import thunk from '../middleware/thunk.js';


const configureStore = () => {
  return createStore(rootReducer, {}, applyMiddleware(thunk));
};

export default configureStore;
