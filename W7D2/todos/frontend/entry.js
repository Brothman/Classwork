import Store from './store/store.js';
import React from 'react';
import ReactDOM from 'react-dom';
import Root from "./components/root.jsx";
import { allTodos } from "./reducers/selectors.js";

const store = Store();
window.store = store;

window.allTodos = allTodos;

document.addEventListener('DOMContentLoaded', () => {
  const root = document.getElementById("root");
  ReactDOM.render(<Root store={ store }/>, root);
});
