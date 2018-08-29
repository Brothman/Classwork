const FollowToggle = require('./follow_toggle.js');
const UserSearch = require('./users_search.js');

$( () => {
  $('.follow-toggle').each( (index, button) => {
    const followToggle = new FollowToggle(button);
    $(button).on('click', followToggle.handleClick.bind(followToggle));
  });

  const $nav = $('nav');
  // $('nav').children('input').on('change', () => {
  //   const userSearch = new UserSearch($nav);
  //   userSearch.handleInput();
  // });
  $nav.keyup( () => {
    const userSearch = new UserSearch($nav);
    userSearch.handleInput();
  });
});
