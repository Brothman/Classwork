const Router = require('./router.js');
const Inbox = require('./components/inbox.js');
const Sent = require('./components/sent.js');

document.addEventListener("DOMContentLoaded", () => {
  //set initial route to /inbox
  window.location.hash = 'inbox';

  //put a click listener on sidebar to chance the hash route
  $('.sidebar-nav').children('li').on('click', (event) => {
    const innerText = event.target.innerText.toLowerCase();
    window.location.hash = innerText;
  });

  //create a router to manage what view to display for each route
  const content = document.querySelector('.content');
  const router = new Router(content, routes);

});

const routes = {
  inbox: Inbox,
  compose: '<li>',
  sent: Sent
};
