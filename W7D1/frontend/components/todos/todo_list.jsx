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
      <ul>
        {todos}
      </ul>
      <ToDoForm />
    </div>

  );
};

export default TodoList;
