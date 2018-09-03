import React from 'react';
import { connect } from 'react-redux';
import { allTodos } from '../../reducers/selectors.js';
import { receiveTodo } from '../../actions/todo_actions.js';
import TodoList from './todo_list.jsx';
import { removeTodo } from '../../actions/todo_actions.js';

class ToDoListContainer extends React.Component {
  render () {
    console.log(this.props);
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
    removeTodo: todo => dispatch(removeTodo(todo))
  };
};

export default connect(mapStateToProps, mapDispatchToProps)(ToDoListContainer);
