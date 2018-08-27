
function MovingObject(options) {
  this.pos = options.pos;
  this.velocity = options.velocity;
  this.radius = options.radius;
  this.color = options.color;
}
// //
// const canvasEl = document.getElementsByTagName("canvas")[0];
// const ctx = canvasEl.getContext("2d");
// ctx.clearRect(0, 0, canvas.width, canvas.height);
// canvasEl.height = window.innerHeight;
// canvasEl.width = window.innerWidth;

MovingObject.prototype.draw = function(ctx) {
  ctx.fillStyle = this.color;
  ctx.beginPath();

  ctx.arc(
    this.pos[0],
    this.pos[1],
    this.radius,
    0,
    2 * Math.PI,
    false
  );

  ctx.fill();
};


MovingObject.prototype.move = function() {
  this.pos[0] += this.velocity[0];
  this.pos[1] += this.velocity[1];
};

module.exports = MovingObject;
