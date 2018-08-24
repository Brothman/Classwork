const readline = require('readline');
const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});



function askIfGreaterThan(el1, el2, callback) {
  reader.question(`Is ${el1} greater than ${el2}?`, function(answer) {
    if (answer == 'yes' || answer == 'YES' || answer == 'Yes') {
      callback(true);
    }
    else {
      callback(false);
    }
  });
}

function innerBubbleSortLoop(arr, i, madeAnySwaps, outerBubbleSortLoop) {
  if (i >= (arr.length - 1)) {
    // console.log(`I am the [${arr}]`);
    outerBubbleSortLoop(madeAnySwaps);
  }
  else {
    askIfGreaterThan(arr[i], arr[i+1], function(isGreaterThan) {
      if (isGreaterThan) {
        let temp = arr[i];
        arr[i] = arr[i+1];
        arr[i+1] = temp;
        innerBubbleSortLoop(arr, i+1, true, outerBubbleSortLoop);
      }
      else {
        innerBubbleSortLoop(arr, i+1, madeAnySwaps, outerBubbleSortLoop);
      }
    });
  }
}

function absurdBubbleSort(arr, sortCompletionCallBack){
  function outerBubbleSortLoop(madeAnySwaps) {
    if (madeAnySwaps) {
      innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
    }
    else {
      sortCompletionCallBack(arr);
    }
  }

  outerBubbleSortLoop(true);
}

// innerBubbleSortLoop([3, 2, 1], 0, false, () => console.log("In outer loop"));
absurdBubbleSort([3, 2, 1], function (arr) {
  console.log("Sorted array: " + JSON.stringify(arr));
  reader.close();
});
