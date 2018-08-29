const APIUtil = {
  followUser: (id) => {
    return $.ajax({
      method: 'POST',
      url: `/users/${id}/follow`,
      data: {user_id: id},
      dataType: 'json'
    });
  },

  unFollowUser: (id) => {
    return $.ajax({
      method: 'DELETE',
      url: `/users/${id}/follow`,
      dataType: 'json'
    });
  },

  searchUsers: (queryVal, successCallback) => {
     $.ajax({
      method: 'GET',
      url: '/users/search',
      dataType: 'json',
      data: {query: queryVal}
    }).then(successCallback);
  }
};

module.exports = APIUtil;
