const Util = require('./utils.js');
const MovingObject = require('./moving_object.js');


function Asteroid(options) {
  this.COLOR = "#FF0000";
  this.RADIUS = 22;
  options.color = this.COLOR;
  options.radius = this.RADIUS;
  options.velocity = Util.randomVec(5);
  MovingObject.call(this, options);
}

Util.inherits(Asteroid, MovingObject);
module.exports = Asteroid;
// function Asteroid() {
//
// }
