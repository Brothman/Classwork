import { RECEIVE_TODOS } from '../actions/todo_actions.js';
import { RECEIVE_TODO } from '../actions/todo_actions.js';
import { REMOVE_TODO } from '../actions/todo_actions.js';

const initialState = {
  1: {
    id: 1,
    title: 'Wash Car',
    body: 'With Soap',
    done: false
  },
  2: {
    id: 2,
    title: "Wash Dog",
    body: "With Shampoo",
    done: true
  }
};

const todosReducer = (state = initialState, action) => {
  Object.freeze(state);
  let todosObject = {};

  switch (action.type) {
    case (RECEIVE_TODOS):
      for (var i = 0; i < action.todos.length; i++) {
        todosObject[action.todos[i].id] = action.todos[i];
      }
      return todosObject;

    case (RECEIVE_TODO):
      return Object.assign({}, state, {[action.todo.id]: action.todo});

    case (REMOVE_TODO):
      todosObject = Object.assign({}, state);
      delete todosObject[action.todo.id];
      return todosObject;

    default:
      return state;
  }
};

export default todosReducer;
