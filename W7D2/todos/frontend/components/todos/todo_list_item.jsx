import React from 'react';
import { deleteTodo } from '../../actions/todo_actions.js';
import { connect } from 'react-redux';

class TodoListItem extends React.Component {
  constructor(props) {
    super(props);
    this.handleDeletion = this.handleDeletion.bind(this);
    this.handleDone = this.handleDone.bind(this);
    this.state = {
      done: this.props.todo.done
    };
  }

  handleDeletion(e){
    e.preventDefault();
    // this.props.removeTodo(this.props.todo);
    this.props.deleteTodo(this.props.todo);
  }

  handleDone(e) {
    e.preventDefault();
    this.setState({done: !this.state.done}, () => {
      const { todo } = this.props;
      const { done } = this.state;
      const updatedTodo = Object.assign({}, todo, {done});
      // debugger
      this.props.receiveTodo(updatedTodo);
    });
  }

  render () {
    const buttonText = (this.state.done) ? "Undo" : "Done";
    const liClass = (this.state.done) ? "done-item" : "undone-item";

    return (
      <div className="li-container">
        <li className={liClass}>{this.props.todo.title}</li>
        <button onClick={this.handleDone}>
          {buttonText}
        </button>
        <button onClick={this.handleDeletion}>
          Remove item
        </button>
      </div>
    );
  }
}

const mapDispatchToProps = (dispatch) => {
  return {
    deleteTodo: (todo) => deleteTodo(dispatch, todo)
  };
};

export default connect(null, mapDispatchToProps)(TodoListItem);
