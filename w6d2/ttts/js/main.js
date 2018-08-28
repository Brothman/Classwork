const View = require('./ttt-view.js');
const Game = require('../solution/game.js');// require appropriate file
window.View = View;
window.Game = Game;



$( () => {
  const game = new Game();
  const $container = $('.ttt');
  const view = new View(game, $container);
  view.bindEvents();
  setInterval(callback.bind(this),2000);
});

function callback() {
  let hexacode = [];

  while (hexacode.length < 6) {
    hexacode.push(Math.floor(Math.random() * 9));
  }

  $('body').css('background-color', `#${hexacode.join('')}`);
  $('body').css('transition', `background-color 1s ease-in-out`);
}

// function callback() {
//
//   let numberHex = parseInt(window.Hex.slice(1));
//
//   numberHex += 010101;
//
//   window.Hex = `#${numberHex}`;
//
//   $('body').css('background-color', `#${hexacode}`);
//   $('body').css('transition', `background-color 1s ease-in-out`);
// }
