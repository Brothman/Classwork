import React from 'react';


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
    this.props.removeTodo(this.props.todo);
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
    return (
      <div>
        <li>{this.props.todo.title}</li>
        <button className="done-button" onClick={this.handleDone}>
          {buttonText}
        </button>
        <button onClick={this.handleDeletion}>
          Remove item
        </button>
      </div>
    );
  }
}

export default TodoListItem;
