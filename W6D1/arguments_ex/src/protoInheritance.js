
Function.prototype.inherits = function(superClass) {
  function Surrogate() {}
  Surrogate.prototype = superClass.prototype;
  this.prototype = new Surrogate();
  this.prototype.constructor = this;
};

function MovingObject() {
}
MovingObject.prototype.sayhi = function() { console.log("hi"); };

function Ship() {
}
Ship.inherits(MovingObject);
Ship.prototype.saybye = function() { console.log("bye"); };

function Asteroid() {
}
Asteroid.inherits(MovingObject);
Asteroid.prototype.saylive = function() { console.log("live"); };
