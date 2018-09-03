import React from 'react';
import { uniqueId } from "../../util/utils.js";
import { receiveTodo } from '../../actions/todo_actions.js';
import { connect } from 'react-redux';

class TodoForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      data: ""
    };
    this.updateInput = this.updateInput.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  updateInput(event){
    event.preventDefault();
    this.setState({
      data: event.target.value
    });
  }

  handleSubmit(event) {
    event.preventDefault();
    this.props.receiveTodo({id: uniqueId(), title: this.state.data});
    this.setState({data: ""});
  }

  render () {
    return (
      <form onSubmit={this.handleSubmit}>
        <input onChange={this.updateInput} value={this.state.data}></input>
        <input type="submit" value="Add To Do"></input>
      </form>
    );
  }
}

const mapDispatchToProps = (dispatch) => {
  return {
    receiveTodo: (todo) => { dispatch(receiveTodo(todo)); }
  };
};

export default connect(null, mapDispatchToProps)(TodoForm);
