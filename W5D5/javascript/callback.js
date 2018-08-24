function Clock() {
  const date = new Date();
  this.hours = date.getHours(); //@hours = date.getHours
  this.minutes = date.getMinutes();
  this.seconds = date.getSeconds();

  this.printTime();
  // const that = this;
    //
    // setInterval(()=>{
    //   console.log(this);
    //   this._tick();
    // },1000);

    // setInterval(function(){
    //   console.log(this);
    //   that._tick();
    // },1000);
    setInterval(this._tick.bind(this),1000);

}

Clock.prototype.printTime = function(){
  console.log(`${this.hours}:${this.minutes}:${this.seconds}`);
};

Clock.prototype._tick = function(){
  this.seconds += 1;
  if (this.seconds >= 60){
    this.seconds -= 60;
    this.minutes += 1;
  }

  if (this.minutes >= 60){
    this.minutes -= 60;
    this.hours += 1;
  }
  if (this.hours >= 24){
    this.hours -= 24;
  }
  // Clock.prototype.printTime();
  // console.log(this);
  this.printTime();
};

const clock = new Clock();
