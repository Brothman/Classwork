import React from 'react';
import { uniqueId } from "../../util/utils.js";
import { receiveTodo, createTodo } from '../../actions/todo_actions.js';
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
    // this.props.receiveTodo({id: uniqueId(), title: this.state.data});
    this.props.createTodo({title: this.state.data, body: "", done: false}).then(
      ()=> {
        this.setState({data: ""});
      }
    );
  }

  render () {
    return (
      <div className="center-align">
        <form onSubmit={this.handleSubmit}>
          <input onChange={this.updateInput} value={this.state.data}></input>
          <input type="submit" value="Add To Do"></input>
        </form>
        <h2>{this.props.errors}</h2>
      </div>
    );
  }
}

const mapStateToProps = (state) => {
  return {
    errors: state.errors
  };
};

const mapDispatchToProps = (dispatch) => {
  return {
    receiveTodo: todo => dispatch(receiveTodo(todo)),
    createTodo: todo => createTodo(dispatch, todo)
  };
};

export default connect(mapStateToProps, mapDispatchToProps)(TodoForm);
