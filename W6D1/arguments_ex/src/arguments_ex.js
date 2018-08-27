function sum(...args) {
  let sum = 0;
  for (let i = 0; i < args.length; i++) {
    sum += args[i];
  }
  return sum;
}

function sumTwo() {
  let args = Array.prototype.slice.call(arguments);
  let sum = 0;
  for (let i = 0; i < args.length; i++) {
    sum += args[i];
  }
  return sum;
}

// const myBind = () => {
//   let args = Array.from(arguments);
//   const context = args[0];
//   args = args.slice(1);
//   this.call(context, ...args);
// };

// Function.prototype.myBind = function() {
//   let thatArguments = Array.from(arguments);
//   const that = this;
//   return function() {
//     let newArgs = Array.from(arguments);
//     const context = thatArguments[0];
//     thatArguments = thatArguments.slice(1);
//     thatArguments = thatArguments.concat(newArgs);
//     return that.apply(context, thatArguments);
//   };
// };

Function.prototype.myBind = function(context, ...bindTimeArgs) {
  const that = this;
  return function(...callTimeArgs) {
    return that.apply(context, bindTimeArgs.concat(callTimeArgs));
  };
};

function curriedSum(numArgs) {
  const numbers = [];
  return function _curriedSum(num) {
    numbers.push(num);
    if (numbers.length == numArgs) {
      //This is a non-intuitve way to say I'm summing vs in Ruby where you can say numbers.reduce(&:+)
      return numbers.reduce((acc, el) => acc + el);
    }
    else {
      return _curriedSum;
    }
  };
}

Function.prototype.curry = function(numArgs) {
  const elements = [];
  const that = this;
  return function _curriedFunction(el) {
    elements.push(el);
    if (elements.length == numArgs) {
      //This is a non-intuitve way to say I'm summing vs in Ruby where you can say elements.reduce(&:+)
      return that.call(null, elements);
    }
    else {
      return _curriedFunction;
    }
  };
};

  function testSum(arrOfNums) {
  return arrOfNums.reduce((acc, el) => acc + el);
  }
