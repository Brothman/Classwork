// requre 'debugger';
const readline = require('readline');
const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});


class Game {
  constructor() {
    //Set a property for the stack, which can be an array *hint hint*
    this.towers = [[3, 2, 1], [], []];
  }

  run(completionCallBack) {
    // while(!this.isWon()){
    //   this.promptMove();
    // }
    if(!this.isWon()){
      this.promptMove(completionCallBack);
    }
    else {
      reader.close();
    console.log(`game over, you won. here is your final stack: [[${this.towers[0]}], [${this.towers[1]}], [${this.towers[2]}]]`);
    completionCallBack();
    }

    //until all three pieces are in order on not the first position
      //get move from current player
      //make move on the board
      //repeat
  }

  promptMove(completionCallBack) {
    console.log(`Current Stack: [[${this.towers[0]}], [${this.towers[1]}], [${this.towers[2]}]]`);
    let startTowerIdx, endTowerIdx;

    // reader.question("Where do you want to move from?", (answer1) => {
    //   reader.question("Where do you want to move to?", (answer2) => {
    //     startTowerIdx = parseInt(answer1);
    //     endTowerIdx = parseInt(answer2);
    //     console.log(startTowerIdx, endTowerIdx);
    //     // reader.close();
    //   });
    // });
    let that = this;

    reader.question("Where do you want to move from?", function(answer1) {
      // console.log(this);
      reader.question("Where do you want to move to?", function(answer2) {
        startTowerIdx = parseInt(answer1);
        endTowerIdx = parseInt(answer2);
        // console.log(this);
        that.move(startTowerIdx, endTowerIdx);
        that.run(completionCallBack);
        // console.log(startTowerIdx, endTowerIdx);
        // reader.close();
      });
    });

    return [startTowerIdx, endTowerIdx];
  }

  isValidMove(startTowerIdx, endTowerIdx){
    if(startTowerIdx === endTowerIdx){
      return false;
    }
    if(startTowerIdx < 0 || startTowerIdx > 2 || endTowerIdx < 0 || endTowerIdx > 2){
      return false;
    }

    let startTowerArr = this.towers[startTowerIdx];
    if(startTowerArr.length == 0){
      return false;
    }

    let startValue = startTowerArr[startTowerArr.length - 1];

    let endTowerArr = this.towers[endTowerIdx];
    let endValue = endTowerArr[endTowerArr.length - 1];
    if(endTowerArr.length == 0 || endValue > startValue){
      return true;
    }
    // return false;
    return false;
  }

  move(startTowerIdx, endTowerIdx){
    if(this.isValidMove(startTowerIdx, endTowerIdx)){
      let piece = this.towers[startTowerIdx].pop();
      this.towers[endTowerIdx].push(piece);
      return true;
    }
    else{
      return false;
    }
  }

  isWon(){
    if(this.towers[1].length == 3 || this.towers[2].length == 3 ){
      return true;
    }
    return false;
  }

}

let game = new Game();
// game.promptMove();
game.run(() => console.log("You're a champion!"));
