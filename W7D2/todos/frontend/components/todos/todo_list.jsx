import React from 'react';
import TodoListItem from './todo_list_item.jsx';
import ToDoForm from './todo_form.jsx';


const TodoList = (props) => {
  const todos = props.todos.map((todo) => {
    return (
      <TodoListItem key={todo.id} todo={todo}
        receiveTodo={props.receiveTodo}
        removeTodo={props.removeTodo}
      />
    );
  });

  return (
    <div>
      <h1 className="center-align">To Do List:</h1>
      <ToDoForm />
      <ul>
        {todos}
      </ul>
    </div>

  );
};

export default TodoList;
