import React from 'react';
import { connect } from 'react-redux';
import { allTodos } from '../../reducers/selectors.js';
import { receiveTodo, receiveTodos, removeTodo, fetchTodos } from '../../actions/todo_actions.js';
import TodoList from './todo_list.jsx';

class ToDoListContainer extends React.Component {

  componentDidMount() {
    this.props.fetchTodos();
  }

  render () {
    return (
      <TodoList
        todos={this.props.todos}
        receiveTodo={this.props.receiveTodo}
        removeTodo={this.props.removeTodo}>
      </TodoList>
    );
  }
}

const mapStateToProps = state => {
  return {
    todos: allTodos(state)
  };
};

const mapDispatchToProps = dispatch => {
  return {
    receiveTodo: todo => dispatch(receiveTodo(todo)),
    removeTodo: todo => dispatch(removeTodo(todo)),
    receiveTodos: todos => dispatch(receiveTodos(todos)),
    fetchTodos: () => fetchTodos(dispatch)
  };
};

export default connect(mapStateToProps, mapDispatchToProps)(ToDoListContainer);
