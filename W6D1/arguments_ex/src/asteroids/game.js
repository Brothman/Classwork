const Asteroid = require("./asteroid.js");

function Game() {
  this.DIM_X = 500;
  this.DIM_Y = 500;
  this.NUM_ASTEROIDS = 4;
  this.asteroids = [new Asteroid({pos: randomPos()})];

  this.ctx = document.getElementsByTagName("canvas")[0].getContext("2d");

  addAsteroids();
}

function addAsteroids() {
  for (var i = 0; i < this.NUM_ASTEROIDS; i++) {
    this.asteroids.push(new Asteroid({pos: randomPos()}));
  }
}

function randomPos() {
  return [Math.random() * this.DIM_X, Math.random() * this.DIM_Y];
}

Game.prototype.draw = function(ctx) {
  this.ctx.clearRect(0, 0, this.DIM_X, this.DIM_Y);
  for (var i = 0; i < this.asteroids.length; i++) {
    this.asteroids[i].draw(this.ctx);
  }
};

Game.prototype.moveObjects = function() {
  for (var i = 0; i < this.asteroids.length; i++) {
    this.asteroids[i].move();
  }
};

// const g = new Game();
//
// setInterval(g.draw, 20);
// setInterval(g.moveObjects, 20);
module.exports = Game;
