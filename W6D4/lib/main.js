const DOMNodeCollection = require('./dom_node_collection.js');

window.$l = $l;

function $l(selector){
  //has HTML element syntax
  if (selector[0] === '<') {
    let string = selector.slice(1, selector.length - 1);
    let el = document.createElement(string);
    const domNodeCollection = new DOMNodeCollection([el]);
    return domNodeCollection;
  }

//   let tempDiv = document.createElement('div');
//   tempDiv.innerHTML = selector;
//
//   if (selector instanceof HTMLElement) {
//     const domNodeCollection = new DOMNodeCollection([selector]);
//     return domNodeCollection;
//   }

const elementArrFake = document.querySelectorAll(selector);
const elementArrReal = Array.from(elementArrFake);
const domNodeCollection = new DOMNodeCollection(elementArrReal);
return domNodeCollection;
}
