const APIUtil = require('./api_util.js');
const FollowToggle = require('./follow_toggle.js');

class UsersSearch {
  constructor($el) {
    this.$el = $el;
    this.$input = $el.children('input');
    this.$ul = $el.children('ul');
  }

  handleInput() {
    //pass in success callback
    return APIUtil.searchUsers(this.$input.val(), this.renderResults.bind(this));
  }

  renderResults(fetchedUsers) {
    this.$ul.empty();

    for (var i = 0; i < fetchedUsers.length; i++) {
      const $button = $('<button>');
      $button.data('user-id', fetchedUsers[i].id);
      $button.addClass('follow-toggle');
      if (fetchedUsers[i].followed) {
        $button.data('initial-followed-state', 'followed');
      }
      else {
        $button.data('initial-followed-state', 'unfollowed');
      }

      const followToggle = new FollowToggle($button[0]);
      $button.on('click', followToggle.handleClick.bind(followToggle));

      const $li = $('<li>');
      const $a = $('<a>');
      $a.prop('href', `${fetchedUsers[i].id}`);
      $a.text(fetchedUsers[i].username);
      $li.append($a);
      $li.append($button);
      this.$ul.append($li);
    }
  }
}

// export default UsersSearch;
module.exports = UsersSearch;
