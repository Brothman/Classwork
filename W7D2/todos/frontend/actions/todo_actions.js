import * as APIUtil from '../util/todo_api_util.js';
import { receiveErrors } from './error_actions.js';

export const RECEIVE_TODOS = "RECEIVE_TODOS";
export const RECEIVE_TODO = "RECEIVE_TODO";
export const REMOVE_TODO = "REMOVE_TODO";

export const receiveTodos = todos => {
  return {
    type: RECEIVE_TODOS,
    todos
  };
};

export const receiveTodo = todo => {
  return {
    type: RECEIVE_TODO,
    todo
  };
};

export const removeTodo = todo => {
  return {
    type: REMOVE_TODO,
    todo
  };
};

export const fetchTodos = (dispatch) => {
  return APIUtil.fetchTodos().then((todos) => {
    dispatch({type: RECEIVE_TODOS, todos});
  });
};

export const createTodo = (dispatch, todo) => {
  return APIUtil.createTodo(todo).then(
    (todo) => {
      dispatch(receiveTodo(todo));
    },
    (error) => {
      dispatch(receiveErrors(error.responseJSON));
    }
  );
};

export const deleteTodo = (dispatch, todo) => {
  return APIUtil.deleteTodo(todo).then((todo) => {
    dispatch(removeTodo(todo));
  });
};
