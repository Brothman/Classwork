const APIUtil = require ('./api_util.js');

class FollowToggle {
  constructor(el) {
    this.$el = $(el);
    this.userId = this.$el.data('user-id');
    this.followState = this.$el.data('initial-follow-state');
    this.render();
  }

  render() {
    if (this.followState === 'following' || this.followState === 'unfollowing') {
      this.$el.prop('disabled', true);
    }
    else {
      this.$el.prop('disabled', false);
      if (this.followState === 'followed'){
          this.$el.text('Unfollow!');
        } else {
          this.$el.text('Follow!');
        }
      }
    }

  toggleState() {
    this.followState = ((this.followState === 'unfollowing') ? 'unfollowed' : 'followed');
    this.render();
  }

  handleClick() {
    event.preventDefault();

    if (this.followState === 'followed') {
      this.followState = 'unfollowing';
      this.render();
      APIUtil.unFollowUser(this.userId).then(this.toggleState.bind(this));
    }
    else {
      this.followState = 'following';
      this.render();
      APIUtil.followUser(this.userId).then(this.toggleState.bind(this));
    }
  }
}

module.exports = FollowToggle;
