import React from 'react';
import { Provider } from 'react-redux';
import App from "./App.jsx";
// import store from "../store/store.js";

const root = ({ store }) => {
  return (
    <Provider store={ store }>
      <App />
    </Provider>
  );
};

export default root;
