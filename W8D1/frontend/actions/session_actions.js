import * as APIUtil from '../util/session_api_util.js';
export const RECEIVE_USER = "RECEIVE_USER";
export const LOGOUT = "LOGOUT";
export const RECEIVE_ERRORS = "RECEIVE_ERRORS";
//action creator
export const receiveUser = (user) => {
  return {
    type: RECEIVE_USER,
    user,
  };
};

export const logoutUser = () => {
  return {
    type: LOGOUT,
  };
};

export const receiveErrors = (errors) => {
  return {
    type: RECEIVE_ERRORS,
    errors,
  };
};

//thunk action creator
export const login = (user) => {
  return (dispatch) => {
    APIUtil.login(user)
    .then((user) => {
      dispatch(receiveUser(user));
    },
    (errors) => {
      dispatch(receiveErrors(errors));
    });
  };
};


export const logout = () => {
  return (dispatch) => {
    APIUtil.logout().then(() => {
      dispatch(logoutUser());
    });
  };
};

export const signup = (user) => {
  return (dispatch) => {
    APIUtil.signup(user)
    .then((user) => {
      dispatch(receiveUser(user));
    },
    (errors) => {
      dispatch(receiveErrors(errors));
    });
  };
};
