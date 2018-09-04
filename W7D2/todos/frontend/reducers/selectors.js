export const allTodos = (state) => {
  const keys1 = Object.keys(state.todos);
  const todoArray = keys1.map((id) => {
    return state.todos[id];
  });
  return todoArray;
};
