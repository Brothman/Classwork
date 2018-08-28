class View {
  constructor(game, $el) {
    this.game = game;
    this.$el = $el;
    this.setupBoard();
  }

  bindEvents() {
    this.$el.on('click', 'li', (e) => {
      let sound = new Audio("./tss.mp3");
      //asdf
      const $li = $(e.target);
      if ($li.text() == "") {
        $li.text(`${this.game.currentPlayer.toUpperCase()}`);
        $li.css('background-color', "white");
        // alert($li.data("pos"))
        if ($li.data("pos") == "0,2") {
          $('img').css('display', 'block');
          sound.play();
        }
        this.game.playMove($li.data("pos"));
        //Announce if Game is over
      }
      else {
        alert('Invalid Move');
      }
      if (this.game.isOver()) {
        makeAllMovesInvalid();
        createCongratulations(this.game.currentPlayer);
      }
    });
  }

  makeMove($square) {

  }

  setupBoard() {
    const $ul = $('<ul>');
    $ul.css('display', 'flex');
    $ul.css('width', '500px');
    $ul.css('flex-wrap', 'wrap');
    $ul.css('list-style', 'none');
    let liArray = generateLiArray();
    $ul.append(liArray);
    this.$el.append($ul);
  }
}

function generateLiArray() {
  const arr = [];
  // while (arr.length < 9) {
  //   arr.push($li.clone());
  // }
  for (var i = 0; i < 3; i++) {
    for (var j = 0; j < 3; j++) {
      let $li = $('<li>');
      $li.css('width', '150px');
      $li.css('border', '5px solid black');
      $li.css('height', '150px');
      $li.data("pos", [i, j]);
      arr.push($li);
    }
  }

  return arr;
}

function makeAllMovesInvalid() {

  const $lis = $('li');

  for (var i = 0; i < $lis.length; i++) {
    if ($($lis[i]).text() == "") {
      console.log('hi');
      $($lis[i]).text(" ");
    }
  }
}

function createCongratulations(playerMark) {
  const winnerMark = (playerMark == 'x') ? 'O' : 'X';

  const $congrats = $('.congratulations');
  $congrats.css('display', 'block');
  $congrats.text(`CONGRATULATIONS ${winnerMark}!!!`);
}

module.exports = View;
