class DOMNodeCollection {
  constructor(htmlArray) {
    this.htmlArray = htmlArray;
  }

  html(str){
    if (str === undefined){
      return this.htmlArray[0].innerHTML;
    }else{
      for (let i = 0; i < this.htmlArray.length; i++){
        this.htmlArray[i].innerHTML = str;
      }
    }
  }

  empty(){
    for (let i = 0; i < this.htmlArray.length; i++){
      this.htmlArray[i].innerHTML = "";
    }
  }

  append(arg){
    for (let i = 0; i < this.htmlArray.length; i++){
      if(typeof arg === "string") {
        this.htmlArray[i].innerHTML+= (arg);
      }
      else {
        arg.htmlArray.forEach((html) => {
          this.htmlArray[i].innerHTML += html.outerHTML;
        });
      }
    }
  }
}

module.exports = DOMNodeCollection;

// export default DOMNodeCollection;
